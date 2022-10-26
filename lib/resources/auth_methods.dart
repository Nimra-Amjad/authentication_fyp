import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notech/model/user_model.dart' as model;
import 'package:notech/model/recruiter_model.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  //UPDATE RECRUITER
  Future<void> updateRecruiter(companyname, mobileno, email,location) async {
    final userCollection = _firestore.collection("recruiters");
    final docref = userCollection.doc(user!.uid);
    try {
      await docref
          .update({'companyname': companyname, 'email': email, 'mobileno': mobileno,'location':location});
    } catch (e) {
      print("some error occured");
    }
  }

  //SIGN UP RECRUITER
  Future<String> signupRecruiter({
    required String email,
    required String companyname,
    required String mobileno,
    required String location,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          companyname.isNotEmpty ||
          mobileno.isNotEmpty ||
          location.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        //add user to our database
        model.Recruiter user = model.Recruiter(
          companyname: companyname,
          uid: cred.user!.uid,
          email: email,
          mobileno: mobileno,
          location:location
        );

        await _firestore
            .collection("recruiters")
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "ERROR_INVALID_EMAIL") {
        res = "Your email is invalid";
      } else if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        res = "Email is already in use on different account";
      } else if (e.code == "ERROR_INVALID_CREDENTIAL") {
        res = "Your email is invalid";
      }
    }
    return res;
  }


  //UPDATE USER
  Future<void> update(username, mobileno, email) async {
    final userCollection = _firestore.collection("users");
    final docref = userCollection.doc(user!.uid);
    try {
      await docref
          .update({'username': username, 'email': email, 'mobileno': mobileno});
    } catch (e) {
      print("some error occured");
    }
  }


  //SIGN UP USER
  Future<String> signupUser({
    required String email,
    required String username,
    required String mobileno,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          mobileno.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        //add user to our database
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          mobileno: mobileno,
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "ERROR_INVALID_EMAIL") {
        res = "Your email is invalid";
      } else if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        res = "Email is already in use on different account";
      } else if (e.code == "ERROR_INVALID_CREDENTIAL") {
        res = "Your email is invalid";
      }
    }
    return res;
  }

  //LOGGING IN USER

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "successfully loggedin";
      } else if (email.isEmpty) {
        res = "Please enter email";
      } else if (password.isEmpty) {
        res = "Please enter password";
      } else {
        res = "Please enter all fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        res = "Wrong password entered";
      } else if (e.code == 'user-not-found') {
        res = "User not found\nPlease enter correct email";
      }
    }
    return res;
  }
}
