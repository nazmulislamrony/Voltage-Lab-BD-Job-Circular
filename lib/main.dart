import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltage_lab_bd_job_circular/home_init_page.dart';
import 'package:voltage_lab_bd_job_circular/provider/Database_provider.dart';
import 'package:voltage_lab_bd_job_circular/slash.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Pdf_Provider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: home_init_page(),
        ));
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home:Slash(),
    // );
  }
}
