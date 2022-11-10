import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:voltage_lab_bd_job_circular/home_init_page.dart';
import 'package:voltage_lab_bd_job_circular/provider/Database_provider.dart';
import 'package:voltage_lab_bd_job_circular/theme/ThemeProvider.dart';
import 'package:voltage_lab_bd_job_circular/theme/themeColor.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
        ChangeNotifierProvider(create: (context) => ThemeProvider(activeTheme)),
      ],
      child: MyApp(),
    ));

  });



  // runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: themeProvider.getTheme,
      debugShowCheckedModeBanner: false,
      home:home_init_page(),
    );
  }
}
