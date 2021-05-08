import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:toDoIt/home_screen.dart';
import 'constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    setState(() {
      _controller = AnimationController(
        vsync: this,
      )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                ),),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildLogo(),
    );
  }
  Center buildLogo() {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/splash.json',
            fit: BoxFit.fill,
            height: size.height*0.4,
            alignment: Alignment.center,
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward();
            },
          ),
          Text("To-DO-It",style: kTitle1.copyWith(color: kBlack),)
        ],
      ),
    );
  }
}
