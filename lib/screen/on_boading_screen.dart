import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:whip_smart/screen/login_screen.dart';
import 'package:whip_smart/widgets/button_widget.dart';
import 'package:lottie/lottie.dart';


class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Center(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Scan anytime & anywhere',
            body: 'Portable scanner lets you scan any barcode or QR code with ease and gives access for all your goods.',
            image:  Lottie.network(
              "https://assets4.lottiefiles.com/packages/lf20_8hthlleg.json",
              height:400,
              width:400,
              fit:BoxFit.cover,
              repeat: false,
              animate: true,
            ),

           // Image.network("https://assets4.lottiefiles.com/packages/lf20_8hthlleg.json"),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Single touch scanner',
            body: 'Can be used by anyone who has the desire to purchase a product in-store or online with a single scan.',
            image: Lottie.network(
              "https://assets7.lottiefiles.com/packages/lf20_imz0kwa5.json",
              height:400,
              width:400,
              fit:BoxFit.cover,
              repeat: false,
              animate: true,
            ),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Digitalized transactions',
            body: 'This platform is to use a smart contract to manage all of the tasks that go into the buying and selling of a company stocks.',
            image: Lottie.network(
              "https://assets10.lottiefiles.com/packages/lf20_fknfveir.json",
              height:400,
              width:400,
              fit:BoxFit.cover,
              repeat: false,
              animate: true,
            ),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'No security flaws',
            body: 'Less exposure to threats and hacking systems ensures higher security of the platform',
            footer: Center(child: Text("Get Started",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 20,fontStyle: FontStyle.normal))),
            image: Lottie.network(
              "https://assets2.lottiefiles.com/packages/lf20_xtwsh33k.json",
              height:400,
              width:400,
              fit:BoxFit.cover,
              repeat: false,
              animate: true,
            ),
            decoration: getPageDecoration(),
          ),
        ],
        done: Text('Next', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
        onDone: () => goToHome(context),
        showSkipButton: true,
        skip: Text('Skip', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
        onSkip: () => goToHome(context),
        next: Icon(Icons.arrow_forward),
        dotsDecorator: getDotDecoration(),
        onChange: (index) => print('Page $index selected'),
        globalBackgroundColor: Colors.brown,
        //skipFlex: 0,
        nextFlex: 0,
        // isProgressTap: false,
        // isProgress: false,
         showNextButton: true,
        // freeze: true,
        // animationDuration: 1000,
      ),
    ),
  );

  void goToHome(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => LoginScreen()),
  );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
    color: Color(0xFF000000),
    activeColor: Color(0xFFFFFFFF),
    //activeColor: Colors.orange,
    size: Size(10, 10),
    activeSize: Size(22, 10),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  PageDecoration getPageDecoration() => PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    bodyTextStyle: TextStyle(fontSize: 20),
    //descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
    imagePadding: EdgeInsets.all(24),
    pageColor: Colors.white,
  );
}
