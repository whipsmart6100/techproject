import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whip_smart/auth_methods.dart';
import 'package:whip_smart/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

String name = "Login To Continue",btnTxt="Log In",mail="Login To Continue",userId="Login To Continue";
int logged =0;


class _ProfileFragmentState extends State<ProfileFragment> {




  _getUser(BuildContext context) async {
    User? user =  await  FirebaseAuth.instance.currentUser;

    if(user!=null){
      Future<UserModel> userData = AuthMethods().getUserDetails() as Future<UserModel>;


      print("object");

      userData.then((value) =>
      //value.uid

      setState(() {
        logged=1;
        btnTxt="Log Out";
        name =value.name;
        mail = value.email;
        userId = value.uid;
      }),
    );
    }
  }


  @override
  Widget build(BuildContext context) {

    _logout(BuildContext context) async {
      await FirebaseAuth.instance.signOut();
      Navigator.popAndPushNamed(context, "/LoginScreen");
    }
    _getUser(context);
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Color(0x00ffffff),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.zero,
      //   ),
      //   title: Text(
      //     "Profile",
      //     style: TextStyle(
      //       fontWeight: FontWeight.w700,
      //       fontStyle: FontStyle.normal,
      //       fontSize: 20,
      //       color: Color(0xff000000),
      //     ),
      //   ),
      //   leading: Icon(
      //     Icons.arrow_back_ios,
      //     color: Color(0xff212435),
      //     size: 24,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                        "images/logo.png",
                        fit: BoxFit.cover),
                  ),
                  Text(
                    "$name",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      color: Color(0xff000000),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 0),
                    child: Text(
                      "ID:$userId",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 0),
                    child: Text(
                      "Mail:$mail",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap:()=> {
                      if(logged==1){
                        Navigator.pushNamed(context, "/ViewProducts"),
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login In to View"))),
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0x273a57e8),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.visibility,
                              color: Color(0xff3a57e8),
                              size: 20,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 16),
                              child: Text(
                                "View Products",
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
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff3a57e8),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:() async => {
                      _navigateScan(context),
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0x273a57e8),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.qr_code,
                              color: Color(0xff3a57e8),
                              size: 20,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(

                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 16),
                                child: Text(
                                  "Scan Product",
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
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff3a57e8),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>{
                      Navigator.pushNamed(context, "/SupportScreen"),
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0x273a57e8),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.help,
                              color: Color(0xff3a57e8),
                              size: 20,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: ()=>{
                                Navigator.pushNamed(context, "/SupportScreen"),

                              },

                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 16),
                                child: Text(
                                  "Support",
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
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff3a57e8),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>{
                      Navigator.pushNamed(context, "/SettingScreen"),

                    },

                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0x273a57e8),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.settings,
                              color: Color(0xff3a57e8),
                              size: 20,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 16),
                              child: Text(
                                "Settings",
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
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff3a57e8),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: ()=>{
                  //     Navigator.pushNamed(context, "/AboutUsScreen"),
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisSize: MainAxisSize.max,
                  //       children: [
                  //         Container(
                  //           alignment: Alignment.center,
                  //           margin: EdgeInsets.all(0),
                  //           padding: EdgeInsets.all(10),
                  //           decoration: BoxDecoration(
                  //             color: Color(0x273a57e8),
                  //             shape: BoxShape.circle,
                  //           ),
                  //           child: Icon(
                  //             Icons.info_outline,
                  //             color: Color(0xff3a57e8),
                  //             size: 20,
                  //           ),
                  //         ),
                  //         Expanded(
                  //           flex: 1,
                  //           child: GestureDetector(
                  //
                  //             child: Padding(
                  //               padding: EdgeInsets.symmetric(
                  //                   vertical: 0, horizontal: 16),
                  //               child: Text(
                  //                 "About Us",
                  //                 textAlign: TextAlign.start,
                  //                 overflow: TextOverflow.clip,
                  //                 style: TextStyle(
                  //                   fontWeight: FontWeight.w400,
                  //                   fontStyle: FontStyle.normal,
                  //                   fontSize: 16,
                  //                   color: Color(0xff000000),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Icon(
                  //           Icons.arrow_forward_ios,
                  //           color: Color(0xff3a57e8),
                  //           size: 18,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,

              child: GestureDetector(
                onTap: ()=>{
                  _logout(context),
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  padding: EdgeInsets.all(0),
                  width: 120,

                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0x273a57e8),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Icon(
                        btnTxt=="Log Out"?Icons.logout:Icons.login,
                        color: Color(0xff3a57e8),
                        size: 24,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Text(
                          "$btnTxt",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff3a57e8),
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
    );
  }
  _navigateScan(BuildContext context) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('items');
    prefs.setInt('len', 1);
    Navigator.pushNamed(context, "/ScanScreen");
  }

}
