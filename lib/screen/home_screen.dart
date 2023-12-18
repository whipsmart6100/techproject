import 'package:flutter/material.dart';
import 'package:whip_smart/fragment/home_fragment.dart';
import 'package:whip_smart/fragment/profile_fragment.dart';
import 'package:whip_smart/fragment/view_products.dart';
import 'package:whip_smart/screen/about_us_screen.dart';
import 'package:whip_smart/screen/contact_us_screen.dart';

import 'package:whip_smart/utils/navigation_router.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> _widgetOptions = <Widget>[
    HomeFragment(),
    ProfileFragment(),
    ContactUsScreen(),
    AboutUsScreen(),

    //Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    //Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    //Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(55),
      body: Stack(


        children: [

          // Column(
          //
          // ),
          Container(

            child: _widgetOptions.elementAt(currentIndex),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 80,
              child: Stack(
                clipBehavior: Clip.none, children: [
                CustomPaint(
                  size: Size(size.width, 80),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: FloatingActionButton(backgroundColor: Colors.black, child: Icon(Icons.qr_code), elevation: 0.2, onPressed: () {
                    _navigateScan();
                  }),
                ),
                Container(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          color: currentIndex == 0 ? Colors.orange : Colors.grey.shade400,
                        ),
                        onPressed: () {
                          setBottomBarIndex(0);
                        },
                        splashColor: Colors.white,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.person,
                            color: currentIndex == 1 ? Colors.orange : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(1);
                          }),
                      Container(
                        width: size.width * 0.20,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.help_center,
                            color: currentIndex == 2 ? Colors.orange : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(2);
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.info,
                            color: currentIndex == 3 ? Colors.orange : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(3);
                          }),
                    ],
                  ),
                )
              ],
              ),
            ),
          )
        ],
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
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }


}
