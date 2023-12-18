import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:whip_smart/screen/home_screen.dart';
import 'package:whip_smart/screen/register_screen.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

import '../auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  final TextEditingController _emailIdController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  bool _isLoading = false;

  var _textStyleBlack = new TextStyle(fontSize: 12.0, color: Colors.black);
  var _textStyleGrey = new TextStyle(fontSize: 12.0, color: Colors.grey);
  var _textStyleBlueGrey =
  new TextStyle(fontSize: 12.0, color: Colors.blueGrey);

  @override
  void dispose() {
    super.dispose();
    _emailIdController.dispose();
    _passwordController.dispose();
  }

  void _logInUser(BuildContext context) async {
    if (_emailIdController.text.isEmpty) {
      _showEmptyDialog("Type something");
    } else if (_passwordController.text.isEmpty) {
      _showEmptyDialog("Type something");
    }
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().logInUser(
      email: _emailIdController.text,
      password: _passwordController.text,
    );
    if (result.toString() == 'success') {
      Navigator.popAndPushNamed(context, "/HomeScreen");
    } else {
      print(result.length);
    }
    setState(() {
      _isLoading = false;
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe6e6e6),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/loginnnn.jpg'),
              fit: BoxFit.cover,

            ),
          ),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [

              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: MaterialButton(


                    color: Color(0xff3a57e8),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    padding: EdgeInsets.all(16),

                    onPressed: () =>{
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext builder)=>HomeScreen())),


                    },


                    child: Text(
                      "Skip",


                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
              // Background image
              Container(
                margin: EdgeInsets.fromLTRB(20, 100, 20, 20),
                padding: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color.fromARGB(78, 162, 162, 162),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Color(0x4d9e9e9e), width: 4),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,

                      children: [
                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        Image(
                          image: AssetImage("images/loginn.gif"),
                          height: 250,
                          width: 320,
                         // repeat: ImageRepeat.noRepeat,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Login",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 22,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:EdgeInsets.symmetric(vertical: 16,horizontal:0),
                          child:TextField(
                            controller: _emailIdController,
                            obscureText:false,
                            textAlign:TextAlign.start,
                            maxLines:1,
                            style:TextStyle(
                              fontWeight:FontWeight.w400,
                              fontStyle:FontStyle.normal,
                              fontSize:16,
                              color:Color(0xff000000),
                            ),
                            decoration:InputDecoration(
                              disabledBorder:OutlineInputBorder(
                                borderRadius:BorderRadius.circular(4.0),
                                borderSide:BorderSide(
                                    color:Color(0xff000000),
                                    width:1
                                ),
                              ),
                              focusedBorder:OutlineInputBorder(
                                borderRadius:BorderRadius.circular(4.0),
                                borderSide:BorderSide(
                                    color:Color(0xff000000),
                                    width:1
                                ),
                              ),
                              enabledBorder:OutlineInputBorder(
                                borderRadius:BorderRadius.circular(4.0),
                                borderSide:BorderSide(
                                    color:Color(0xff000000),
                                    width:1
                                ),
                              ),
                              labelText:"Email",
                              labelStyle:TextStyle(
                                fontWeight:FontWeight.w400,
                                fontStyle:FontStyle.normal,
                                fontSize:16,
                                color:Color(0xff000000),
                              ),
                              filled:true,
                              fillColor:Color(0x00f2f2f3),
                              isDense:false,
                              contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText:true,
                          textAlign:TextAlign.start,
                          maxLines:1,
                          style:TextStyle(
                            fontWeight:FontWeight.w400,
                            fontStyle:FontStyle.normal,
                            fontSize:16,
                            color:Color(0xff000000),
                          ),
                          decoration:InputDecoration(
                            disabledBorder:OutlineInputBorder(
                              borderRadius:BorderRadius.circular(4.0),
                              borderSide:BorderSide(
                                  color:Color(0xff000000),
                                  width:1
                              ),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderRadius:BorderRadius.circular(4.0),
                              borderSide:BorderSide(
                                  color:Color(0xff000000),
                                  width:1
                              ),
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderRadius:BorderRadius.circular(4.0),
                              borderSide:BorderSide(
                                  color:Color(0xff000000),
                                  width:1
                              ),
                            ),
                            labelText:"Password",
                            labelStyle:TextStyle(
                              fontWeight:FontWeight.w400,
                              fontStyle:FontStyle.normal,
                              fontSize:16,
                              color:Color(0xff000000),
                            ),
                            filled:true,
                            fillColor:Color(0x00f2f2f3),
                            isDense:false,
                            contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 30),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: ()=>{
                              Navigator.popAndPushNamed(context, "/ContactUs"),

                            },
                              child: Text(
                                "Forgot Password?",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff3a57e8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            _logInUser(context);
                          },
                          color: Color(0xff3a57e8),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          padding: EdgeInsets.all(16),
                          child: _isLoading
                              ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                              :Text("Login", style: TextStyle( fontSize:16,
                            fontWeight:FontWeight.bold,
                            fontStyle:FontStyle.normal,
                            color: Colors.white,
                          ),
                          ),

                          textColor: Color(0xffffffff),
                          height: 40,
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 4, 6),
                                child: Text(
                                  "Don't have an account?",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        MaterialButton(


                          color: Color(0xff3a57e8),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          padding: EdgeInsets.all(6),

                          onPressed: () =>{
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext builder)=>RegisterScreen())),


                          },


                          child: Text(
                            "Sign Up",


                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }


  _showEmptyDialog(String title) {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          content: Text("$title can't be empty"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"))
          ],
        ),
      );
    } else if (Platform.isIOS) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          content: Text("$title can't be empty"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"))
          ],
        ),
      );
    }
  }
}
