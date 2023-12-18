import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final List<bool> _isOpen = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 68, 191, 222),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "Support",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xff000000),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff212435),
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildQuestion('How to scan a product?', 0),
              _buildAnswer(
                'Go to the home page and you will see an option called “Scan QR” in the bottom Nav Bar, Click on that and scan any QR or BARcode.',
                0,
              ),
              _buildQuestion('How to know the no. of products taken?', 1),
              _buildAnswer(
                'Login with your  account credentials and go to profile page >>View products then you will get to know the no. of products taken and returned.',
                1,
              ),
              _buildQuestion('How to return any product?', 2),
              _buildAnswer(
                'Go to Profile >> View Products if the desired item is returnable you will be given a “return item” button click on it and return the product .',
                2,
              ),
              _buildQuestion(
                  'Will I be having the track of previous products taken after returning?',
                  3),
              _buildAnswer(
                'Yes, you will have the list of returned products stored for 1 month in our app .',
                3,
              ),
              _buildQuestion(
                  'How do we know whether a product is returnable?', 4),
              _buildAnswer(
                'After scanning the QR or BARcode in our Application it detects whether it is returnable or not and if it is returnable it will show you the option “ Return Product”',
                4,
              ),
              _buildQuestion(
                  ' Is there any limit for the no.of items to be taken?', 5),
              _buildAnswer(
                'No, you can increase the count and take as many as you need.',
                5,
              ),
              _buildQuestion(
                  'Are there any privacy concerns with QR or barcode scanning apps?',
                  6),
              _buildAnswer(
                'As with any app that accesses your camera and/or stores data on your device, there are potential privacy concerns. Its important to read the apps privacy policy and make sure you are comfortable with the level of data collection and storage before using the app.',
                6,
              ),
              _buildQuestion(
                  'Are there any limitations to QR or barcode scanning?', 7),
              _buildAnswer(
                'No, there are no limitations for no. of times you scan any Qr or Bar code.',
                7,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(String question, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isOpen[index] = !_isOpen[index];
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                question,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            Icon(
              _isOpen[index]
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswer(String answer, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: _isOpen[index] ? null : 0,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Text(
        answer,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}