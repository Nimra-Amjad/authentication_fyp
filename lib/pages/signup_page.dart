import 'package:flutter/material.dart';
import 'package:notech/pages/recruiter_signup_page.dart';
import 'package:notech/pages/user_signup_page.dart';
import 'package:notech/widgets/textbutton.dart';

class UserRecuriterSignup extends StatefulWidget {
  const UserRecuriterSignup({super.key});

  @override
  State<UserRecuriterSignup> createState() => _UserRecuriterSignupState();
}

class _UserRecuriterSignupState extends State<UserRecuriterSignup> {
  void navigateToUserSignUp() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const UserSignUpScreen()));
  }

  void navigateToRecruiterSignUp() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const RecruiterSignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            "assets/signup.jpg",
            width: MediaQuery.of(context).size.width,
            height: 300,
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButtonWidget(
                  onpressed: navigateToUserSignUp,
                  text: "User SignUp",
                  width: 200,
                  height: 60),
              TextButtonWidget(
                  onpressed: navigateToRecruiterSignUp,
                  text: "Recruiter SignUp",
                  width: 200,
                  height: 60),
            ],
          ),
        ],
      ),
    );
  }
}
