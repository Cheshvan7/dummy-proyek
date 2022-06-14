import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyek/firebase_options.dart';
import 'package:proyek/home.dart';
import 'package:proyek/main.dart';
import 'package:proyek/register.dart';



class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  @override
  void dispose() {
    _controllerPassword.dispose();
    _controllerEmail.dispose();

    super.dispose();
  }

  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  var _passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Image.asset('assets/logofitathomev2.png')
              ),
              
              Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextFormField(
                  controller: _controllerEmail,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: "Masukkan Email"
                  ),
                  validator: (value) {
                      if (value!.isEmpty) {
                        return ("Email tidak boleh kosong!");
                      }
                    },
                ),
              ),
              
              Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextFormField(
                  controller: _controllerPassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.vpn_key),
                    labelText: "Masukkan Password",
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
                  obscureText: _passwordVisibility,
                  validator: (value) {
                      if (value!.isEmpty) {
                        return ("Password tidak boleh kosong!");
                      }
                    },
                ),
              ),
              
              Container(
                child: ElevatedButton(
                  onPressed: () {signin(_controllerEmail.text.toString(), _controllerPassword.text.toString());},
                  child: Text("Login")),
              ),
              
              Container(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Column(
                  children: [
                    Text("Belum punya akun ?"),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                    }, child: Text("REGISTER"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signin (String email, String pass) async {
    if(_formkey.currentState!.validate()) {
      await _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) => {
          SnackBar(content: Text("Login sukses")),
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()))
        });
    }
  }

  void checkUser() {
    var user = _auth.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
  }
}