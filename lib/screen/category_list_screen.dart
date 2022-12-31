
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:voltage_lab_bd_job_circular/screen/post_details_screen.dart';
import 'package:voltage_lab_bd_job_circular/services/category_service.dart';
import 'package:voltage_lab_bd_job_circular/services/utilities/global_color.dart';
import 'package:voltage_lab_bd_job_circular/services/utilities/global_text_style.dart';
import 'package:voltage_lab_bd_job_circular/theme/themeColor.dart';

import '../theme/ThemeProvider.dart';


class CategoryListScreen extends StatefulWidget {

String? url;
  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();

  CategoryListScreen({this.url});
}


class _CategoryListScreenState extends State<CategoryListScreen> {

  @override
  TextEditingController searhControler = TextEditingController();

  Widget build(BuildContext context) {

    CategoryServies servies = CategoryServies();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:   Padding(
          padding: EdgeInsets.only(
              top: 40,
              bottom: 40
          ),
          child: TextFormField(
            autofocus: false,
            cursorColor: Colors.white,
            controller: searhControler,
            onChanged: (value){
              setState(() {
              });
            },

             style: TextStyle(fontSize: 20.0,),
            decoration: InputDecoration(
                hintText: "Seach for Designe",
                hintStyle: TextStyle(fontSize: 20.0, ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                prefixIcon: const Icon(
                      Icons.search_outlined,
                    ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
               )
            ),

          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: servies.getAllCategory("${widget.url}",1802),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(

                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]["title"]['rendered'];

                          if(searhControler.text.isEmpty){
                            return ReusableWidget(snapshot.data![index]["id"].toString(),snapshot.data![index]["title"]['rendered'].toString(),snapshot.data![index]["yoast_head_json"]['og_image'][0]['url'].toString() );
                          }
                          else if(name.toLowerCase().contains(searhControler.text.toLowerCase())){
                            return ReusableWidget(snapshot.data![index]["id"].toString(),snapshot.data![index]["title"]['rendered'].toString(),snapshot.data![index]["yoast_head_json"]['og_image'][0]['url'].toString() );
                          }
                          else{
                            return Container();
                          }
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ReusableWidget( String id ,String  name,String image_url,){
    final themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostDetailsScreen(
            image_url:image_url ,
           categoryName:name,
          categoryId:id,
        )));
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: themeProvider?.getTheme == darkTheme ?Colors.black12:
                themeProvider?.getTheme == ligtTheme ?Colors.grey.shade100:
                Colors.grey.shade100,
                blurRadius: 5.0,
                spreadRadius: 2.0,
                offset: Offset(
                  1.0, // horizontal, move right 10
                  5.0, // vertical, move down 10
                ),
              )
            ],
            // color: Colors.indigoAccent,
            color: themeProvider?.getTheme == darkTheme ?Colors.black12:
            themeProvider?.getTheme == ligtTheme ?Colors.white:
            Colors.grey.shade100,
            borderRadius: BorderRadius.all(
                Radius.circular(30)
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(name,style: GlobalStyle.titleTextStyle.copyWith(color:GlobalColor.lightblueTextColor),),
                subtitle: Text("xyz company"),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.calendar_month),
                  Text("Deadine:\n Apr 4,2022",),
                  SizedBox(width: 60,),
                  Icon(Icons.work),
                  Text("Deadine:\n Apr 4,2022",),
                ],
              ),
              ListTile(
                subtitle: Text("Bahelor's degree in Computer science",style: TextStyle(fontSize: 17 ),),
                title: Text("Education",style: TextStyle(fontSize: 15 ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
