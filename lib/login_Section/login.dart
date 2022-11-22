import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltage_lab_bd_job_circular/login_Section/registation.dart';
import 'package:voltage_lab_bd_job_circular/widget/from_decoration.dart';

import '../Page/Home.dart';
import '../provider/AuthProvider.dart';
import 'ForgetPasswort.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  bool _obscureTextPassword = true;
  @override
  Widget build(BuildContext context) {
    final authProider = Provider.of<AuthProvider>(context);
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.ideographic,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: size.height*0.22,
              ),
              Text("Hello",style: TextStyle(
                fontSize: size.height*0.1,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
                fontFamily:"RaleWay",
              ),),
              Text("Sign in to your account",style: TextStyle(
                fontSize: size.height*0.029,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
                fontFamily:"RaleWay",
              ),),
              SizedBox(
                height: size.height*0.060,
              ),
              Padding(padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    SizedBox(height: size.height*0.020,),
                    _textFieldBuilder("Username / Email",Icon(Icons.account_circle),authProider),
                    SizedBox(height:  size.height*0.026,),
                    _textFieldBuilder("Password",Icon(Icons.lock),authProider),
                  ],
                ),
              ),
              Padding(padding:EdgeInsets.only(left: 100),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 InkWell(
                   onTap: (){
                     Navigator.pushReplacement(
                         context, MaterialPageRoute(builder: (context)=>forgetPasswort()));
                   },
                   child: Text('Forget your password',style:TextStyle(fontWeight: FontWeight.bold,fontSize: size.height*0.020,  letterSpacing: 1.0,),),
                 ),

               ],
             ),
              ),
              SizedBox(
                height: size.height*0.060,
              ),
              Padding(padding:EdgeInsets.only(left: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(onPressed: ()async{
                      try{
                        await authProider.signIn("${authProider.usersModel.Email}","${authProider.usersModel.Password}" );
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        preferences.setString('email', "${authProider.usersModel.Email}");
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Home()));
                      }catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Password invilid',
                            )));
                        print('error caught:$e');
                      }
                    },
                        icon: Text("Sign in",style: TextStyle( fontSize: size.height*0.050,color: Colors.black,fontWeight: FontWeight.bold),),
                        label: Container(
                          width: size.height*0.060,
                          height: size.height*0.050,
                          decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(
                                colors: [Colors.deepOrange, Colors.orange],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(0.5, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp
                            ),
                          ),
                          child: Icon(Icons.arrow_forward,size: 30,color: Colors.white,),
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height*0.050,
              ),
              TextButton.icon(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>registactionPage()));
              },
                  icon: Text("Don't have an account?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  label: Text("Create",style: TextStyle(  decoration: TextDecoration.underline,fontWeight: FontWeight.bold),)),
            ],
          ),
        ),
      ),
    );
  }
  Widget _textFieldBuilder(String ? hintTxt ,Icon? icon,AuthProvider authProvider){
    Size size=MediaQuery.of(context).size;
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.deepPurpleAccent.withOpacity(0.1),
                blurRadius: 5.0,
                spreadRadius: 3.0,
                offset: Offset(0,3)
            )
          ]
      ),
      child: TextFormField(
        cursorColor: Colors.black12,
        keyboardType: hintTxt=='Email Address'?TextInputType.emailAddress
            :TextInputType.text,
        decoration: FormDecoration.copyWith(
          labelText: hintTxt,
          labelStyle: TextStyle(
            fontSize: size.height*0.020,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
            fontFamily:"RaleWay",
          ),
          prefixIcon: icon,
          suffixIcon: hintTxt=="Password"? Icon(
            _obscureTextPassword?
                Icons.remove_red_eye_sharp
                :Icons.remove_red_eye_outlined,
          ):null

        ),
        obscureText:hintTxt=="Password"? _obscureTextPassword:false,
        onTap: (){
          if(hintTxt=='Password'){
            _toggleLogin();
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill All filled';
          }
          return null;
        },
        onChanged: (value){
          setState(() {
            hintTxt=="Username / Email"?authProvider.usersModel.Email=value
                :authProvider.usersModel.Password=value;
          });
        },
      ),
    );
  }
  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
}
