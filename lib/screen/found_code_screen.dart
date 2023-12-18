import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whip_smart/screen/cart_screen.dart';
import 'package:whip_smart/screen/item_info.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';



class FoundCodeScreen extends StatefulWidget {
  final String value;
  const FoundCodeScreen({
    Key? key,
    required this.value,

  }) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();


}

class _FoundCodeScreenState extends State<FoundCodeScreen> {

  @override
  Widget build(BuildContext context) {



    return  Scaffold(
      appBar: AppBar(
        title: Text("Found Code"),
        centerTitle: true,
        // onWillPop: _onWillPop,
        leading: IconButton(
          onPressed: () {
            //   widget.screenClosed();
              Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined,),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [




              Text("Scanned Code:", style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,),),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: ()=>{
                  Clipboard.setData(ClipboardData(text: widget.value)),
                  if(widget.value.toString().contains("https://") || widget.value.toString().contains("http://")|| widget.value.toString().contains("www.")|| widget.value.toString().contains(".com") ){
                    _launchUrl((widget.value)),

                  },

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Result Copied to Clipboard"))),
                },
                  child: Text(widget.value,  style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,),)),
              Text("Click on Result to Copy to Clipboard"),
              
              Lottie.network(
                "https://assets6.lottiefiles.com/private_files/lf30_2c7wnifx.json",
                height:200,
                width:200,
                fit:BoxFit.fitWidth,
                repeat: true,
                animate: true,
              ),

              ElevatedButton(onPressed: ()=>{

                Navigator.pushReplacement(context,
                    PageRouteBuilder( pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>ItemInfo(value: widget.value)  )
                       // ItemInfo( value: widget.value),)
                ),


              }, child: Text("Get Item Info"))
            ],
          ),
        ),
      ),

    );
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }

}
