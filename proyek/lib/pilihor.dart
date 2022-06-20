import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyek/dbOlahraga.dart';
import 'package:video_player/video_player.dart';
import 'global.dart' as global;

enum WidgetMarker {
  piliholahraga, backup, jumpingjack, plank, pushup, situp
}

class PilihOlahraga extends StatefulWidget {
  const PilihOlahraga({ Key? key }) : super(key: key);

  @override
  State<PilihOlahraga> createState() => _PilihOlahragaState();
}

class _PilihOlahragaState extends State<PilihOlahraga> {

  late VideoPlayerController _controller;
  late Future<void> _initVideoPlayerFuture;

  final auth = FirebaseAuth.instance;

  List<String> nama = [];
  List<String> gambar = [];

  @override
  void initState() {
    

    super.initState();
  }

  var index = 0;

  WidgetMarker selectedWidgetMarker = WidgetMarker.piliholahraga;

  String? _dropdownValue = "Pilih Olahraga";

  void callback (String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;

        if (selectedValue == "Pilih Olahraga") {
          selectedWidgetMarker = WidgetMarker.piliholahraga;
        } else if (selectedValue == "Back Up") {
          selectedWidgetMarker = WidgetMarker.backup;
        } else if (selectedValue == "Jumping Jack") {
          selectedWidgetMarker = WidgetMarker.jumpingjack;
        }  else if (selectedValue == "Plank") {
          selectedWidgetMarker = WidgetMarker.plank;
        } else if (selectedValue == "Push Up") {
          selectedWidgetMarker = WidgetMarker.pushup;
        } else if (selectedValue == "Sit Up") {
          selectedWidgetMarker = WidgetMarker.situp;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Olahraga"),
      ),

      body: Column(
        children: <Widget> [
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: DropdownButton(
              isExpanded: true,
              items: const [
                DropdownMenuItem(child: Text("Pilih Olahraga"), value: "Pilih Olahraga",),
                DropdownMenuItem(child: Text("Back Up"), value: "Back Up",),
                DropdownMenuItem(child: Text("Jumping Jack"), value: "Jumping Jack",),
                DropdownMenuItem(child: Text("Plank"), value: "Plank",),
                DropdownMenuItem(child: Text("Push Up"), value: "Push Up",),
                DropdownMenuItem(child: Text("Sit Up"), value: "Sit Up",)
              ],
              value: _dropdownValue,
              onChanged: callback
            )
          ),
          customContainer()
          // Expanded(
          //   child: customContainer(),
          // )
        ],
      )

      // body: Container(
      //   padding: EdgeInsets.all(16),
      //   child: Column(
      //     children: [
      //       Expanded(
      //         child: StreamBuilder<QuerySnapshot>(
      //           stream: DatabaseOlahraga.getData(),
      //           builder: (context, snapshot) {
      //             if (snapshot.hasData) {
      //               return ListView.separated(
      //                 itemBuilder: (context, index) {
      //                   DocumentSnapshot dataOR = snapshot.data!.docs[index];
                        
      //                   nama.add(dataOR['nama']);
      //                   gambar.add(dataOR['gambar']);
      //                   global.isChecked.add(false);

      //                   return CheckboxListTile(
      //                     title: Column(
      //                       children: [
      //                         Container(
      //                           child: Text(nama[index]),
      //                         ),
      //                         Container(
      //                           child: Image.asset('assets/${gambar[index]}')
      //                         ),
      //                       ],
      //                     ),
      //                     value: global.isChecked[index],
      //                     onChanged: (val) {
      //                       setState(() {
      //                         global.isChecked[index] = val!;
      //                       });
      //                     }
      //                   );
      //                 },
      //                 separatorBuilder: (context, index) => SizedBox(height: 8),
      //                 itemCount: snapshot.data!.docs.length
      //               );
      //             } else {
      //               return const Center(
      //                 child: CircularProgressIndicator(
      //                   valueColor: AlwaysStoppedAnimation<Color> (
      //                     Colors.lightBlueAccent,
      //                   ),
      //                 )
      //               );
      //             }
      //           },
      //         )
      //       ),
      //       Container(
      //         padding: EdgeInsets.all(16),
      //         width: double.infinity,
      //         child: ElevatedButton(onPressed: () {}, child: Text("START"),),
      //       )
            
      //     ],
      //   )
      // ),
    )
    ;
  }

  Widget customContainer() {
    switch (selectedWidgetMarker) {
      case WidgetMarker.piliholahraga:
        return pilihContainer();
      case WidgetMarker.backup:
        return backupContainer();
      case WidgetMarker.jumpingjack:
        return jumpingjackContainer();
      case WidgetMarker.plank:
        return plankContainer();
      case WidgetMarker.pushup:
        return pushupContainer();
      case WidgetMarker.situp:
        return situpContainer();
    }

    return pilihContainer();
  }

  Widget pilihContainer() {
    return Container(
      child: Text("Pilih ya"),
    );
  }
  
  Widget backupContainer() {
    return Container(
      child: Text("Back Up"),
    );
  }

  Widget jumpingjackContainer() {
    return Container(
      child: Text("Jumpign Jack"),
    );
  }

  Widget plankContainer() {
    return Container(
      child: Text("Plank"),
    );
  }

  Widget pushupContainer() {
    return Container(
      child: Text("Push Up"),
    );
  }

  Widget situpContainer() {
    return Container(
      child: Text("Sit Up"),
    );
  }
}

class Model {
  String nama;
  String gambar;
  bool check;

  Model(this.nama, this.gambar, this.check);

  String getNama() {
    return nama;
  }

  String getGambar() {
    return gambar;
  }

  bool isChecked() {
    return check;
  }
}