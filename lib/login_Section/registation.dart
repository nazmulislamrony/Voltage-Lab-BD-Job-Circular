import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltage_lab_bd_job_circular/widget/from_decoration.dart';

import '../provider/AuthProvider.dart';
import 'login.dart';
class registactionPage extends StatefulWidget {
  const registactionPage({Key? key}) : super(key: key);

  @override
  State<registactionPage> createState() => _registactionPageState();
}

class _registactionPageState extends State<registactionPage> {
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
                height: size.height*0.17,
              ),
              Text("Create account",style: TextStyle(
                fontSize: size.height*0.050,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
                fontFamily:"RaleWay",
              ),),
              SizedBox(
                height: size.height*0.020,
              ),
              Padding(padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    SizedBox(height: size.height*0.020,),
                    _textFieldBuilder("Username / Email",Icon(Icons.account_circle),authProider),
                    SizedBox(height:  size.height*0.026,),
                    _textFieldBuilder("Password",Icon(Icons.lock),authProider),
                    SizedBox(height:  size.height*0.026,),
                    _textFieldBuilder("Email",Icon(Icons.email),authProider),
                    SizedBox(height:  size.height*0.026,),
                    _textFieldBuilder("Call",Icon(Icons.call),authProider),
                  ],
                ),
              ),
              SizedBox(
                height: size.height*0.010,
              ),
              Padding(padding:EdgeInsets.only(left: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(onPressed: ()async{
                     try{
                     await  authProider.createAccount("${authProider.usersModel.Email}", "${authProider.usersModel.Password}");
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LoginPage()));
                     }catch(e){
                       print('error caught:$e');
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                           content: Text(
                             'Log In Succesfully',
                           )));

                     }
                    },
                        icon: Text("Create",style: TextStyle( fontSize: size.height*0.050,color: Colors.black,fontWeight: FontWeight.bold),),
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              },
                  icon: Text("Already a member?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  label: Text("Login",style: TextStyle(  decoration: TextDecoration.underline,fontWeight: FontWeight.bold),)),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       alignment: Alignment.center,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(15),
              //           boxShadow: [
              //             BoxShadow(
              //                 color: Colors.deepPurpleAccent.withOpacity(0.1),
              //                 blurRadius: 5.0,
              //                 spreadRadius: 3.0,
              //                 offset: Offset(0,3)
              //             )
              //           ]
              //       ),
              //       child: Center(
              //         child: IconButton(onPressed: (){}, icon:Icon(Icons.account_circle_outlined,size: 40,color: Colors.lightBlue,)),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 20,
              //     ),
              //     Container(
              //       alignment: Alignment.center,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(15),
              //           boxShadow: [
              //             BoxShadow(
              //                 color: Colors.deepPurpleAccent.withOpacity(0.1),
              //                 blurRadius: 5.0,
              //                 spreadRadius: 3.0,
              //                 offset: Offset(0,3)
              //             )
              //           ]
              //       ),
              //       child: Center(
              //         child: Container(
              //           alignment: Alignment.center,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(20),
              //             color: Colors.white,
              //           ),
              //           child: IconButton( alignment: Alignment.center, onPressed: (){}, icon:Icon(Icons.account_circle_outlined,size: 40,color: Colors.lightBlue,),
              //         ),
              //       ),
              //     ))
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _textFieldBuilder(String ? hintTxt ,Icon? icon,AuthProvider authProider){
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
            hintTxt=="Username / Email"?authProider.usersModel.Email=value
            :hintTxt=="Password"?authProider.usersModel.Password=value
            :hintTxt=="Email"?authProider.usersModel.UserName
                :authProider.usersModel.PhoneNumber;
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
