import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'firebase_options.dart';
import 'screens/openning_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScolarChat());
}

class ScolarChat extends StatelessWidget {
  const ScolarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        nextScreen: OpenningScreen(),
        splashIconSize: double.infinity,
        backgroundColor: Color(0xff1E1E1E),
        splashTransition: SplashTransition.scaleTransition,
        splash: Scaffold(
            backgroundColor: Color(0xff1E1E1E),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lotties/splash_screen.json',
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  'Chatty',
                  style: GoogleFonts.atomicAge(
                    fontSize: 38,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
        duration: 2500,
      ),
    );
  }
}
