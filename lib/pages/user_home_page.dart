import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech/model/user_model.dart' as model;
import 'package:notech/pages/user_update_page.dart';
import 'package:notech/utils/colors.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  User? user = FirebaseAuth.instance.currentUser;

  model.User loggedinUser = model.User();
  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    this.loggedinUser = model.User.fromSnap(snap);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notech"),
        backgroundColor: blueColor,
      ),
      body: const Center(
        child: Text('Job Search'),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '${loggedinUser.username}',
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Personal Information",
                    style: TextStyle(fontSize: 18, color: blueColor),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserUpdateScreen(
                                    user: model.User(
                                        username: loggedinUser.username,
                                        email: loggedinUser.email,
                                        mobileno: loggedinUser.mobileno))));
                      },
                      child: Icon(Icons.edit))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 204, 204, 208),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.email),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            '${loggedinUser.email}',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.call),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            '${loggedinUser.mobileno}',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Resumes",
                    style: TextStyle(fontSize: 18, color: blueColor),
                  ),
                  GestureDetector(onTap: () {}, child: Icon(Icons.attachment))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
