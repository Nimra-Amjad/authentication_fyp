import 'package:flutter/material.dart';
import 'package:notech/pages/user_home_page.dart';
import 'package:notech/resources/auth_methods.dart';
import 'package:notech/utils/colors.dart';
import 'package:notech/widgets/textformfield.dart';
import 'package:notech/model/user_model.dart' as model;

class UserUpdateScreen extends StatefulWidget {
  final model.User user;
  const UserUpdateScreen({super.key, required this.user});

  @override
  State<UserUpdateScreen> createState() => _UserUpdateScreenState();
}

class _UserUpdateScreenState extends State<UserUpdateScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _mobilenocontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();
  bool _isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    _emailcontroller = TextEditingController(text: widget.user.email);
    _mobilenocontroller = TextEditingController(text: widget.user.mobileno);
    _usernamecontroller = TextEditingController(text: widget.user.username);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _mobilenocontroller.dispose();
    _usernamecontroller.dispose();
  }

  void updateuserdata() async {
    setState(() {
      _isloading = true;
    });
    await AuthMethods()
        .update(_usernamecontroller.text, _mobilenocontroller.text,
            _emailcontroller.text)
        .then((value) {
      setState(() {
        _isloading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const UserHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Update User Detail",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 36, 22, 222),
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
              textEditingController: _usernamecontroller,
              hintText: "Enter Full Name",
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
              textEditingController: _emailcontroller,
              hintText: "Enter email",
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 36, 22, 222),
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: updateuserdata,
                child: _isloading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Update'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
