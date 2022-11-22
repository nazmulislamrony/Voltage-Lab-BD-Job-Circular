

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltage_lab_bd_job_circular/model/pdf_model.dart';
import 'package:voltage_lab_bd_job_circular/provider/Database_provider.dart';
import 'package:voltage_lab_bd_job_circular/theme/ThemePage.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final database=FirebaseDatabase.instance.ref();


  void postshare(BuildContext context, String link) async {
    final String text = link;
    final RenderBox box = context.findRenderObject() as RenderBox;
    await Share.share(text,
        subject: "Voltage Lab",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
  void logout()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
  }

  List <CategoryClass> CategorytList=[];
  List <CategoryClass> SubCategorytList=[];

  int count=0;
  void _custominitState(Category){
    setState(() {
      count++;
    }
    );
    CategorytList=Category.CategoryList;
    SubCategorytList=Category.subCategoryList;
    Category.getCategory();
    Category.getSubCategory();
    Category.getSubCollection();
  }
  @override
  Widget build(BuildContext context) {
    final dailyspecialRef=database.child("category");
    final Pdf_Provider Category = Provider.of<Pdf_Provider>(context);

    if(count==0) _custominitState(Category);
    return Scaffold(
      appBar: AppBar(
        title: Text("BD ALL Job",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
        actions: [
          IconButton(onPressed: (){
            postshare(context,"www.facebook.com");
          }, icon: Icon(Icons.share)),
          PopupMenuButton(
              itemBuilder: (context){
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("আরো অ্যাপ্স"),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text("অ্যাপটিতে ৫ স্টার দিন"),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text("অ্যাপ ফিডব্যাক"),
                  ),

                  PopupMenuItem<int>(
                    value: 3,
                    child: Text("সোশ্যাল মিডিয়া"),
                  ),
                  PopupMenuItem<int>(
                    value: 4,
                    child: Text("সেটিং"),
                  ),
                ];
              },
              onSelected:(value){
                if(value == 0){
                  print("My account menu is selected.");
                }else if(value == 1){
                  print("Settings menu is selected.");
                }else if(value == 2){

                }else if(value == 3){
                  logout();
                }else if(value == 4){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                }
              }
          ),
        ],
      ),
      body:
        Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: CategorytList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(Icons.card_giftcard_outlined),
                                SizedBox(width: 10,),
                                Text("${Category.CategoryList[index].name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                              ],
                            ),

                            // ListView.builder(
                            //     physics: BouncingScrollPhysics(),
                            //     shrinkWrap: true,
                            //     scrollDirection: Axis.vertical,
                            //     itemCount: CategorytList.length,
                            //     prototypeItem: Text("${Category.CategoryList[index].name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            //     itemBuilder:(BuildContext context, int index){
                            // //       return Text("${index}");
                            // //     }
                            // // )

                            SizedBox(
                              width: double.infinity,
                              height:110,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:SubCategorytList.length,
                                physics: BouncingScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    // childAspectRatio: 2/1.5,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return custom_design(index);
                                },
                              ),
                            )

                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        )

    );
  }
  Widget custom_design(int index){
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: (){
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>items_list(
          //   url:CategorytList[index].url ,
          // )));
        },
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
              Text("${SubCategorytList[index].name}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
            ],
          ),
        ) ,


    );
  }
}
