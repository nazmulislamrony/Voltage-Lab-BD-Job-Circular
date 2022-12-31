import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voltage_lab_bd_job_circular/services/utilities/app_url.dart';

class CategoryServies{

  Future<List<dynamic>> getAllCategory(String url,int id)async{
    print(url);
    var data;
    final response = await http.get(Uri.parse(url+"/wp-json/wp/v2/posts?categories=${id}&_fields[]per_page=10&_fields[]=id&_fields[]=title&_fields[]=yoast_head_json.og_image"));
    if(response.statusCode == 200){
      data =jsonDecode(response.body);

      return data;
    }else{
     throw Exception("Error");
    }
  }

  Future<void> getPostDetails()async{
    var data;
    final response = await http.get(Uri.parse(ApiUrl.baseCategoryList));
    if(response.statusCode == 200){
      print("api hid");
      data =jsonDecode(response.body);
      print(data);
      return data;

    }else{
      throw Exception("Error");
    }
  }

}