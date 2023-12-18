import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class NoData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("No Data"),
      ),
      backgroundColor: Color(0xffffffff),
      body:Align(
        alignment:Alignment.center,
        child:Padding(
          padding:EdgeInsets.symmetric(vertical: 0,horizontal:16),
          child:SingleChildScrollView(
            child:
            Column(
              mainAxisAlignment:MainAxisAlignment.start,
              crossAxisAlignment:CrossAxisAlignment.center,
              mainAxisSize:MainAxisSize.min,
              children: [
                Lottie.network(
                  "https://assets3.lottiefiles.com/packages/lf20_h81pyyr2.json",
                  height:400,
                  width:400,
                  fit:BoxFit.cover,
                  repeat: false,
                  animate: true,
                ),
                Padding(
                  padding:EdgeInsets.fromLTRB(0, 30, 0, 16),
                  child:Text(
                    "No records found",
                    textAlign: TextAlign.start,
                    overflow:TextOverflow.clip,
                    style:TextStyle(
                      fontWeight:FontWeight.w700,
                      fontStyle:FontStyle.normal,
                      fontSize:20,
                      color:Color(0xff3e3e3e),
                    ),
                  ),
                ),
                Text(
                  "There was no record based on the QR you scanned. Please Scan Again or contact the administrator.",
                  textAlign: TextAlign.center,
                  overflow:TextOverflow.clip,
                  style:TextStyle(
                    fontWeight:FontWeight.w700,
                    fontStyle:FontStyle.normal,
                    fontSize:16,
                    color:Color(0xff000000),
                  ),
                ),
                GestureDetector(

                  child: Padding(
                    padding:EdgeInsets.fromLTRB(0, 50, 0, 16),
                    child:MaterialButton(
                      onPressed:(){},
                      color:Color(0xff3a57e8),
                      elevation:0,
                      shape:RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(30.0),
                      ),
                      padding:EdgeInsets.symmetric(vertical: 0,horizontal:30),
                      child:GestureDetector(
                        onTap: ()=>{
                          Navigator.popAndPushNamed(context, "/ScanScreen")
                        },
                        child: Text("Scan Again", style: TextStyle( fontSize:16,
                          fontWeight:FontWeight.w700,
                          fontStyle:FontStyle.normal,
                        ),),
                      ),
                      textColor:Color(0xffffffff),
                      height:45,
                    ),
                  ),
                ),
                Text(
                  "Contact Support",
                  textAlign: TextAlign.start,
                  overflow:TextOverflow.clip,
                  style:TextStyle(
                    fontWeight:FontWeight.w700,
                    fontStyle:FontStyle.normal,
                    fontSize:16,
                    color:Color(0xff3a57e8),
                  ),
                ),
              ],),),),),
    )
    ;}
}
