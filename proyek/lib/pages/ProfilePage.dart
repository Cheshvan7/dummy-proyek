import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyek/login.dart';
import 'package:proyek/editProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  String uid() {
    var user = auth.currentUser;
    var uid = user?.uid;
    return uid!;
  }

  CollectionReference user = FirebaseFirestore.instance.collection('tbUser');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: (FutureBuilder(
            future: user.doc(uid()).get(),
            builder: (buildcontext, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  children: [
                    Container(
                      child: Text('nama:${data['nama']}'),
                    ),
                    Container(
                      child: Text('email:${data['email']}'),
                    ),
                    Container(
                      child: Text('Berat:${data['berat']}'),
                    ),
                    Container(
                      child: Text('Tinggi:${data['tinggi']}'),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              logout();
                            },
                            child: Text("Logout"),
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(0, 38, 77, 1.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 42, vertical: 6),
                                textStyle: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => editProfile()))
                                  .then(onGoBack);
                            },
                            child: Text("Edit Profile"),
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(0, 38, 77, 1.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 42, vertical: 6),
                                textStyle: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.lightBlueAccent,
                  ),
                ));
              }
            },
          )),
        ),
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {
      user = FirebaseFirestore.instance.collection('tbUser');
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Berhasil Edit Data"),
    ));
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
}
