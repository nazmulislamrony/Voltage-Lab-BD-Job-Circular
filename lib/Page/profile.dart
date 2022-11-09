import 'package:flutter/material.dart';

import '../widget/Custom_Header.dart';
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BD ALL Job",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_outlined))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: 50,),
          CircleAvatar(
            radius: 100,
            backgroundImage:AssetImage("images/bd_job_circular.png"),
          ),
          SizedBox(height: 10,),
          Padding(
              padding:EdgeInsets.only(left:60),
            child: Column(
              children: [
                custom_herderText("চাকরির বিজ্ঞপ্তি", Icon(Icons.card_giftcard_outlined,size: 30,),),
                SizedBox(height: 10,),
                custom_herderText("চাকরির বিজ্ঞপ্তি", Icon(Icons.card_giftcard_outlined,size: 30,),),
                SizedBox(height: 10,),
                custom_herderText("চাকরির বিজ্ঞপ্তি", Icon(Icons.card_giftcard_outlined,size: 30,),),
                SizedBox(height: 10,),
                custom_herderText("চাকরির বিজ্ঞপ্তি", Icon(Icons.card_giftcard_outlined,size: 30,),),
              ],
            ),
          ),



        ],
      ),
    );
  }
}
