import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltage_lab_bd_job_circular/theme/ThemeProvider.dart';
import 'package:voltage_lab_bd_job_circular/theme/themeColor.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {



  // void postshare(BuildContext context, String link) async {
  //   final String text = link;
  //   final RenderBox box = context.findRenderObject() as RenderBox;
  //   await Share.share(text,
  //       subject: "Voltage Lab",
  //       sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  // }
  //theme fucntion add
  String _selectorColor = "Dark";
  List<String> _colors =["Dark","Light",];
  void onThemeChangeNofifier(String value,ThemeProvider? themeProvider)async{
    if(value=="Dark"){
      themeProvider = themeProvider!.setTheme(darkTheme);
    }
    else if(value=="Light"){
      themeProvider = themeProvider!.setTheme(ligtTheme);
    }
    final prefs =await SharedPreferences.getInstance();
    prefs.setString("ThemeModee", value);
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    themeProvider.getTheme;
    return Scaffold(
      appBar: AppBar(

        title: Text("সেটিংস",),
        // leading: IconButton(onPressed: (){
        //   // box.get('email') != '' && box.get('type') == '2'
        //   //     ?  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>HomeInitPage()))
        //   //     :  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>HomePage2()));
        //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>HomePage2()));
        // }, icon: Icon(Icons.arrow_back)),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              showThemeDialog(themeProvider);
            },
            child: Custrom_design("থিম পরিবর্তন",Icons.dark_mode_outlined),
          ),
        ],
      ),
    );
  }
  Widget Custrom_design(String txt,dynamic icon){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5.0,
                spreadRadius: 3.0,
                offset: Offset(0,3)
            )
          ]
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(txt),
      ),
    );
  }
  void showThemeDialog(ThemeProvider themeProvider){
    showDialog(
        context: context,
        builder: (_) =>StatefulBuilder(
            builder:(BuildContext context,StateSetter setState){
              return AlertDialog(

                content: Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioGroup<String?>.builder(
                        groupValue:
                        themeProvider?.getTheme == darkTheme?"Dark":
                        themeProvider?.getTheme == ligtTheme?"Light":
                        "Green",
                        onChanged: (val){
                          setState((){
                            _selectorColor = val!;
                          });
                          onThemeChangeNofifier(_selectorColor,themeProvider);
                          Navigator.pop(context);
                        },
                        items: _colors,
                        itemBuilder: (item)=>RadioButtonBuilder(item!),
                      ),
                    ],
                  ),
                ),
              );
            }
        )
    );
  }

}

