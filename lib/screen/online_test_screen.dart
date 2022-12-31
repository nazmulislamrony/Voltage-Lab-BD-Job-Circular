import 'package:flutter/material.dart';
class OnlineTestScreen extends StatefulWidget {
  const OnlineTestScreen({Key? key}) : super(key: key);

  @override
  State<OnlineTestScreen> createState() => _OnlineTestScreenState();
}

class _OnlineTestScreenState extends State<OnlineTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BD ALL Job",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),

      ),
    );
  }
}
