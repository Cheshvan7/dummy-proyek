import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyek/dcProfile.dart';
import 'package:proyek/main.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();

    super.dispose();
  }

  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  var _passwordVisibility = true;
  var _passwordConfirmVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  child: Image.asset('assets/logofitathomev2.png',height: 100,)
                ),
                Container(
                  child: Text("Register", style: TextStyle(fontSize: 20),),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: TextFormField(
                    controller:_namaController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: "Nama"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Nama tidak boleh kosong!");
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                      labelText: "Email"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Email tidak boleh kosong!");
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _passwordConfirmVisibility,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.vpn_key),
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordConfirmVisibility
                          ? Icons.visibility
                          : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordConfirmVisibility = !_passwordConfirmVisibility;
                          });
                        },
                      )
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Password tidak boleh kosong!");
                      }
                      if (value.length < 6) {
                        return("min. character password adalah 6");
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: TextFormField(
                    controller: _confirmpasswordController,
                    keyboardType: TextInputType.number,
                    obscureText: _passwordVisibility,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.vpn_key),
                      border: OutlineInputBorder(),
                      labelText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisibility
                          ? Icons.visibility
                          : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisibility = !_passwordVisibility;
                          });
                        },
                      )
                    ),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return("Password tidak sama!");
                      }
                      if (value!.isEmpty) {
                        return("Tidak boleh kosong!");
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {register(_emailController.text.toString(), _passwordController.text.toString());},
                    child: Text("REGISTER")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register(String email, String pass) async {
    if (_formkey.currentState!.validate()) {
      await _auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) => addData())
        .catchError((e) {
          SnackBar(content: Text("${e.message}"));
        });
      }
  }

  addData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    dcProfile profile = dcProfile();

    profile.email = user!.email;
    profile.uid = user.uid;
    profile.nama = _namaController.text;
    profile.password = _passwordController.text;

    await firestore
      .collection("tbUser")
      .doc(user.uid)
      .set(profile.toJson());
    SnackBar(content: Text("Akun telah dibuat"));

    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
  }
}