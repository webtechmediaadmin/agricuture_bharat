import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../constant/app_preferences.dart';
import '../constant/constant.dart';
import 'bottom_nav_bar.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
     _controller = VideoPlayerController.asset('assets/videos/splash.mp4')
        ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
          );
        });
      }
    });
    getValues();
  }

  getValues() async {
    var token = await PreferenceApp().getAccessToken();
    MyConstant.access_token = token ?? "";
    var userLogin = await PreferenceApp().getIsNewUser();
    MyConstant.myBoolValue = userLogin;
    print("${MyConstant.myBoolValue}");
    print(
        "first time user access ${MyConstant.access_token = token ?? "empty token"} ");
  }

    @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}