import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyek/dbOlahraga.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

enum WidgetMarker {
  piliholahraga, backup, jumpingjack, plank, pushup, situp
}

class PilihOlahraga extends StatefulWidget {
  const PilihOlahraga({ Key? key }) : super(key: key);

  @override
  State<PilihOlahraga> createState() => _PilihOlahragaState();
}

class _PilihOlahragaState extends State<PilihOlahraga> {

  final auth = FirebaseAuth.instance;

  List<String> nama = [];
  List<String> gambar = [];

  @override
  void initState() {
    super.initState();
    //_controllerVideoPlayer = VideoPlayerController.network("https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4");

    //_initVideoPlayerFuture = _controllerVideoPlayer.initialize();
  }

  @override
  void dispose() {
    //_controllerVideoPlayer.dispose();
    _controllerYoutubeBackup.dispose();
    _controllerYoutubeJumpingJack.dispose();
    _controllerYoutubePlank.dispose();
    _controllerYoutubePushUp.dispose();
    _controllerYoutubeSitUp.dispose();

    _youtubePlayerController.dispose();

    super.dispose();
  }

  @override
  void deactivate() {
   _controllerYoutubeBackup.pause();
    _controllerYoutubeJumpingJack.pause();
    _controllerYoutubePlank.pause();
    _controllerYoutubePushUp.pause();
    _controllerYoutubeSitUp.pause();

    _youtubePlayerController.pause();

    super.deactivate();
  }

  int checker = 0;

  var index = 0;

  WidgetMarker selectedWidgetMarker = WidgetMarker.piliholahraga;

  String? _dropdownValue = "Pilih Olahraga";

