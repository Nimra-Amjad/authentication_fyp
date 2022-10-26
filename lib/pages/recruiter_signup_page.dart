import 'package:flutter/material.dart';
import 'package:notech/pages/recruiter_home_page.dart';
import 'package:notech/pages/user_home_page.dart';
import 'package:notech/pages/login_page.dart';
import 'package:notech/resources/auth_methods.dart';
import 'package:notech/utils/colors.dart';
import 'package:notech/utils/utils.dart';
import 'package:notech/widgets/textbutton.dart';
import 'package:notech/widgets/textformfield.dart';

class RecruiterSignUpScreen extends StatefulWidget {
  const RecruiterSignUpScreen({super.key});

  @override
  State<RecruiterSignUpScreen> createState() => _RecruiterSignUpScreenState();
}

class _RecruiterSignUpScreenState extends State<RecruiterSignUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _mobilenocontroller = TextEditingController();
  final TextEditingController _companynamecontroller = TextEditingController();
  final TextEditingController _locationcontroller = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _mobilenocontroller.dispose();
    _companynamecontroller.dispose();
    _locationcontroller.dispose();
  }

  void signUpRecruiter() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().signupRecruiter(
        email: _emailcontroller.text,
        companyname: _companynamecontroller.text,
        mobileno: _mobilenocontroller.text,
        password: _passwordcontroller.text,
        location: _locationcontroller.text);
    setState(() {
      _isloading = false;
    });
    if (res != "success") {
      print("error occured");
      showSnackBar(context, res);
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => const RecruiterHomePage()));
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            const Text(
              "User SignUp",
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
            const SizedBox(
              height: 20,
            ),
            TextFieldInput(
                textEditingController: _companynamecontroller,
                hintText: "Enter Company Name",
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 15,
            ),
            TextFieldInput(
                textEditingController: _mobilenocontroller,
                hintText: "Enter Mobile Number",
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 15,
            ),
            TextFieldInput(
                textEditingController: _locationcontroller,
                hintText: "Enter Location",
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 15,
            ),
            TextFieldInput(
                textEditingController: _emailcontroller,
                hintText: "Enter email",
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 15,
            ),
            TextFieldInput(
                textEditingController: _passwordcontroller,
                hintText: "Enter Passowrd",
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 15,
            ),
            TextButtonWidget(
                onpressed: signUpRecruiter,
                text: "SignUp",
                width: MediaQuery.of(context).size.width,
                height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 204, 204, 208),
                  ),
                ),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: const Text(
                    "Login",
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
