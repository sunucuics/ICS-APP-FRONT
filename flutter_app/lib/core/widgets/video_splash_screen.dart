import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_wrapper.dart';

class VideoSplashScreen extends StatefulWidget {
  const VideoSplashScreen({super.key});

  @override
  State<VideoSplashScreen> createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _checkFirstRun();
  }

  Future<void> _checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    // Check if this is the first run
    // If 'first_run_complete' is NOT set, it means it's the first run (or we treat it as such)
    final bool firstRunComplete = prefs.getBool('first_run_complete') ?? false;

    if (firstRunComplete) {
      // Not first run, skip video
      _navigateToNextScreen();
    } else {
      // First run, initialize and play video
      _initializeVideo();
    }
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.asset('assets/baslangic-video.mp4');
    
    try {
      await _controller.initialize();
      setState(() {
        _isInitialized = true;
      });
      
      await _controller.play();
      
      // Timer for exactly 5 seconds as requested
      Timer(const Duration(seconds: 5), () {
        _onVideoComplete();
      });
      
    } catch (e) {
      // If video fails to load, skip to next screen
      print('Video initialization failed: $e');
      _navigateToNextScreen();
    }
  }

  Future<void> _onVideoComplete() async {
    // Mark first run as complete
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_run_complete', true);
    
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    if (!mounted) return;
    
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const AuthWrapper(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      // Show black screen or loading while checking prefs/initializing video
      return const Scaffold(
        backgroundColor: Colors.black,
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
    );
  }
}
