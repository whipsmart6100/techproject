import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whip_smart/screen/cart_screen.dart';
import 'package:whip_smart/screen/pdf_view.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:gsheets/gsheets.dart';

class ItemInfo extends StatefulWidget {
  final String value;
  const ItemInfo({
    Key? key,
    required this.value,

  }) : super(key: key);

  @override
  State<ItemInfo> createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
   DocumentSnapshot ?itemData;
   String ?name,desc,type,col,manual,reference,nameT,descT,typeT,colT,nameH,descH,typeH,colH,wareHouse;
   late int rType;
   int fId=-1,gotIt=0,wareCount=0,scanCount=0;
   String ?gN,gD,gT,gC;
   List imgL=[],ids=[];
   late String _myActivity;
   bool  _Cvisible=false;
   late String _myActivityResult;
  late int _lan;
   final formKey = new GlobalKey<FormState>();
   @override
   void initState() {
     super.initState();
     _myActivity = 'English';
     _myActivityResult = '';
     _lan=0;
     gC="";
     wareHouse="";
     rType=1;
     gN="";
     gD="";
     gT="";
   }
   @override
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

   _saveForm() {
     var form = formKey.currentState;

     print(_lan);

    // if (form?.validate()=null) {
       form?.save();
       setState(() {
         _myActivityResult = _myActivity;


       if(_myActivityResult == "English"){
         _lan=1;
         gT = type;
         gN = name;
         gD = desc;
         gC = col;
       }else  if(_myActivityResult == "Hindi"){
         _lan=2;
         gT = typeH;
         gN = nameH;
         gD = descH;
         gC = colH;

       }
       else  if(_myActivityResult == "Telugu"){
         _lan=3;
         gT = typeT;
         gN = nameT;
         gD = descT;
         gC = colT;
       }
       });

   //  }
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    _getItem() async {

     // if(gotIt==0){
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


      const sId = '1Iy240k1B85VCQGsXlrzgKRslCDJi9ZtfzrLKRhXZAcE';

      final gSheet = GSheets(cred);
      final ss = await gSheet.spreadsheet(sId);
      var sheet = ss.worksheetByTitle("Sheet1");

      await sheet?.values.column(1, fromRow: 1, length: 20).then((value) =>

      ids = value,

      );

      for (int i = 1; i < ids.length; i++) {
        if (ids[i] ==
            widget.value.replaceAll(' ', '').replaceAll("/", "").trim()) {
          fId = i;
        }
      }

      //   CollectionReference products = FirebaseFirestore.instance.collection('Products');

      //  print(widget.value.replaceAll(' ', '').trim().length);
      //  itemData = await  products.doc(widget.value.replaceAll(' ', '').replaceAll("/", "").trim()).get();
      //   print(itemData!.data().toString());
      if (fId == -1) {
        Navigator.popAndPushNamed(context, "/NoData");
      }
      else {
        if(gotIt==0){
        final cellsRow = (await sheet?.values.row(fId + 1))!;
        print(cellsRow);

        setState(()  {
          // name = itemData!.get("name");
          // desc = itemData!.get("desc");
          // type = itemData!.get("type");
          // col = itemData!.get("color");
          // rType = itemData!.get("rType");
          //
          // nameT = itemData!.get("nT");
          // descT = itemData!.get("dT");
          // typeT = itemData!.get("tT");
          // colT = itemData!.get("cT");
          //
          // nameH = itemData!.get("nH");
          // descH = itemData!.get("dH");
          // typeH = itemData!.get("tH");
          // colH = itemData!.get("cH");
          //
          // imgL = itemData!.get("imgL");
          // manual = itemData!.get("manual");
          // reference = itemData!.get("link");
          //
          name = cellsRow[2].toString();
          desc = cellsRow[3].toString();
          type = cellsRow[4].toString();
          col = cellsRow[5].toString();
          rType = int.parse(cellsRow[6]);

          if(rType !=1){
            _Cvisible =true;
          }

          nameT = cellsRow[7].toString();
          descT = cellsRow[8].toString();
          typeT = cellsRow[9].toString();
          colT = cellsRow[10].toString();

          nameH = cellsRow[11].toString();
          descH = cellsRow[12].toString();
          typeH = cellsRow[13].toString();
          colH = cellsRow[14].toString();

          imgL = cellsRow[15].toString().split(" ");
          //print(imgL);
          manual = cellsRow[16].toString();
          reference = cellsRow[17].toString();
          wareHouse = cellsRow[18].toString();
          wareCount =int.parse(cellsRow[19]);
          scanCount =int.parse(cellsRow[20]);
        });
        await sheet?.values.insertValue(scanCount+1, column: 21, row: fId+1);





        //     if (snapshot.hasError) {
        //   print((snapshot.error.toString()) as String);
        //   //  return Text((snapshot.error.toString()) as String);
        //
        // }

        // if (snapshot.hasData && !snapshot.data!.exists) {
        //   //  return Text("Document does not exist");
        // }

        // if (snapshot.connectionState == ConnectionState.done) {
        //   data = snapshot.data!.data() as Map<String, dynamic>;
        //   // return Text("Full Name: $data");
        // }
        //  );
      }
      }

    gotIt=1;
      _saveForm();
  }
    _getItem();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Info'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.shopping_cart),
        //     onPressed: () {
        //       Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext builder)=>CartPage(value: widget.value, count: _quantity)));
        //     },
        //   ),
        // ],
       
      ),
    //  body: Column(

