import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food/models/cartoon_models.dart';
import 'package:food/utility/my_style.dart';

class ShowCartoonList extends StatefulWidget {
  @override
  _ShowCartoonListState createState() => _ShowCartoonListState();
}

class _ShowCartoonListState extends State<ShowCartoonList> {
  List<Widget> widgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print('initialize Success');
      await FirebaseFirestore.instance
          .collection('ball')
          .orderBy('name')
          .snapshots()
          .listen((event) {
        print('snapshot = ${event.docs}');
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          print('map = $map');
          CartoonModel model = CartoonModel.fromMap(map);
          print('name = ${model.name}');
          setState(() {
            widgets.add(createWidget(model));
          });
        }
      });
    });
  }

  Widget createWidget(CartoonModel model) => Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 140,
                child: Image.network(model.cover),
              ),
              SizedBox(
                height: 16,
              ),
              MyStyle().titleH2(model.name),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.length == 0
          ? Center(child: CircularProgressIndicator())
          : GridView.extent(maxCrossAxisExtent: 200, children: widgets),
    );
  }
}
