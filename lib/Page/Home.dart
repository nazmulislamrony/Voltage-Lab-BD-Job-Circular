import 'package:flutter/material.dart';
import 'package:voltage_lab_bd_job_circular/widget/Custom_gride_view_builder.dart';

import '../widget/Custom_Header.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BD ALL Job",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.share)),
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child:Column(
            children: [
              custom_herderText("চাকরির বিজ্ঞপ্তি", Icon(Icons.card_giftcard_outlined,size: 30,),),
              Custrom_Gridview(10,110.0, custom_design ),
              SizedBox(height: 10,),
              custom_herderText("চাকরির বিজ্ঞপ্তি", Icon(Icons.card_giftcard_outlined,size: 30,),),
              Custrom_Gridview(10,110.0, custom_design ),
              SizedBox(height: 10,),
              custom_herderText("চাকরির বিজ্ঞপ্তি", Icon(Icons.card_giftcard_outlined,size: 30,),),
              Custrom_Gridview(10,110.0, custom_design ),
              SizedBox(height: 10,),
              custom_herderText("চাকরির বিজ্ঞপ্তি", Icon(Icons.card_giftcard_outlined,size: 30,),),
              Custrom_Gridview(10,110.0, custom_design ),
              SizedBox(height: 10,),
              custom_herderText("চাকরির বিজ্ঞপ্তি", Icon(Icons.card_giftcard_outlined,size: 30,),),
              Custrom_Gridview(10,110.0, custom_design ),
              SizedBox(height: 10,),
            ],
          ) ,
        )
      ),
    );
  }
  Widget custom_design(int index){
    Size size = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
        color: Colors.blueGrey,
        child: Column(
          children: [
        ClipRRect(
        child: Image.asset("images/bd_job_circular.png",
          height: size.height*0.11,
          width: double.maxFinite,
          fit: BoxFit.fill,
        )),
            SizedBox(
              height: 7,
            ),
            Text("সরকারি",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
          ],
        ),
      ) ,
    );
  }
}
