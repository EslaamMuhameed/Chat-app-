import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  static String id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  bool isloding = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: isloding,
      child: Scaffold(
        backgroundColor: const Color(0xff1E1E1E),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: height * 0.07,
                ),
                Center(
                  child: Text(
                    'Chatty',
                    style: GoogleFonts.atomicAge(
                      fontSize: 38,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  "Login to your Account",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                CustomFormTextField(
                  hint: "Email",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomFormTextField(
                  onChanged: (value) {
                    password = value;
                  },
                  hint: "Password",
                  isPassword: true,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomFormTextField(
                  isPassword: true,
                  hint: "confirm Password",
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                CustomElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      isloding = true;
                      setState(() {});
                      try {
                        await reigsterUser();
                        showSnackBar(context, 'Successfully Registered');

                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ChatScreen(
                            email: email!,
                          );
                        }));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                              context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context,
                              'The account already exists for that email.');
                        }
                      } catch (e) {
                        showSnackBar(context, 'Error occured');
                      }
                      isloding = false;
                      setState(() {});
                    } else {
                      showSnackBar(context, 'Please fill the form correctly');
                    }
                  },
                  text: "Sign Up",
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  'Or login with',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(.75),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(height * .08, height * .08),
                        backgroundColor: Colors.white.withOpacity(0),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      onPressed: () {},
                      child: Image.asset(
                        'assets/images/google.png',
                      ),
                    ),
                    SizedBox(
                      width: width * .05,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(height * .09, height * .08),
                        backgroundColor: Colors.white.withOpacity(0),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      onPressed: () {},
                      child: Image.asset(
                        'assets/images/facebook.png',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "have any account?",
                      style: TextStyle(
                        color: Colors.white.withOpacity(.47),
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> reigsterUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
