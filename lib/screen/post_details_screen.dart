import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:voltage_lab_bd_job_circular/services/utilities/global_text_style.dart';
class PostDetailsScreen extends StatefulWidget {
  String categoryName;
  String image_url;
  String categoryId;
   PostDetailsScreen({Key? key, required this.image_url,required this.categoryName,required this.categoryId}) : super(key: key);

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  var data;
  Future<void> getPostDetails(String categoryId)async{
    final response = await http.get(Uri.parse("https://www.banglacyber.com/wp-json/wp/v2/posts/${categoryId}?_fields[]=content"));
    if(response.statusCode == 200){
      data =jsonDecode(response.body.toString());
      return data;
    }else{
      throw Exception("Error");
    }
  }
  @override
  Widget build(BuildContext context) {
    print("image url${widget.image_url}");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName,style: GlobalStyle.appberTextStyle,),
      ),
      body:SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network("${widget.image_url}"),
              ),
              FutureBuilder(
                future:getPostDetails("${widget.categoryId}"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print(!snapshot.hasData);
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Html(
                      data: data['content']['rendered'].toString(),
                      onLinkTap: (url, _, __, ___) async {
                        print("-----------------------"+url.toString());
                      },
                      style: {
                        "p": Style(
                            fontSize: FontSize(18),
                            fontFamily: 'SolaimanLipi',
                            lineHeight: LineHeight(1.8)),
                        "li": Style(
                            fontSize: FontSize(16), fontFamily: 'SolaimanLipi'),
                        "alt": Style(
                            fontSize: FontSize(16),
                            fontFamily: 'SolaimanLipi'),
                        "strong": Style(
                            fontSize: FontSize(18), fontFamily: 'SolaimanLipi'),
                        "h1": Style(
                            fontSize: FontSize(24), fontFamily: 'SolaimanLipi'),
                        "h2": Style(
                            fontSize: FontSize(22), fontFamily: 'SolaimanLipi'),
                        "h3": Style(
                            fontSize: FontSize(18), fontFamily: 'SolaimanLipi'),
                        "h4": Style(
                            fontSize: FontSize(16), fontFamily: 'SolaimanLipi'),
                        "h5": Style(
                            fontSize: FontSize(12), fontFamily: 'SolaimanLipi'),
                        "h6": Style(
                            fontSize: FontSize(10), fontFamily: 'SolaimanLipi')
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
