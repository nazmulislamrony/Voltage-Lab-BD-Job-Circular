import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:voltage_lab_bd_job_circular/home_init_page.dart';
class Slash extends StatefulWidget {
  const Slash({Key? key}) : super(key: key);

  @override
  State<Slash> createState() => _SlashState();
}

class _SlashState extends State<Slash> {
  late StreamSubscription subscription;
  bool hasInternet=false;

  void initState(){
    subscription = Connectivity().onConnectivityChanged.listen(( result) {
    setState(() {
      hasInternet=(result != ConnectivityResult.none);

    });
    });

    super.initState();
  }

  void dispose(){
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:Column(
          children: [
            SizedBox(
              height: 210,
            ),
            Image.asset("images/splash.png"),
            SizedBox(
              height: 90,
            ),
            hasInternet?Text("NO INTERNET"):navigator(),
          ],

        ),
      ),
    );
  }
   navigator(){
   SchedulerBinding.instance.addPostFrameCallback((_) {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home_init_page()));
   }
   );

  }
}
