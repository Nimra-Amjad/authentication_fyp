import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? uid;
  String? username;
  String? email;
  String? mobileno;

  User({this.uid, this.username, this.email, this.mobileno});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot["uid"],
      username: snapshot["username"],
      email: snapshot["email"],
      mobileno: snapshot["mobileno"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "username": username,
        "mobileno": mobileno,
      };
}
