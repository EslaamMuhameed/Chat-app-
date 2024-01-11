import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'chat_screen.dart';
import 'rigester_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;

  String? password;
  bool isloding = false;
  bool isChecked = false;

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
                  height: height * 0.08,
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
                  height: height * 0.05,
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
                  height: height * 0.02,
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
                  isPassword: true,
                  hint: "Password",
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      fillColor: MaterialStateProperty.all(Colors.white),
                      checkColor: Colors.black,
                      value: isChecked,
                      onChanged: (value) {
                        isChecked = value!;
                        setState(() {});
                      },
                    ),
                    Text(
                      "Remember me.",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Forget password..?",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      isloding = true;
                      setState(() {});
                      try {
                        await loginUser();
                        showSnackBar(context, 'Successfully Registered');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ChatScreen(
                                  email: email!,
                                )));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password provided for that user.');
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
                  text: "Login",
                ),
                SizedBox(
                  height: height * 0.025,
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
                  height: height * 0.04,
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
                  height: height * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.white.withOpacity(.47),
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RegisterScreen()));
                      },
                      child: const Text("Sign Up",
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

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
