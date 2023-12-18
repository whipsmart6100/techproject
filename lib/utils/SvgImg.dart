import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SvgImg extends StatelessWidget {

  final String link;

  const SvgImg({Key? key, required this.link}) : super(key: key);


  //const SvgImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
       children: [

         SvgPicture.asset(

        link,
       height: 56,
       width: 56,

       //  colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
       //  semanticsLabel: 'A red up arrow'
     ),
       ],
     ),
    );
  }
}
