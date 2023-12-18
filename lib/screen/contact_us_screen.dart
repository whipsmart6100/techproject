import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gsheets/gsheets.dart';
import '../auth_methods.dart';
import '../model/user_model.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {


  String name = "",mail="Login To Continue",userId="";
  int logged =0;
  bool enabId=true;
  final TextEditingController _msgcontroller = new TextEditingController();
  final TextEditingController _idcontroller = new TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _msgcontroller.dispose();
    _idcontroller.dispose();

  }

  Future<String> _addProblem(String NameV,String IdV,String MsgV) async {

    String res = "fail";
    const cred = r'''
      {
  "type": "service_account",
  "project_id": "whip-smart",
  "private_key_id": "42eb00124df842e60933e5ce772a51e9c3209af5",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQD1/sh+zyoSPdOJ\nqf83kZweW4K/0H8i2+cb0pJbLVqxIQ1z8zCckVNCpTE1j4kFTa5Jal9g2B6XIHZN\nEY5G21VeuRhDs+OmVF4DOVSHCsIpfV/hu3SCUgEibxXQxUsdK25umguVTsfBVSHk\nIdP+WoLwmKM61mDfgqLE3RI3TlmEyWDzOvOZPGKyGoe0Y01Y6H4uXwJpah5QPz7C\n94fX+f4GtN/9NLRqeqWVSbfgdhSK/+LZalI/kEutPEzkLm7TMlP7RHgYSzoaLoa1\nLD1zKPoPJ6U2VFulMRYXPuJm6OAHwJr2qWVvOTnZ2AN2QtfTNy5I+zrEWzsDTT7R\noSUIIpmZAgMBAAECggEACKGZcFWdgMlZkEV+Nnlt9GS6mDddFqCHoeLIDtnvCjMC\nMVTRmlTBCqAYM2xnXt/EY0APu6qpnBzf+cFJcDQG8U1mTA3WSYJBUDSlQh2/BUyo\nXhfBNUdiUc57AfnCMnJRLCFMkb8TZDWz/DixowWS/ZUleQ2HlaAUTPsCxh0CKBYF\nLA7imDemAlqhfTxqxTO/ytG5k/APsGSmC/JK6rUp0dnwS7jjYfo4K1KtF6/bQm0q\n0EWtwzYa1fJeBee+F8Iwd5KmOFrnIOzRc0lp8qmUbbBU9XoKtP+WVwSAjC+E9rF0\n6qSOHXgZ+JxbBIJmTsyj1I/po3WkMWANaaOlA/YbOQKBgQD74XdzvDTHlU8j3b2a\nT0HqvxuQgBAPGXmAyN6AmxJNDsKUpWbvb19uYMS8+RKXJfQix+QkTY8DmIsQOozk\nYw+4q6UUN0n5nRTLAX43snWIi1VcRbDc3zVqKHtJ+FeeIDBXz86kQJaQ8KtHm2Cb\naoC1fKP1wwVovPxg0NIzlyxVtQKBgQD6BK0a/QJ1pm/It4qXFLnH3N1P/m7dHwWY\ngRn9YqLxXtdH37cod8htMd1iZiRRHDCEg7FCf2gzFvO0FnsTtLziB/hA3Zh+WdC3\nLm9DQNZHdWAZ3ow1A4PYLJGoRntPIQSWoxmupKzaX2zKAj9h9dPZIWytjpR7fgIu\neOztz7Bi1QKBgG3O1n+rLitQaWcOdWk/YlJPrFmrqtSaW4EMkQvqDulvJN8e2KhL\nmoQJRdvIjhU845kCIfC9qzp7Fy0lCWVL1n/AvL/6dpKOq5Dw/rCTaW/0pmsKqtcv\nrB6ytUUDMldqWwj9PG4ZBkr70P/vugcnQCNeyjALLGGD+lbO0sTRA+/9AoGBAPFS\n9iuor2kUH63jy3gM303VGCGQez4gJWyQoJ99R74nRzDu9YGwLNuJWCEUalWIGiSu\nYLjI9bDqpIzdbisVN4QNIUirG/hJhTZrMaX+vVX4K6yMrVS2cdqFGosMjRVRz3X/\nNFjoRpf5p65NARTzDWr14kqb5yJT/JMS0c6xu5WJAoGAGRd8tSLqCbeS+K5SiAD8\nPnqxVQwTrk/qFKVI8/QVb8y5fVRtH5u6gZMcYUJvx6iRsMGZRCLSg1KFkkpVRQ4O\nDWdMrjp+xZKfGtrGKRHI3moTj+ChUHLXV1OjG68zy1duCzIGqTRvsV4HqIsF0uQ0\nrzIhErjnWSwwBOnUmtMetT0=\n-----END PRIVATE KEY-----\n",
  "client_email": "whipsmart@whip-smart.iam.gserviceaccount.com",
  "client_id": "104175171436754996858",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/whipsmart%40whip-smart.iam.gserviceaccount.com"
}''';


    const sId = '1aheAo3wBlOq3LdBT-dUJuSbufEkV8o8OnxKMMlU7_04';

    final gSheet = GSheets(cred);
    final ss = await gSheet.spreadsheet(sId);
    var sheet = ss.worksheetByTitle("Sheet1");

    final secondRow = {
      'Time': DateTime.now().toString(),
      'Name': NameV,
      'Id': IdV,
      'Msg': MsgV,
    };
    try {
      await sheet?.values.map.appendRow(secondRow);
      // prints {index: 5, letter: f, number: 6, label: f6}
      // print(await sheet?.values.map.lastRow());
      res= "success";

    }
    catch (err) {
      res = err.toString();
      print(res);
    }
    return res;

  }


  _getUser(BuildContext context) async {
    User? user =  await  FirebaseAuth.instance.currentUser;

    if(user!=null){
      enabId=false;
      Future<UserModel> userData = AuthMethods().getUserDetails() as Future<UserModel>;



      userData.then((value) =>
      //value.uid

      setState(() {
        logged=1;
        name =value.name;
        mail = value.email;

        userId = value.uid;
        _idcontroller.text=userId;
      }),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    _getUser(context);

    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          ///***If you have exported images you must have to copy those images in assets/images directory.
          Image(
            image: const NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_ZAHKSzC49CgsWtMiZ-vTSDwQ7-o57Lr4sA&usqp=CAU"),
            height: MediaQuery.of(context).size.height * 0.35000000000000003,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: const EdgeInsets.all(0),
                padding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: const BoxDecoration(
                  color: Color(0x00ffffff),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisSize: MainAxisSize.max,
                    //     children: const [
                    //       Icon(
                    //         Icons.sort,
                    //         color: Color(0xffffffff),
                    //         size: 24,
                    //       ),
                    //       Icon(
                    //         Icons.search,
                    //         color: Color(0xffffffff),
                    //         size: 24,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: const [

                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Text(
                            "Contact us",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(24.0),
                    border:
                    Border.all(color: const Color(0x4d9e9e9e), width: 1),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: TextField(
                            controller:
                            TextEditingController(text: "${name}"),
                            obscureText: false,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              labelText: "Name",
                              enabled: false,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff444444),
                              ),
                              filled: true,
                              fillColor: const Color(0xffffffff),
                              isDense: false,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: TextField(
                            controller:_idcontroller,
                          //  TextEditingController(text: "${userId}"),
                            obscureText: false,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              labelText: "ID",
                              enabled: enabId,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff444444),
                              ),
                              filled: true,
                              fillColor: const Color(0xffffffff),
                              isDense: false,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: TextField(
                            controller: _msgcontroller,
                            obscureText: false,
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff000000), width: 1),
                              ),
                              labelText: "Message",
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0xff444444),
                              ),
                              filled: true,
                              fillColor: const Color(0xffffffff),
                              isDense: false,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: MaterialButton(
                            onPressed: () async {
                              if(_msgcontroller.text.length==0){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter a Message ")));
                                return;


                              }
                              _isLoading = true;
                              if(logged==0){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login to Continue")));
                                _isLoading = false;
                              }
                              else{

                                if(_isLoading&&logged==1){


                                String res2= await _addProblem(name, userId, _msgcontroller.text.toString());
                               //print(_addProblem(name, userId, _msgcontroller.text.toString()).toString());
                               //

                               if( res2.toString()==("success")){
                                 Navigator.pushReplacementNamed(context, "/HomeScreen");
                               }

                               else{
                                 _isLoading = false;
                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Occured")));

                               }
                                }

                              }

                            },
                            color: const Color(0xff3a57e8),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.all(16),
                            child:  _isLoading
                                ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                                :
                            Text("Send Message", style: TextStyle( fontSize:16,
                              fontWeight:FontWeight.bold,
                              fontStyle:FontStyle.normal,
                              color: Colors.white,
                            ),
                            ),
                            textColor: const Color(0xffffffff),
                            height: 50,
                            minWidth: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




