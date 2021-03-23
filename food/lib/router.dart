import 'package:flutter/material.dart';
import 'package:food/widget/authen.dart';
import 'package:food/widget/my_service.dart';
import 'package:food/widget/register.dart';

final Map<String, WidgetBuilder> routes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/myService': (BuildContext context) => Myservice(),
};
