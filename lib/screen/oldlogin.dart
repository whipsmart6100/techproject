import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:whip_smart/screen/tes_home.dart';
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
      backgroundColor: Color(0xffffffff),
      body:Align(
        alignment:Alignment.center,
        child:Padding(
          padding:EdgeInsets.symmetric(vertical: 0,horizontal:16),
          child:SingleChildScrollView(
            child:
            Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisSize:MainAxisSize.max,
              children: [
                ///***If you have exported images you must have to copy those images in assets/images directory.
                Lottie.network(
                  "https://assets3.lottiefiles.com/packages/lf20_jcikwtux.json",
                  height:200,
                  width:200,
                  fit:BoxFit.cover,
                  repeat: true,
                  animate: true,
                ),
                Align(
                  alignment:Alignment.centerLeft,
                  child:Text(
                    "Sign In",
                    textAlign: TextAlign.start,
                    overflow:TextOverflow.clip,
                    style:TextStyle(
                      fontWeight:FontWeight.w700,
                      fontStyle:FontStyle.normal,
                      fontSize:24,
                      color:Color(0xff000000),
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
                            color:Color(0xff9e9e9e),
                            width:1
                        ),
                      ),
                      focusedBorder:OutlineInputBorder(
                        borderRadius:BorderRadius.circular(4.0),
                        borderSide:BorderSide(
                            color:Color(0xff9e9e9e),
                            width:1
                        ),
                      ),
                      enabledBorder:OutlineInputBorder(
                        borderRadius:BorderRadius.circular(4.0),
                        borderSide:BorderSide(
                            color:Color(0xff9e9e9e),
                            width:1
                        ),
                      ),
                      labelText:"Email",
                      labelStyle:TextStyle(
                        fontWeight:FontWeight.w400,
                        fontStyle:FontStyle.normal,
                        fontSize:16,
                        color:Color(0xff9e9e9e),
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
                          color:Color(0xff9e9e9e),
                          width:1
                      ),
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(4.0),
                      borderSide:BorderSide(
                          color:Color(0xff9e9e9e),
                          width:1
                      ),
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderRadius:BorderRadius.circular(4.0),
                      borderSide:BorderSide(
                          color:Color(0xff9e9e9e),
                          width:1
                      ),
                    ),
                    labelText:"Password",
                    labelStyle:TextStyle(
                      fontWeight:FontWeight.w400,
                      fontStyle:FontStyle.normal,
                      fontSize:16,
                      color:Color(0xff9e9e9e),
                    ),
                    filled:true,
                    fillColor:Color(0x00f2f2f3),
                    isDense:false,
                    contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                  ),
                ),
                Padding(
                  padding:EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child:Align(
                    alignment:Alignment.centerRight,
                    child:Text(
                      "Forgot Password ?",
                      textAlign: TextAlign.start,
                      overflow:TextOverflow.clip,
                      style:TextStyle(
                        fontWeight:FontWeight.w400,
                        fontStyle:FontStyle.normal,
                        fontSize:14,
                        color:Color(0xff9e9e9e),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:EdgeInsets.fromLTRB(0, 30, 0, 16),
                  child:Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    mainAxisSize:MainAxisSize.max,
                    children:[

                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed:(){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext builder)=>RegisterScreen()));


                          },
                          color:Color(0xffffffff),
                          elevation:0,
                          shape:RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(12.0),
                            side:BorderSide(color:Color(0xff9e9e9e),width:1),
                          ),
                          padding:EdgeInsets.all(16),
                          child:Text("Sign Up", style: TextStyle( fontSize:16,
                            fontWeight:FontWeight.w400,
                            fontStyle:FontStyle.normal,
                          ),),
                          textColor:Color(0xff000000),
                          height:40,
                          minWidth:140,
                        ),
                      ),

                      SizedBox(
                        width:16,
                      ),
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed: ()=>{
                            _logInUser(context)
                          },

                          color:Color(0xff3a57e8),
                          elevation:0,
                          shape:RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(12.0),
                          ),
                          padding:EdgeInsets.all(16),
                          child: _isLoading
                              ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                              :Text("Login", style: TextStyle( fontSize:16,
                            fontWeight:FontWeight.w400,
                            fontStyle:FontStyle.normal,
                            color: Colors.white,
                          ),
                          ),



                        ),
                      ),
                    ],),),
                Padding(
                  padding:EdgeInsets.symmetric(vertical: 16,horizontal:0),
                  child:Text(
                    "Or Continue with",
                    textAlign: TextAlign.start,
                    overflow:TextOverflow.clip,
                    style:TextStyle(
                      fontWeight:FontWeight.w400,
                      fontStyle:FontStyle.normal,
                      fontSize:14,
                      color:Color(0xff9e9e9e),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //signInWithGoogle();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext builder)=>HomeScreen()));},
                  style: ElevatedButton.styleFrom(

                    primary: Colors.white,
                    padding: EdgeInsets.zero,
                    //backgroundColor: Color(0xFFFFFFFF),
                  ),
                  child: Container(
                    margin:EdgeInsets.all(0),
                    padding:EdgeInsets.symmetric(vertical: 8,horizontal:16),
                    decoration: BoxDecoration(
                      color:Color(0xffffffff),
                      shape:BoxShape.rectangle,
                      borderRadius:BorderRadius.circular(12.0),
                      border:Border.all(color:Color(0xff9e9e9e),width:1),

                    ),
                    child:
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                      crossAxisAlignment:CrossAxisAlignment.center,
                      mainAxisSize:MainAxisSize.min,
                      children:[


                        ///***If you have exported images you must have to copy those images in assets/images directory.
                        Image(
                          //  image: ,
                          image:NetworkImage("https://cdn0.iconfinder.com/data/icons/arrow-281/32/13-1024.png"),
                          height:25,
                          width:25,
                          fit:BoxFit.cover,

                        ),

                        Padding(
                          padding:EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child:Text(
                            "Skip",
                            textAlign: TextAlign.start,
                            overflow:TextOverflow.clip,
                            style:TextStyle(
                              fontWeight:FontWeight.w400,
                              fontStyle:FontStyle.normal,
                              fontSize:16,
                              color:Color(0xff000000),
                            ),
                          ),
                        ),
                      ],

                    ),


                  ),
                ),
              ],
            ),
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
                child: Text("OK"))
          ],
        ),
      );
    }
  }
}
