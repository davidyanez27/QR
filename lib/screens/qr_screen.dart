import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:residentes/themes/appTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    return MaterialApp(
      home: QrScreen(),
    );
  }
}

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  State<QrScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<QrScreen> {
  String data = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white70,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: QrImage(
              data: data,
              backgroundColor: Colors.white,
              version: QrVersions.auto,
              size: 300.0,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            width: 300.0,
            child: TextField(
              //we will generate a new qr code when the input value change
              onChanged: (value) {
                setState(() {
                  data = value;
                });
              },
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Type the Data",
                filled: true,
                fillColor: AppTheme.primary,
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          RawMaterialButton(
            onPressed: () {},
            fillColor: AppTheme.primary,
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(
              horizontal: 36.0,
              vertical: 16.0,
            ),
            child: Text(
              "Generate QR Code",
            ),
          )
        ],
      ),
    );
  }
}