import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:voltage_lab_bd_job_circular/home_init_page.dart';
import 'package:voltage_lab_bd_job_circular/provider/Database_provider.dart';
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
    final Category_provider Category = Provider.of<Category_provider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Category.isloading?Center(
        child: CircularProgressIndicator(),
        // child:Column(
        //   children: [
        //     SizedBox(
        //       height: 100,
        //     ),
        //     Image.asset("images/splash.png"),
        //     // StreamBuilder<QuerySnapshot>(
        //     //   stream:FirebaseFirestore.instance.collection("Parent").snapshots(),
        //     //   builder: (context,snapshots){
        //     //     if (!snapshots.hasData) {
        //     //       return Center(
        //     //         child: CircularProgressIndicator(),
        //     //       );
        //     //     }
        //     //     return  navigator();
        //     //   },
        //     // )
        //
        //   ],
        //
        // ),
      ):navigator(Category.CategoryList),
    );
  }
   navigator(category){
   SchedulerBinding.instance.addPostFrameCallback((_) {
     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home_init_page(category)));
   }
   );

  }
}
