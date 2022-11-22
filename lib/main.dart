import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:voltage_lab_bd_job_circular/login_Section/login.dart';
import 'package:voltage_lab_bd_job_circular/provider/AuthProvider.dart';
import 'package:voltage_lab_bd_job_circular/provider/Database_provider.dart';
import 'package:voltage_lab_bd_job_circular/theme/ThemeProvider.dart';
import 'package:voltage_lab_bd_job_circular/theme/themeColor.dart';

import 'Page/Home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');

  await firebase_core.Firebase.initializeApp();
  ThemeData activeTheme;
  SharedPreferences.getInstance().then((pref) {
    var themeColor= pref.getString("ThemeModee")??"Light";
    if(themeColor=="Dark"){
      activeTheme=darkTheme ;
    }else {
      activeTheme=ligtTheme ;
    }
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Pdf_Provider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider(activeTheme)),
      ],
      child: MyApp(email:email,),
    ));

  });



  // runApp(const MyApp());
}
class MyApp extends StatefulWidget {

  var email;
  @override
  State<MyApp> createState() => _MyAppState();

  MyApp({required this.email});
}

class _MyAppState extends State<MyApp> {
  @override

  void checklogin()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var email = preferences.getString('email');
  }

  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      theme: themeProvider.getTheme,
      debugShowCheckedModeBanner: false,
      home:widget.email== null?LoginPage():Home(),
    );
  }
}
//djkfdfjkdjf