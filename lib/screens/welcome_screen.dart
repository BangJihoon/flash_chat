import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    // Firebase initializeApp 1번만 필요
    Firebase.initializeApp().whenComplete(() {
      print("firebase init");
      setState(() {});
    });
    // 애니메이션 컨트롤러
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this
            //upperBound: 100,
            );
    animation = ColorTween(begin: Colors.white, end: Colors.blue.shade500)
        .animate(controller);
    //animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                const Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              "Log in",
              Colors.lightBlueAccent,
              () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              "Register",
              Colors.blueAccent,
              () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
