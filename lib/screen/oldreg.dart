import 'package:flutter/material.dart';
import 'package:whip_smart/screen/login_screen.dart';
import 'package:whip_smart/screen/phone_page.dart';

import '../auth_methods.dart';
import 'package:lottie/lottie.dart';




class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;
  String? _userName;
  bool _isLoading = false;


  void _signUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      // Logging in the user w/ Firebase
      //print(_password);
      //print(_userName);
      if(_password==_userName){


        String result = await AuthMethods()
            .signUpUser(name: _name, email: _email, password: _password, username: _name);
        if (result == 'success') {
          Navigator.pushNamed(context, "/HomeScreen");
          print(result);
        } else {
          print(result);
        }
        setState(() {
          _isLoading = false;
        });
      }
      else{
        print("Wrong");
        _isLoading=false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Passwords not Matched")));
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body:Form(
        key: _formKey,
        child: Align(
          alignment:Alignment.center,
          child:Padding(
            padding:EdgeInsets.symmetric(vertical: 0,horizontal:10),
            child:SingleChildScrollView(
              child:
              Column(
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment:CrossAxisAlignment.center,
                mainAxisSize:MainAxisSize.max,
                children: [
                  Lottie.network(
                    "https://assets3.lottiefiles.com/packages/lf20_0mohmgca.json",
                    height:200,
                    width:200,
                    fit:BoxFit.cover,
                    repeat: true,
                    animate: true,
                  ),
                  Padding(
                    padding:EdgeInsets.symmetric(vertical: 10,horizontal:0),
                    child:Text(
                      "Enter your details",
                      textAlign: TextAlign.start,
                      overflow:TextOverflow.clip,
                      style:TextStyle(
                        fontWeight:FontWeight.w900,
                        fontStyle:FontStyle.normal,
                        fontSize:20,
                        color:Color(0xff000000),
                      ),
                    ),
                  ),
                  Align(
                    alignment:Alignment.centerLeft,
                    child:Text(
                      "Sign Up",
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
                    padding:EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child:TextFormField(
                      validator: (input) => input!.trim().isEmpty
                          ? 'Please enter a valid name'
                          : null,
                      onSaved: (input) => _name = input!,
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
                        labelText:"Name",
                        labelStyle:TextStyle(
                          fontWeight:FontWeight.w400,
                          fontStyle:FontStyle.normal,
                          fontSize:16,
                          color:Color(0xff9e9e9e),
                        ),
                        filled:true,
                        fillColor:Color(0x00ffffff),
                        isDense:false,
                        contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                      ),
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child:TextFormField(
                      validator: (input) => !input!.contains('@')
                          ? 'Please enter a valid email'
                          : null,
                      onSaved: (input) => _email = input!,
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
                        fillColor:Color(0x00ffffff),
                        isDense:false,
                        contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                      ),
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child:TextFormField(
                      validator: (input) => input!.length < 6
                          ? 'Must be at least 6 characters'
                          : null,
                      onSaved: (input) => _password = input!,
                      obscureText: true,
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
                        fillColor:Color(0x00ffffff),
                        isDense:false,
                        contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                      ),
                    ),
                  ),
                  Padding(
                    padding:EdgeInsets.fromLTRB(0, 16, 0, 30),
                    child:TextFormField(

                      onSaved: (input) => _userName = input!,
                      // validator: (input) => input! !=_password
                      //     ? 'Please enter  Correct Password'
                      //     : null,

                      obscureText: true,
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
                        labelText:"Confirm Password",
                        labelStyle:TextStyle(
                          fontWeight:FontWeight.w400,
                          fontStyle:FontStyle.normal,
                          fontSize:16,
                          color:Color(0xff9e9e9e),
                        ),
                        filled:true,
                        fillColor:Color(0x00ffffff),
                        isDense:false,
                        contentPadding:EdgeInsets.symmetric(vertical: 8,horizontal:12),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    mainAxisSize:MainAxisSize.max,
                    children:[

                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          onPressed:(){Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext builder)=>LoginScreen()
                          ));
                          },
                          color:Color(0xffffffff),
                          elevation:0,
                          shape:RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(12.0),
                            side:BorderSide(color:Color(0xff9e9e9e),width:1),
                          ),
                          padding:EdgeInsets.all(16),
                          child:Text("Login", style: TextStyle( fontSize:16,
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
                          onPressed:()=>{
                            _signUp(context)
                          },
                          color:Color(0xff3a57e8),
                          elevation:0,
                          shape:RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(12.0),
                          ),
                          padding:EdgeInsets.all(16),
                          child:_isLoading
                              ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                              : Text("Sign Up", style: TextStyle( fontSize:16,
                            fontWeight:FontWeight.w400,
                            fontStyle:FontStyle.normal,
                          ),),


                          textColor:Color(0xffffffff),
                          height:40,
                          minWidth:140,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
