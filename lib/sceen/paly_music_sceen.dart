import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:gafur/musicprovider.dart';
import 'package:flutter_volume_slider/flutter_volume_slider.dart';
import 'package:provider/provider.dart';
class PlayMusic extends StatefulWidget {
  final int number;


  const PlayMusic({Key key,@required this.number}) : super(key: key);

  @override
  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  CountDownController _controller = CountDownController();

  DateTime alert;
  double _angle=0;
  int maxVol, currentVol;
  double sliderValue ;
  String abs;
  int y;
  @override
  void initState() {

    super.initState();
    updateVolumes();
    alert = DateTime.now().add(Duration(seconds: 10));

  }


  updateVolumes() async {
    // get Max Volume
    sliderValue = currentVol.toDouble();
    setState(() {});
  }

  setVol(int i) async {
  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(milliseconds: 60), (){
      setState(() {
        _angle=_angle+0.05;
      });
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Music',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Icon(Icons.menu),
        ],
      ),
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StreamBuilder(
            stream: Provider.of<MusicProvider>(context,listen: false).assetsAudioPlayer.current,
            builder: (BuildContext context,
                AsyncSnapshot<Playing> snapshot) {
              if (snapshot.hasData) {
                snapshot.data.audio.duration.inSeconds;


                return Stack(
                  children: [
                    Container(
                      child: CircularCountDownTimer(
                        duration: snapshot.data.audio.duration.inSeconds,
                        // Controller to control (i.e Pause, Resume, Restart) the Countdown
                        controller: _controller,

                        // Width of the Countdown Widget
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.5,

                        // Height of the Countdown Widget
                        height: MediaQuery
                            .of(context)
                            .size
                            .width / 1.5,

                        // Default Color for Countdown Timer
                        color: Colors.white,

                        // Filling Color for Countdown Timer
                        fillColor: Colors.blueAccent,

                        // Background Color for Countdown Widget
                        backgroundColor: null,

                        // Border Thickness of the Countdown Circle
                        strokeWidth: 5.0,

                        // true for reverse countdown (max to 0), false for forward countdown (0 to max)
                        isReverse: false,

                        // true for reverse animation, false for forward animation
                        isReverseAnimation: false,

                        // Optional [bool] to hide the [Text] in this widget.
                        isTimerTextShown: false,

                        // Function which will execute when the Countdown Ends
                      ),

                    ),

                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.5,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width / 1.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: Transform.rotate(
                            angle: _angle,
                            child: Container(
                              margin: EdgeInsets.all(30.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: NetworkImage(
                                          "https://root-nation.com/wp-content/uploads/2020/05/apple-music.jpg"))),
                              child: Center(
                                child: Container(
                                    margin: EdgeInsets.all(80.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white
                                    )),
                              ),
                            ),
                          )),
                    ),
                  ],
                );
              }else if(snapshot.hasError){
                 return Text('${snapshot.hasError}');
              }else{
                return Text("Keyngi musikaga otkazing :) !!!");
              }
            },
          ),

          TimerBuilder.scheduled([alert], builder: (context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  PlayerBuilder.currentPosition(
                      player: Provider.of<MusicProvider>(context,listen: false).assetsAudioPlayer,
                      builder: (context, duration) {
                        return Text(duration.toString().substring(2, 7),style: TextStyle(fontSize: 20.0),);

                      }
                  )
                ],
              ),
            );
          }),
          Text(
            Provider.of<MusicProvider>(context,listen: false).getmusic(),
            style: TextStyle(fontSize: 25.0),
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.fast_rewind),
                onPressed: () {
                   setState(() {
                     if(0<Provider.of<MusicProvider>(context,listen: false).musicname.length) {
                       Provider.of<MusicProvider>(context, listen: false)
                           .prevMusic();
                     }
                   });
                  },
              ),
              GestureDetector(
                onTap: () {
                    setState(() {

                    if (Provider.of<MusicProvider>(context,listen: false).isplay) {
                      Provider.of<MusicProvider>(context,listen: false).ischange(false);
                      _controller.resume();
                Provider.of<MusicProvider>(context, listen: false).pauseMusic();
                    } else {
                      Provider.of<MusicProvider>(context,listen: false).ischange(true);
                      _controller.pause();
                Provider.of<MusicProvider>(context, listen: false).pauseMusic();
                    }

                    });
                },
                child: Container(
                  padding: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black26, width: 2.5)),
                  child: Icon( Provider.of<MusicProvider>(context,  listen: false).isplay ? Icons.play_arrow :Icons.pause),
                ),
              ),
              IconButton(
                icon: Icon(Icons.fast_forward),
                onPressed: () {
                  if(Provider.of<MusicProvider>(context,listen: false).number<Provider.of<MusicProvider>(context,listen: false).musicname.length-1) {
                    Provider.of<MusicProvider>(context, listen: false)
                        .nextMusic();
                  }


                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [

                FlutterVolumeSlider(
                  display: Display.HORIZONTAL,
                  sliderActiveColor: Colors.blue,
                  sliderInActiveColor: Colors.grey,
                ),
                // StreamBuilder(stream: ,builder: null)
              ],
          )
        ],
      ),
    );
  }

  String formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // We want to round up the remaining time to the nearest second
    d += Duration(microseconds: 999999);
    return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
  }
}
String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes =
  twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  String twoDigitSeconds =
  twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return "$twoDigitMinutes:$twoDigitSeconds";
}
