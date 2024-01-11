import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../widgets/custom_button.dart';
import 'login_screen.dart';

class OpenningScreen extends StatelessWidget {
  const OpenningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width =
        MediaQuery.of(context).size.width; // to get the width of the screen
    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.14,
            ),
            Lottie.asset('assets/lotties/open.json'),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              'Chat with your friends, share photo and video files fast with high quality',
              style: GoogleFonts.poppins(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height * 0.16,
            ),
            CustomElevatedButton(
text: 'Let\'s start',
onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }),
                );
              },
            )
            
            
          ],
        ),
      ),
    );
  }
}
