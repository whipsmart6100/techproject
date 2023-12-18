import 'package:flutter/material.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool _autoFocus = true;
  bool _useTorch = false;
  double _aspectRatio = -1.0;

  void _toggleAutoFocus(bool value) {
    setState(() {
      _autoFocus = value;
    });
  }

  void _toggleUseTorch(bool value) {
    setState(() {
      _useTorch = value;
    });
  }

  void _setAspectRatio(double value) {
    setState(() {
      _aspectRatio = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scan Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            CheckboxListTile(
              title: Text('Auto-focus'),
              value: _autoFocus,
              onChanged: null,
            ),
            CheckboxListTile(
              title: Text('Use torch'),
              value: _useTorch,
              onChanged: null,
            ),
            SizedBox(height: 16.0),
            Text(
              'Barcode Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Slider(
              min: -1.0,
              max: 1.0,
              divisions: 20,
              value: _aspectRatio,
              onChanged: _setAspectRatio,
              label: _aspectRatio == -1.0
                  ? 'Auto'
                  : _aspectRatio.toStringAsFixed(2),
            ),
            Text(
              _aspectRatio == -1.0
                  ? 'Auto'
                  : 'Aspect Ratio: ${_aspectRatio.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
