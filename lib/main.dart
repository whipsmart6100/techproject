
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:whip_smart/fragment/logout_fragment.dart';
import 'package:whip_smart/fragment/view_products.dart';

import 'package:whip_smart/screen/about_us_screen.dart';
import 'package:whip_smart/screen/cart_screen.dart';
import 'package:whip_smart/screen/contact_us_screen.dart';
import 'package:whip_smart/screen/home_screen.dart';

import 'package:whip_smart/screen/item_info.dart';

import 'package:whip_smart/screen/login_screen.dart';
import 'package:whip_smart/screen/no_data.dart';
import 'package:whip_smart/screen/settings_screen.dart';
import 'package:whip_smart/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whip_smart/screen/scan_screen.dart';
import 'package:whip_smart/screen/support_screen.dart';



var routes = <String, WidgetBuilder>{
  "/LoginScreen": (BuildContext context) => LoginScreen(),
  "/HomeScreen": (BuildContext context) => HomeScreen(),
  "/ScanScreen": (BuildContext context) => BarcodeListScannerWithController(),
  "/SplashScreen": (BuildContext context) => SplashScreen(),
  "/LogoutScreen": (BuildContext context) => LogoutScreen(),


  "/AboutUsScreen": (BuildContext context) => AboutUsScreen(),
  "/ContactUs": (BuildContext context) => ContactUsScreen(),
  "/NoData": (BuildContext context) => NoData(),
  "/ViewProducts": (BuildContext context) => ViewProducts(),
  "/SupportScreen": (BuildContext context) => SupportScreen(),
  "/SettingScreen": (BuildContext context) => SettingScreen(),


};



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAka1jDlvpg0mpLVj3olUDThABXOt8m6cU",
      appId: "1:326602966201:android:48ba34efa2eb9452e7c768",
      messagingSenderId: "326602966201",
      projectId: "whip-smart",
    ),
  );
  //Prefs.init();
  //setLocator();
  //final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

  //print(initialLink.toString());
  //if (initialLink != null) {
  //  final Uri deepLink = initialLink.link;
   // print(deepLink.toString());
    runApp( MyApp());
    // Example of using the dynamic link to push the user to a different screen
    //Navigator.pushNamed(context, deepLink.path);
  //}



}


class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whip Smart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    //  initialRoute: '/SplashScreen',
      home: SplashScreen(),
      routes: routes,
    );


  }
}

