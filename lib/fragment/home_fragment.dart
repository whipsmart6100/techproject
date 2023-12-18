import 'package:flutter/material.dart';
import 'package:whip_smart/utils/util.dart';
import 'package:whip_smart/utils/navigation_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:provider/provider.dart';

class HomeFragment extends StatefulWidget {
  List<String> list= Util.mediaList;
  List<String> listDe = Util.descriptionList;


  @override
  _HomeFragmentState createState() => new _HomeFragmentState();
}
class ListItems{
  String title;
  String mediaImage;
  ListItems(this.title, this.mediaImage);
}
class _HomeFragmentState extends State<HomeFragment> {

  int _selectedIndex = 0;
  //List imgL=[];


  final List<String> imgL = [
    'https://res.cloudinary.com/dewan8anb/image/upload/v1683051073/LTTS_Website_HomepageImages_030222_5_l4jign.png',
    'https://res.cloudinary.com/dewan8anb/image/upload/v1683051073/LTTS_Website_HomepageImages_030222_1_vikhid.png',
    'https://res.cloudinary.com/dewan8anb/image/upload/v1683051073/LTTS_Website_HomepageImages_030222_4_cvzsb3.png',
  ];


  @override
  Widget build(BuildContext context) {

    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.list.length; i++) {
      var d = widget.list[i];
      var l="";
      if(widget.listDe[i]!=null){
        l = widget.listDe[i];
      }else {
        //l ="Test data";
      }

     // print(l);
      drawerOptions.add(
          new Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              new  Column(

                  children: <Widget>[
                  new Image.network(

                    d,
                  ),
                  new Text(
                    l,
                    style: new TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  new Divider(
                    color: Colors.deepPurple,
                    height: 2.0,
                  )
                ],
              )
              /* new ListTile(

                leading: new Image.network(
                    d,
                ),
                title: new Text(
                    "",
                    style: new TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold
                    )),
                selected: i == _selectedIndex,
              //  onTap: () => _onSelectItem(i),
              ),*/

            ],
          )


      );
    }
    return Scaffold(

      body: SafeArea(
     //   child: Center (


         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           //crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[

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
                               height: 300,

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
                                         color: Colors.lightBlueAccent
                                     ),
                                     child: Container(
                                      // alignment: Alignment.center,
                                       margin: EdgeInsets.all(5.0),
                                       child: ClipRRect(
                                           borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                           child: Stack(

                                             children: <Widget>[
                                               Center(child: Image.network(i, fit: BoxFit.fill,width: 1000,)),
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
                                                     'LTTS',
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

           ],
         ),


      //  ),
      ),

    );
  }
  _navigateScan() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('items');
    prefs.setInt('len', 1);
    NavigationRouter.switchToScan(context);
  }

  _logOut() {
    //context.read<FirebaseAuthMethods>().deleteAccount(context);


    //Navigator.pushNamed(context, "/SplashScreen");
  }

}






