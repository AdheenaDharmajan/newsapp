import 'package:flutter/material.dart';
import 'package:newsapp/login.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Center(
        child: Image.network('https://th.bing.com/th/id/OIP.y9GCb4nCSTgZrtrp_lds2wAAAA?cb=iwp2&rs=1&pid=ImgDetMain',height: 100,width: 100)
      ),
    );
  }
}