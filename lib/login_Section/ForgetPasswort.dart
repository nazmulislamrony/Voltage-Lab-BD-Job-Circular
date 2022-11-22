import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'otpVerification.dart';
class forgetPasswort extends StatefulWidget {
  const forgetPasswort({Key? key}) : super(key: key);
 static var  verify='';
  @override
  State<forgetPasswort> createState() => _forgetPasswortState();
}

class _forgetPasswortState extends State<forgetPasswort> {
  TextEditingController countryController = TextEditingController();
    var phone='';
  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+880";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: Icon(
      //       Icons.arrow_back_ios_rounded,
      //       color: Colors.black,
      //     ),
      //   ),
      //   elevation: 0,
      // ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/img1.png',
              //   width: 150,
              //   height: 150,
              // ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,

                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                          onChanged: (value){
                            phone=value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async{
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countryController.text+phone}',
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          forgetPasswort.verify=verificationId;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> otpVerification()));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'OPT Send',
                              )));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );

                    },
                    child: Text("Send the code")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
