import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize wave animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _waveAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Timer for navigation
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacementNamed(context, '/home'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color(0xFF1B263B),
                  Color(0xFF0D1B2A),
                ],
                center: Alignment.center,
                radius: 1.2,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _waveAnimation,
            builder: (context, child) {
              return Positioned(
                bottom: -50 + (_waveAnimation.value * 20),
                left: -50,
                child: Transform.rotate(
                  angle: _waveAnimation.value * 0.3,
                  child: Opacity(
                    opacity: 0.6,
                    child: Container(
                      width: screenWidth + 100,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Color(0xFF415A77),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(150),
                          topRight: Radius.circular(150),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.2),
                        blurRadius: 50,
                        spreadRadius: 40,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/splash.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'MY QR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Scan & Create Instantly',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.white24,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blueAccent.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