      //  children: [
          // Container(
          //   padding: EdgeInsets.all(6),
          //   child: DropDownFormField(
          //     titleText: 'Language',
          //     hintText: '',
          //
          //     value: _myActivity,
          //     onSaved: (value) {
          //       setState(() {
          //         _myActivity = value;
          //
          //       });
          //     },
          //     onChanged: (value) {
          //
          //       setState(() {
          //         _myActivity = value;
          //       });
          //       _saveForm();
          //     },
          //     dataSource: [
          //       {
          //         "display": "English",
          //         "value": "English",
          //       },
          //       {
          //         "display": "Hindi",
          //         "value": "Hindi",
          //       },
          //       {
          //         "display": "Telugu",
          //         "value": "Telugu",
          //       },
          //
          //     ],
          //     textField: 'display',
          //     valueField: 'value',
          //   ),
          // ),
          //




       //   SafeArea(
          //  child:
            //Column(

           //   children: [
              //  Align(
                 // alignment: Alignment.topCenter,

                 // child:
           body: SingleChildScrollView(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                     // mainAxisSize: MainAxisSize.max/2,
                      children: [

                        DropDown(
                          items: ["English", "Hindi","Telugu"],
                          hint: Text("English"),
                          icon: Icon(
                            Icons.expand_more,
                            color: Colors.blue,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _myActivity = newValue!;
                            });
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                        child: CarouselSlider(
    options: CarouselOptions(
      aspectRatio: 1/1,
      enlargeCenterPage: true,
      autoPlay: true,
      height: 200,

      enableInfiniteScroll: true,
      reverse: false,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
     // autoPlayCurve: Curves.fastOutSlowIn,
      //enlargeFactor: 0.3,
     // onPageChanged: callbackFunction,
      scrollDirection: Axis.horizontal,
    ),
    items: imgL.map((i) {
    return Builder(
    builder: (BuildContext context) {
    return Container(
    width: MediaQuery.of(context).size.width<400?MediaQuery.of(context).size.width:400,

    margin: EdgeInsets.symmetric(horizontal: 5.0),

    decoration: BoxDecoration(
    color: Colors.amber
    ),
    child: Container(
    margin: EdgeInsets.all(5.0),
      child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: Stack(
      children: <Widget>[
      Image.network(i, fit: BoxFit.fill,width: 1000,),
      Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
      decoration: BoxDecoration(
      gradient: LinearGradient(
      colors: [
      Color.fromARGB(200, 0, 0, 0),
      Color.fromARGB(0, 0, 0, 0)
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      ),
      ),
      padding: EdgeInsets.symmetric(
      vertical: 10.0, horizontal: 20.0),
      child: Text(
      'WhipSmart',
      style: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      ),
      ),
      ),
      ),
      ],
      )),
    ),
    );
    },
    );
    }).toList(),
    ),
                                    ),


                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                           Text("$gN",
                                              style: TextStyle(
                                                  fontSize: 17, fontWeight: FontWeight.w700,letterSpacing: 1.1)),
                                          const SizedBox(height: 5),
                                           Text('$gD',style: TextStyle(
                                               fontSize: 15, fontWeight: FontWeight.w500,letterSpacing: 1.1)),
                                          const SizedBox(height: 5),
                                          // Row(
                                          //   children: List.generate(
                                          //       5,
                                          //           (index) => const Icon(Icons.star,
                                          //           color: Colors.yellow, size: 16)),
                                          // ),

                                          Row(
                                            children: [
                                              Icon(Icons.workspaces_filled),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                child: Text("Type: $gT",style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.w600,letterSpacing: 1.2)),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            children: [

                                              Icon(Icons.color_lens),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                child: Text("Color: $gC",style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.w600,letterSpacing: 1.2)),
                                              )
                                            ],
                                          ),

                                          const SizedBox(height: 5),
                                          Row(
                                            children: [

                                              Icon(Icons.home),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                child: Text("WareHouse: $wareHouse",style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.w600,letterSpacing: 1.2)),
                                              )
                                            ],
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
                                                      _launchUrl(reference);

                                                    },
                                                    color:Color(0xffffffff),
                                                    elevation:0,
                                                    shape:RoundedRectangleBorder(
                                                      borderRadius:BorderRadius.circular(12.0),
                                                      side:BorderSide(color:Color(0xff9e9e9e),width:1),
                                                    ),
                                                    padding:EdgeInsets.all(16),
                                                    child:Text("Reference", style: TextStyle( fontSize:16,
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
                                                    onPressed:(){
                                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext builder)=>PdfView(value: manual.toString())));


                                                    },
                                                    color:Color(0xffffffff),
                                                    elevation:0,
                                                    shape:RoundedRectangleBorder(
                                                      borderRadius:BorderRadius.circular(12.0),
                                                      side:BorderSide(color:Color(0xff9e9e9e),width:1),
                                                    ),
                                                    padding:EdgeInsets.all(16),
                                                    child:Text("Manual", style: TextStyle( fontSize:16,
                                                      fontWeight:FontWeight.w400,
                                                      fontStyle:FontStyle.normal,
                                                    ),),
                                                    textColor:Color(0xff000000),
                                                    height:40,
                                                    minWidth:140,
                                                  ),
                                                ),

                                              ],),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                             // const SizedBox(height: 20),
                           //   Align(

                              // alignment: Alignment.bottomCenter,
                         //       child:

                         //     ),
                              //const SizedBox(height: 20),
                            ],
                          ),
                        ),

                       // Expanded(
                       //   flex: 1,
                        //  child: Align(
                          //  alignment: Alignment.center,
                            //child:
                            Visibility(
                              visible: _Cvisible,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10,20,20,10),
                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,




                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5,2,5,2),
                                      child: GestureDetector(
                                        onTap: ()=>{
                                          _quantity=_quantity+100,
                                        },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(
                                                width: 3,
                                                color: Colors.red,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(25,10,25,10),
                                              child: Text("+100"),
                                            ),
                                          )
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5,2,5,2),
                                      child: GestureDetector(
                                          onTap: ()=>{
                                            _quantity=_quantity+500,
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(
                                                width: 3,
                                                color: Colors.red,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(25,10,25,10),
                                              child: Text("+500"),
                                            ),
                                          )
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5,2,5,2),
                                      child: GestureDetector(
                                          onTap: ()=>{
                                            if(_quantity-200>0)
                                            _quantity=_quantity-200,
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(
                                                width: 3,
                                                color: Colors.red,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(25,10,25,10),
                                              child: Text("-200"),
                                            ),
                                          )
                                      ),
                                    ),

                                  ],
                         //   ),
                          //),
                        ),
                              ),
                            ),

                        ElevatedButton(

                          onPressed: () async {
                            User? user = await FirebaseAuth.instance.currentUser;
                            if(user !=null){


                            if(imgL.length!=0)
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext builder)=>CartPage(value: widget.value, count: _quantity,name: name.toString(),rType: rType,img: imgL[0].toString(),)));

                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wait for Info to Load")));
                            }
                            }

                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login In to View")));

                          }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Add Product '),
                              IconButton(
                                onPressed: _decrementQuantity,
                                icon: const Icon(Icons.remove),
                                padding: const EdgeInsets.all(0),
                                constraints: const BoxConstraints(),
                              ),
                              Text('$_quantity', style: const TextStyle(fontSize: 18)),
                              IconButton(
                                onPressed: _incrementQuantity,
                                icon: const Icon(Icons.add),
                                padding: const EdgeInsets.all(0),
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ),

                         SizedBox(height: 40,)
                      ],


                    ),


                  ),
              //  ),

            //  ],

        //    ),
        //  ),
       // ],
     // ),
    );
  }

   Future<void> _launchUrl(_url) async {
     if (!await launchUrl(Uri.parse(_url))) {
       throw Exception('Could not launch $_url');
     }
   }
}
