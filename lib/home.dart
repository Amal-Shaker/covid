// import 'package:audioplayers/audioplayers.dart';
import 'dart:typed_data';

import 'package:covid/all_clinic.dart';
import 'package:covid/death_case_chart.dart';
import 'package:covid/map_page.dart';
import 'package:covid/model/clinic.dart';
import 'package:covid/new_case_chart.dart';
import 'package:covid/provider/my_provider.dart';
import 'package:covid/video_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'api_helper.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> list = [
    'Map',
    'All clinic',
    'New case chart',
    'Death case chart',
    'Video'
  ];

  List<String> images = [
    'assets/images/map.png',
    'assets/images/clinic.png',
    'assets/images/chart.png',
    'assets/images/chart.png',
    'assets/images/video.jpg'
  ];
  AudioPlayer audioPlayer = AudioPlayer();

  playLocal() async {
    ByteData bytes =
        await rootBundle.load('assets/music.mp3'); //load audio from assets
    Uint8List audiobytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    int result = await audioPlayer.playBytes(audiobytes);
    if (result == 1) {
      print("audio is playing.");
    } else {
      print("Error while playing audio.");
    }
  }

  stopLocal() async {
    audioPlayer.stop();
  }

  @override
  void initState() {
    super.initState();
    playLocal();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(builder: (context, provider, g) {
      return Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("English"),
                    onTap: () {
                      setState(() {
                        context.deleteSaveLocale();

                        context.setLocale(Locale('en'));
                      });
                    },
                  ),
                  PopupMenuItem<int>(
                      value: 1,
                      child: Text("Chinese"),
                      onTap: () {
                        setState(() {
                          context.deleteSaveLocale();
                          context.setLocale(Locale('zh'));
                        });
                      }),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Text("malay"),
                    onTap: () {
                      setState(() {
                        context.deleteSaveLocale();
                        context.setLocale(Locale('ms'));
                      });
                    },
                  ),
                ];
              },
            ),
          ],
          backgroundColor: Colors.green[900],
          title: Center(child: Text('home_title'.tr())),
        ),
        body: GridView.builder(
            itemCount: list.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 18, mainAxisSpacing: 12),
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  height: 250,
                  margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Container(
                          height: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(images[index])))),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "index$index".tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  print(index);
                  if (index == 0) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MapPage()));
                  }
                  if (index == 1) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AllClinic()));
                  }
                  if (index == 2) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NewCaseChart()));
                  }
                  if (index == 3) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DeathCaseChart()));
                  }

                  if (index == 4) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const VideoPlayerScreen()));
                  }
                },
              );
            }),
      );
    });
  }
}
