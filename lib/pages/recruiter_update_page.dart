import 'package:flutter/material.dart';
import 'package:notech/pages/recruiter_home_page.dart';
import 'package:notech/resources/auth_methods.dart';
import 'package:notech/utils/colors.dart';
import 'package:notech/widgets/textformfield.dart';
import 'package:notech/model/recruiter_model.dart' as model;

class RecruiterUpdateScreen extends StatefulWidget {
  final model.Recruiter user;
  const RecruiterUpdateScreen({super.key, required this.user});

  @override
  State<RecruiterUpdateScreen> createState() => _RecruiterUpdateScreenState();
}

class _RecruiterUpdateScreenState extends State<RecruiterUpdateScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _mobilenocontroller = TextEditingController();
  TextEditingController _companynamecontroller = TextEditingController();
  TextEditingController _locationcontroller = TextEditingController();
  bool _isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    _emailcontroller = TextEditingController(text: widget.user.email);
    _mobilenocontroller = TextEditingController(text: widget.user.mobileno);
    _companynamecontroller =
        TextEditingController(text: widget.user.companyname);
    _locationcontroller = TextEditingController(text: widget.user.location);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _mobilenocontroller.dispose();
    _companynamecontroller.dispose();
    _locationcontroller.dispose();
  }

  void updaterecruiterdata() async {
    setState(() {
      _isloading = true;
    });
    await AuthMethods()
        .updateRecruiter(_companynamecontroller.text, _mobilenocontroller.text,
            _emailcontroller.text,_locationcontroller)
        .then((value) {
      setState(() {
        _isloading = false;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RecruiterHomePage()));
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
            "Update Recruiter Detail",
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
              textEditingController: _emailcontroller,
              hintText: "Enter email",
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 15,
          ),
          TextFieldInput(
              textEditingController: _locationcontroller,
              hintText: "Enter location",
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
                onPressed: updaterecruiterdata,
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
