import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../dbservices.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({ Key? key }) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  int _index = 0;

  FirebaseAuth auth = FirebaseAuth.instance;

  

  /*@override
  void initState() {

    super.initState();
  }*/

  String getEmail() {
    var user = auth.currentUser;
    var email = user?.email;
    return email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Database.getData(getEmail()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error");
                } else {
                  return ListView.separated(itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data!.docs[index];
                      String lvTanggal = data['tanggal'];
                      String lvKalori = data['kalori'];
                      String lvDurasi = data['durasi'];
                      return ListTile(
                        onTap: () {},
                        onLongPress: () {},
                        title: Text(lvTanggal),
                        subtitle: Text("$lvDurasi menit \n$lvKalori kalori")
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemCount: snapshot.data!.docs.length
                  );
                }
              },
            ),
          ),
        ], 
      ),
    );
  }
}