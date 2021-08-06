import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
 Color backgroundColor=Colors.black;
 Color borderColor=Colors.grey;
 Color conColor=Colors.black;
 double pos=0;
 late AnimationController controller;
 late AudioPlayer audioPlayer;
 late Animation<double> animation;


 @override
  void initState() {
   audioPlayer=AudioPlayer();
    // TODO: implement initState
    super.initState();
    controller=AnimationController(vsync: this,duration: Duration(milliseconds: 400));
    animation=Tween<double>(begin: 1,end: 0).animate(controller);
    controller.addListener(() {setState(() {});});
  }

 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {AudioCache audioCache=AudioCache(fixedPlayer: audioPlayer);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child:Stack(
          alignment: Alignment.center,
          children: [
            SafeArea(
                child: Stack(
                  children: [
                    Opacity(
                      opacity: animation.value/5,
                      child: Image(fit: BoxFit.cover,
                          image: AssetImage("assets/n.jpg")
                      ),
                    ),
                    Opacity(
                      opacity: controller.value/5,
                      child: Image(fit: BoxFit.cover,
                          image: AssetImage("assets/d.jpg")),
                    )
                  ],
                )
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  if(pos==0){
                    audioCache.play('day.mp3');
                    controller.forward();
                    conColor=Colors.yellow.shade400;
                    backgroundColor=Colors.white;
                    borderColor=Colors.black;

                    pos=55;
                  }else{
                    audioCache.play('night.wav');

                    controller.reverse();
                    borderColor=Colors.grey;
                    conColor=Colors.black;
                    backgroundColor=Colors.black;
                    pos=0;
                  }
                });
              },

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Opacity(
                        opacity: 0.8,
                        child: Container(
                          width: 110,height: 55,
                          decoration: BoxDecoration(
                              color: conColor,
                              border: Border.all(color: borderColor,width: 2),
                              borderRadius: BorderRadius.circular(30)
                          ),
                        ),
                      ),

                      AnimatedPositioned(
                        duration: Duration(milliseconds: 900),
                        curve: Curves.decelerate,
                        left: pos,
                        child: Stack(
                          children: [
                            Container(
                              width: 55,height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child:  Image(fit: BoxFit.cover,
                                  image: AssetImage("assets/off.png")
                              ),

                            ),
                            Opacity(
                              opacity: controller.value,
                              child: Container(
                                width: 55,height: 55,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child:  Image(fit: BoxFit.cover,
                                    image: AssetImage("assets/on.png")
                                ),

                              ),
                            ),

                          ],
                        )
                      ),
                    ],
                  )
                ],
              ),
            )

          ],
        )
      )
    );
  }
}
