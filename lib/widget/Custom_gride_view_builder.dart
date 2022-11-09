import 'package:flutter/material.dart';

Widget Custrom_Gridview(int count,height, retur ){
  return Container(
    child: count>=1?SizedBox(
      width: double.infinity,
      height:height,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: count ,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            // childAspectRatio: 2/1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 8),
        itemBuilder: (context, index) {
          return retur(index);
        },
      ),
    ):Center(child: Text('No Data Found Yet !!',style: TextStyle
      (fontSize: 20,color: Colors.red),),),
  );
}