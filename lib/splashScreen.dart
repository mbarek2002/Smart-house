import 'package:flutter/material.dart';
import 'package:smarthouse/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3,milliseconds: 500))
        .then((value) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var w =MediaQuery.sizeOf(context).width;
    var h =MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF050A30),
        ),
        height: h,
        width: w,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  height: 500,
                  image: AssetImage("assets/logo.jpg")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
