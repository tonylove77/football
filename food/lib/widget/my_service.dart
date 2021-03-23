import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food/utility/my_style.dart';
import 'package:food/widget/Show_cartoon_list.dart';
import 'package:food/widget/information_login.dart';

class Myservice extends StatefulWidget {
  @override
  _MyserviceState createState() => _MyserviceState();
}

class _MyserviceState extends State<Myservice> {
  String name, email;
  Widget currentwidget = ShowCartoonList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findNameAnEmail();
  }

  Future<Null> findNameAnEmail() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event.displayName;
          email = event.email;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
      ),
      drawer: buildDrawer(),
      body: currentwidget,
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              buildUserAccountsDrawerHeader(),
              buildListTileShowCartoonList(),
              buildListTileInformation()
            ],
          ),
          buildSignOut(),
        ],
      ),
    );
  }

  ListTile buildListTileShowCartoonList() {
    return ListTile(
      leading: Icon(
        Icons.sports_football_outlined,
        size: 36,
      ),
      title: Text('Show Football List'),
      subtitle: Text('Show All football in my stock'),
      onTap: () {
        setState(() {
          currentwidget = ShowCartoonList();
        });
        Navigator.pop(context);
      },
    );
  }

   ListTile buildListTileInformation() {
    return ListTile(
      leading: Icon(
        Icons.perm_device_info,
        size: 36,
      ),
      title: Text('Information'),
      subtitle: Text('Information of User Login'),
      onTap: () {
        setState(() {
          currentwidget = Information();
        });
        Navigator.pop(context);
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
         gradient: RadialGradient(
            center: Alignment(0, -0.33),
            radius: 1.0,
            colors: <Color>[Colors.white, MyStyle().primaryColor],
          ),
        
      ),
      accountName: Text(name == null ? 'Name' : name),
      accountEmail: Text(email == null ? 'email' : email),
      currentAccountPicture: Image.asset('images/lo.png'),
    );
  }

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/authen', (route) => false));
            });
          },
          tileColor: MyStyle().darkColor,
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 36,
          ),
          title: MyStyle().titleH2White('Sign Out'),
          subtitle: MyStyle().titleH3white('Sign Out & Go to Home'),
        ),
      ],
    );
  }
}
