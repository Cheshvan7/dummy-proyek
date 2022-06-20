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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Riwayat"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                    child: Image.asset(
                  'assets/logofitathomev2.png',
                  height: 150,
                )),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(24, 16, 8, 16),
                      child: Text(
                        "Nama :",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 16, 8, 16),
                      child: Text(
                        "datanya",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(24, 16, 8, 16),
                      child: Text(
                        "Email  :",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 16, 8, 16),
                      child: Text(
                        "datanya",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(24, 16, 8, 16),
                      child: Text(
                        "Berat Badan  :",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 16, 8, 16),
                      child: Text(
                        "datanya",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(24, 16, 8, 16),
                      child: Text(
                        "Tinggi Badan :",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 16, 8, 16),
                      child: Text(
                        "datanya",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(24, 16, 8, 16),
                      child: Text(
                        "BMI  :",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 16, 8, 16),
                      child: Text(
                        "datanya",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  ],
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
                                  builder: (context) => editProfile()));
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
            ),
          ),
        ));
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
}
