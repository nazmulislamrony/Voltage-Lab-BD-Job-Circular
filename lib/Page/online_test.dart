import 'package:flutter/material.dart';
class online_test extends StatefulWidget {
  const online_test({Key? key}) : super(key: key);

  @override
  State<online_test> createState() => _online_testState();
}

class _online_testState extends State<online_test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BD ALL Job",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),

      ),
    );
  }
}
