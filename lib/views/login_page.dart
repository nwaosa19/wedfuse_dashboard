import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wedme_dashboard/utils/loading_indicator.dart';
import 'package:wedme_dashboard/views/layout_view.dart';

import '../utils/input_field.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    bool isMobile = size.width <= 700;
    return Scaffold(
      body: SingleChildScrollView(
        child: isMobile
            ? Column(
                children: [
                  const RightLoginView(),
                  LeftLoginView(size: size),
                ],
              )
            : Row(
                children: [
                  LeftLoginView(size: size),
                  const RightLoginView(),
                ],
              ),
      ),
    );
  }
}

class LeftLoginView extends StatelessWidget {
  const LeftLoginView({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    bool isMobile = size.width <= 700;
    return Container(
      height: !isMobile ? size.height : null,
      width: isMobile ? size.width : size.width * 0.4,
      color: const Color(0XFF4285F4),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // SizedBox(
          //   height: 330,
          //   child: Image.asset(
          //     "assets/images/fontisto_drug-pack.png",
          //   ),
          // ),
          // const SizedBox(height: 20),
          // SizedBox(
          //   height: 330,
          //   child: Image.asset(
          //     "assets/images/mdi_drugs.png",
          //   ),
          // ),
        ],
      ),
    );
  }
}

class RightLoginView extends StatefulWidget {
  const RightLoginView({super.key});

  @override
  State<RightLoginView> createState() => _RightLoginViewState();
}

class _RightLoginViewState extends State<RightLoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String email = "";
  String password = "";
  Future<void> signInUser(
      String email, String password, BuildContext context) async {
    showLoadingDialog(context);
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const  LayoutPage())));

      // Success: navigate to appropriate screen
      // Replace with your desired route
    } on FirebaseAuthException catch (error) {
      // Failure: display error dialog
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sign In Failed'),
          content: Text(error.code),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    bool isMobile = size.width <= 700;
    return Container(
      height: !isMobile ? size.height : null,
      width: size.width * 0.6,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            Container(
              width: isMobile ? size.width * 0.8 : 330,
              alignment: Alignment.topLeft,
              child: Text(
                "Log In",
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              // height: 33,
              width: isMobile ? size.width * 0.8 : 330,
              child: InputField(
                hintText: 'Email',
                onChanged: (value) => email = value,
                validator: (value) {
                  if (value!.isEmpty) return "Required*";
                  if (!value.contains("@")) return "Invalid Email Address";
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              // height: 33,
              width: isMobile ? size.width * 0.8 : 330,
              child: InputField(
                hintText: 'Password',
                onChanged: (value) => password = value,
                validator: (value) {
                  if (value!.isEmpty) return "Required*";
                  if (value.length < 6) return "Weak password";
                  return null;
                },
              ),
            ),
            // Container(
            //   width: isMobile ? size.width * 0.8 : 330,
            //   child:Row(
            //     children: [
            //       Row(children: [
            //         Checkbox(value: true, onChanged: (){})
            //       ],)
            //     ],
            //   )
            // ),
            const SizedBox(height: 40),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: Color(0XFF005AC1)),
                ),
                minimumSize: Size(isMobile ? size.width * 0.8 : 330, 56),
                // padding: const EdgeInsets.symmetric(
                //   horizontal: 12,
                //   vertical: 16,
                // ),
                backgroundColor: const Color(0XFF4285F4),
              ),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  signInUser(email, password, context);
                }
              },
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: isMobile ? size.width * 0.8 : 330,
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account? ",
                    ),
                    TextSpan(
                      text: "Sign up",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(context, "/signup"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