  void callback (String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;

        if (selectedValue == "Pilih Olahraga") {
          selectedWidgetMarker = WidgetMarker.piliholahraga;
          // if (checker == 1) {
          //   _controllerYoutubeBackup.dispose();
          // } else if (checker == 2) {
          //   _controllerYoutubeJumpingJack.dispose();
          // } else if (checker == 3) {
          //   _controllerYoutubePlank.dispose();
          // } else if (checker == 4) {
          //   _controllerYoutubePushUp.dispose();
          // } else if (checker == 5) {
          //   _controllerYoutubeSitUp.dispose();
          // }
        } else if (selectedValue == "Back Up") {
          selectedWidgetMarker = WidgetMarker.backup;
          // if (checker == 1) {
          //   _controllerYoutubeBackup.dispose();
          // } else if (checker == 2) {
          //   _controllerYoutubeJumpingJack.dispose();
          // } else if (checker == 3) {
          //   _controllerYoutubePlank.dispose();
          // } else if (checker == 4) {
          //   _controllerYoutubePushUp.dispose();
          // } else if (checker == 5) {
          //   _controllerYoutubeSitUp.dispose();
          // }
        } else if (selectedValue == "Jumping Jack") {
          selectedWidgetMarker = WidgetMarker.jumpingjack;
          // if (checker == 1) {
          //   _controllerYoutubeBackup.dispose();
          // } else if (checker == 2) {
          //   _controllerYoutubeJumpingJack.dispose();
          // } else if (checker == 3) {
          //   _controllerYoutubePlank.dispose();
          // } else if (checker == 4) {
          //   _controllerYoutubePushUp.dispose();
          // } else if (checker == 5) {
          //   _controllerYoutubeSitUp.dispose();
          // }
        }  else if (selectedValue == "Plank") {
          selectedWidgetMarker = WidgetMarker.plank;
          // if (checker == 1) {
          //   _controllerYoutubeBackup.dispose();
          // } else if (checker == 2) {
          //   _controllerYoutubeJumpingJack.dispose();
          // } else if (checker == 3) {
          //   _controllerYoutubePlank.dispose();
          // } else if (checker == 4) {
          //   _controllerYoutubePushUp.dispose();
          // } else if (checker == 5) {
          //   _controllerYoutubeSitUp.dispose();
          // }
        } else if (selectedValue == "Push Up") {
          selectedWidgetMarker = WidgetMarker.pushup;
          // if (checker == 1) {
          //   _controllerYoutubeBackup.dispose();
          // } else if (checker == 2) {
          //   _controllerYoutubeJumpingJack.dispose();
          // } else if (checker == 3) {
          //   _controllerYoutubePlank.dispose();
          // } else if (checker == 4) {
          //   _controllerYoutubePushUp.dispose();
          // } else if (checker == 5) {
          //   _controllerYoutubeSitUp.dispose();
          // }
        } else if (selectedValue == "Sit Up") {
          selectedWidgetMarker = WidgetMarker.situp;
          // if (checker == 1) {
          //   _controllerYoutubeBackup.dispose();
          // } else if (checker == 2) {
          //   _controllerYoutubeJumpingJack.dispose();
          // } else if (checker == 3) {
          //   _controllerYoutubePlank.dispose();
          // } else if (checker == 4) {
          //   _controllerYoutubePushUp.dispose();
          // } else if (checker == 5) {
          //   _controllerYoutubeSitUp.dispose();
          // }
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
          customContainer(),
          // Expanded(
          //   child: customContainer(),
          // )
        ],
      )
    );
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

  //late VideoPlayerController _controllerVideoPlayer;
  //late Future<void> _initVideoPlayerFuture;

  late YoutubePlayerController _controllerYoutubeBackup;
  late YoutubePlayerController _controllerYoutubeJumpingJack;
  late YoutubePlayerController _controllerYoutubePlank;
  late YoutubePlayerController _controllerYoutubePushUp;
  late YoutubePlayerController _controllerYoutubeSitUp;

  late YoutubePlayerController _youtubePlayerController;

  Widget pilihContainer() {
    checker = 0;
    
    return Container(
      child: Text("Pilih ya"),
    );
  }
  
  Widget backupContainer() {
    checker = 1;
    
    //_controllerYoutubeBackup
    _controllerYoutubeBackup = YoutubePlayerController(
        initialVideoId: "hnTuuGU50cs",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        )
      );

    return Column(
      children: [
        Container(child: Text("Jumping Jack Ini")),
        Container(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controllerYoutubeBackup,
              showVideoProgressIndicator: true,
            ),
            builder: (context, playerbackup) {
              return playerbackup;
            }
          ),
        ),
      ],
    );

    /*return FutureBuilder(
      future: _initVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controllerVideoPlayer.value.aspectRatio,
            child: VideoPlayer(_controllerVideoPlayer),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );*/
  }

  Widget jumpingjackContainer() {
    
    _controllerYoutubeJumpingJack = YoutubePlayerController(
        initialVideoId: "kRdnkN_P7WU",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        )
      );

    return Column(
      children: [
        Container(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controllerYoutubeJumpingJack,
              showVideoProgressIndicator: true,
            ),
            builder: (context, playerjumpingjack) {
              return playerjumpingjack;
            }
          ),
        ),
      ],
    );
  }

  Widget plankContainer() {
    checker = 3;
    
    //_controllerYoutubePlank
    _controllerYoutubePlank = YoutubePlayerController(
        initialVideoId: "hnTuuGU50cs",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        )
      );
    return Column(
      children: [
        Container(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controllerYoutubePlank,
              showVideoProgressIndicator: true,
            ),
            builder: (context, player) {
              return player;
            }
          ),
        ),
      ],
    );
  }

  Widget pushupContainer() {
    checker = 4;
    

    //_controllerYoutubePushUp
    _controllerYoutubePushUp = YoutubePlayerController(
        initialVideoId: "kRdnkN_P7WU",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        )
      );
    return Column(
      children: [
        Container(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controllerYoutubePushUp,
              showVideoProgressIndicator: true,
            ),
            builder: (context, player) {
              return player;
            }
          ),
        ),
      ],
    );
  }

  Widget situpContainer() {
    checker = 5;
    
    //_controllerYoutubeSitUp
    _controllerYoutubeSitUp = YoutubePlayerController(
        initialVideoId: "hnTuuGU50cs",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        )
      );
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controllerYoutubeSitUp,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return player;
      }
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