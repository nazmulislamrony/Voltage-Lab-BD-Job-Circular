import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltage_lab_bd_job_circular/model/categorymodel.dart';
import 'package:voltage_lab_bd_job_circular/provider/Database_provider.dart';
import 'package:voltage_lab_bd_job_circular/services/utilities/global_text_style.dart';
import 'package:voltage_lab_bd_job_circular/theme/ThemePage.dart';
import 'package:voltage_lab_bd_job_circular/theme/ThemeProvider.dart';
import 'package:voltage_lab_bd_job_circular/theme/themeColor.dart';
import 'category_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final database = FirebaseDatabase.instance.ref();

  void postshare(BuildContext context, String link) async {
    final String text = link;
    final RenderBox box = context.findRenderObject() as RenderBox;
    await Share.share(text,
        subject: "Voltage Lab",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
  }

  List<Categorymodels> CategorytList = [];
  List<Categorymodels> SubCategorytList = [];
  int count = 0;
  void _custominitState(Category) {
    setState(() {
      count++;
    });
    CategorytList = Category.CategoryList;
    SubCategorytList = Category.subCategoryList;
    Category.getCategory();
  }

  void initState() {
    final Category_provider Category =
        Provider.of<Category_provider>(context, listen: false);
    Category.getSubCollection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Category_provider Category = Provider.of<Category_provider>(context);
    if (count == 0) _custominitState(Category);
    final themeProvider = Provider.of<ThemeProvider>(context);
    Category.getSubCollection();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "BD ALL Job",
             style:GlobalStyle.appberTextStyle,

          ),
          actions: [
            IconButton(
                onPressed: () {
                  postshare(context, "www.facebook.com");
                },
                icon: Icon(Icons.share)),
            PopupMenuButton(itemBuilder: (context) {
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
            }, onSelected: (value) {
              if (value == 0) {
                print("My account menu is selected.");
              } else if (value == 1) {
                print("Settings menu is selected.");
              } else if (value == 2) {
              } else if (value == 3) {
                logout();
              } else if (value == 4) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              }
            }),
          ],
        ),
        body: RefreshIndicator(
          color: Colors.white,
          backgroundColor: Colors.blue,
          strokeWidth: 4.0,
          onRefresh: () async {
            return Future<void>.delayed(const Duration(seconds: 3));
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: false,
                        scrollDirection: Axis.vertical,
                        itemCount: CategorytList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Icon(
                                    Icons.work,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${Category.CategoryList[index].name}",
                                    style: GlobalStyle.parentTextStyle,
                                    // style: TextStyle(
                                    //     fontWeight: FontWeight.bold,
                                    //     fontSize: 20),
                                  )
                                ],
                              ),
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("Parent")
                                      .doc(Category.idlist[index])
                                      .collection("childdata")
                                      .snapshots(),
                                  builder: (context, snapshots) {
                                    if (!snapshots.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 130,
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshots.data!.docs.length,
                                        physics: BouncingScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 200,
                                                // childAspectRatio: 2/1.5,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 8),
                                        itemBuilder: (context, index) {
                                          QueryDocumentSnapshot x =
                                              snapshots.data!.docs[index];
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CategoryListScreen(
                                                            url: x['url'],
                                                          )));
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
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
                                                  children: [
                                                    ClipRRect(
                                                        child: Image.asset(
                                                      "assets/logo-icon-category.png",
                                                      height:
                                                          size.height * 0.08,
                                                      width: size.width * 0.25,
                                                      fit: BoxFit.fill,
                                                    )),
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    Text(
                                                      x['name'],
                                                      style: GlobalStyle.cartTextStyle,

                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
