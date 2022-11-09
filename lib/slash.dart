import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
class Slash extends StatefulWidget {
  const Slash({Key? key}) : super(key: key);

  @override
  State<Slash> createState() => _SlashState();
}

class _SlashState extends State<Slash> {
  late StreamSubscription subscription;
  bool hasInternet=true;
  // ConnectivityResult result=ConnectivityResult.none;
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
  // void internetcheck(){
  //   AlertDialog(
  //     title: Text("On Internet connection"),
  //   );
  // }
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
            hasInternet? CircularProgressIndicator():Text("NO INTERNET"),
          ],

        ),
      ),
    );
  }
}
