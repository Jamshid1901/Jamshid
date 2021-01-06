import 'package:flutter/material.dart';
import 'package:gafur/sceen/paly_music_sceen.dart';
import 'package:provider/provider.dart';
import 'package:gafur/musicprovider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => MusicProvider(),
           child:   MaterialApp(
            theme: ThemeData.light(),
              home: XylophoneApp(), title: "Gafur",)));

class XylophoneApp extends StatefulWidget {
  @override
  _XylophoneAppState createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {

   final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: Text(
            'Gafur Music',
            style: TextStyle(color: Colors.white),
          ),

        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              for(int i=0; i< Provider.of<MusicProvider>(context, listen: false).musicname.length;i++)
              buildRow(Provider.of<MusicProvider>(context, listen: false).musicname[i], i+1),

            ],
          ),
        ),
    );
  }

  Widget buildRow(String name,int number) {

    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {

                    Provider.of<MusicProvider>(context, listen: false).playMusic(number-1);
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PlayMusic(number: number,)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.black54,
                    width: MediaQuery.of(context).size.width/2,
                    child: Text(
                     name, // ,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                IconButton(
                    padding: EdgeInsets.all(1.0),
                    onPressed: () {
                      Provider.of<MusicProvider>(context, listen: false).playMusic(number);
                    },
                    icon: Icon(Icons.play_circle_outline)),
                IconButton(
                    padding: EdgeInsets.all(1.0),
                    onPressed: () {
                      Provider.of<MusicProvider>(context, listen: false).pauseMusic();
                    },
                    icon: Icon(Icons.pause_circle_outline)),

              ],
            ),
    );
  }
}

