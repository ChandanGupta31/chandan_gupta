import 'package:chandan_gupta/project/certificate.dart';
import 'package:chandan_gupta/project/contact.dart';
import 'package:chandan_gupta/project/project.dart';
import 'package:chandan_gupta/utils/initial.dart';
import 'package:chandan_gupta/utils/my_app.dart';
import 'package:chandan_gupta/utils/my_web.dart';
import 'package:flutter/cupertino.dart';

import '../project/home.dart';

Map<String, WidgetBuilder> route = {
  '/' : (context) => Initial(),
  '/app' : (context) => MyApp(page: 0,),
  '/web' : (context) => MyWeb(page: 0,),
  '/home' : (context) => Home(),
  '/project' : (context) => Project(),
  '/certificate' : (context) => Certificate(),
  '/contact' : (context) => Contact(),
};