import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
class MusicProvider extends ChangeNotifier {
 int number;
 int time = 0;
  bool isplay=false;
  Audio ent;
 AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);


  final assetsAudioPlayer = AssetsAudioPlayer();

    List<String> musicname = [
    'Gafur - Ok okeй ',
    'Gafur - Борьба',
    'Gafur - Луна (Remix)',
    'Gafur - Оставь',
    'Gafur - Не Могу Терпеть',
    'Gafur - Нашёл тебя',
    'Gafur - Хитрая змея',
    'Gafur - Атом ',
    'Gafur - Ты не моя ',
    'Gafur - Lollipop',
    'Gafur - Milliy Bola ',
    'Gafur - Мария',
    'Gafur - Нашёл тебя',
    'Gafur - Ты одна'
  ];



   void playMusic(int _number)async{

    number=_number;
   await assetsAudioPlayer.open(
        Playlist(
            audios: [
            ent = Audio("assets/Gafur$_number.mp3"),

            ]
        ),

    );
}

 
void pauseMusic(){

  assetsAudioPlayer.playOrPause();
}
void nextMusic(){
    if(number<musicname.length-1) {
      assetsAudioPlayer.stop();
      number++;
      playMusic(number);
      isplay = false;

    }
}
void prevMusic(){
  if(0<number) {
    assetsAudioPlayer.stop();
    number--;
    playMusic(number);
    isplay = false;
  }
}
void ischange(bool change){
  isplay = change;
}
String getmusic(){
    String title=musicname[number];
    return title;
}

}
