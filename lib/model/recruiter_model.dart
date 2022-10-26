import 'package:cloud_firestore/cloud_firestore.dart';

class Recruiter {
  String? uid;
  String? companyname;
  String? email;
  String? mobileno;
  String? location;

  Recruiter(
      {this.uid, this.companyname, this.email, this.mobileno, this.location});

  static Recruiter fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Recruiter(
      uid: snapshot["uid"],
      companyname: snapshot["companyname"],
      email: snapshot["email"],
      mobileno: snapshot["mobileno"],
      location: snapshot["location"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "companyname": companyname,
        "mobileno": mobileno,
        'location': location
      };
}
