import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech/pages/recruiter_home_page.dart';
import 'package:notech/pages/user_home_page.dart';
import 'package:notech/pages/signup_page.dart';
import 'package:notech/resources/auth_methods.dart';
import 'package:notech/utils/colors.dart';
import 'package:notech/utils/utils.dart';
import 'package:notech/widgets/textbutton.dart';
import 'package:notech/widgets/textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isloading = false;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void loginUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailcontroller.text, password: _passwordcontroller.text);
    if (res == "successfully loggedin") {
    //   if ('uid' ==
    //       FirebaseFirestore.instance.collection('recruiters').doc(user!.uid)) {
    //     Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (context) => const RecruiterHomePage()));
    //   } else {
    //     Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (context) => const UserHomePage()));
    //   }

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => const UserHomePage()));
      setState(() {
        _isloading = false;
      });
    } else {
      print("Can't login");
      setState(() {
        _isloading = false;
      });
    }
    showSnackBar(context, res);
  }

  void navigateToSignUp() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const UserRecuriterSignup()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            Image.asset(
              "assets/login.png",
              width: MediaQuery.of(context).size.width,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "User Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 36, 22, 222),
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Hey, Enter your details to get login to your account",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 204, 204, 208),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
                textEditingController: _emailcontroller,
                hintText: "Enter your email",
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 15,
            ),
            TextFieldInput(
              textEditingController: _passwordcontroller,
              hintText: "Enter your passowrd",
              textInputType: TextInputType.text,
              isPass: true,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 36, 22, 222),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextButtonWidget(
                onpressed: loginUser,
                text: "Login",
                width: MediaQuery.of(context).size.width,
                height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don\'t have an account?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 204, 204, 208),
                  ),
                ),
                GestureDetector(
                  onTap: navigateToSignUp,
                  child: const Text(
                    "Create",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 36, 22, 222),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
