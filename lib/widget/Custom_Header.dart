import 'package:flutter/material.dart';
Widget custom_herderText(String text,Icon? icon){
  return  Row(
    children: [
      icon!,
      SizedBox(width: 10,),
      Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
    ],
  );
}