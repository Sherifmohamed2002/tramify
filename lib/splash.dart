import 'package:app/welcome.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _circleController;
  late AnimationController _logoController;
  late Animation<double> _circleAnimation;
  late Animation<double> _logoFade;

  @override
  void initState() {
    super.initState();

    // Circle reveal controller
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _circleAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: _circleController, curve: Curves.easeOut),
    );

    // Logo fade-in controller
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _logoFade = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    // Start both animations almost together
    _circleController.forward();
    _logoController.forward();

    // Transition to Welcome screen once all animations are done
    Future.delayed(const Duration(milliseconds: 2200), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, __, ___) => const WelcomePage(),
          transitionsBuilder:
              (_, animation, __, child) =>
                  FadeTransition(opacity: animation, child: child),
        ),
      );
    });
  }

  @override
  void dispose() {
    _circleController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _circleAnimation,
            builder: (_, __) {
              return ClipPath(
                clipper: CircleClipper(_circleAnimation.value, screenSize),
                child: Container(color: const Color(0xFF09122C)),
              );
            },
          ),
          FadeTransition(
            opacity: _logoFade,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'images/logo.png',
                  width: screenSize.width * 0.4,
                  height: screenSize.width * 0.4,
                ),
                const SizedBox(height: 16),
                const Text(
                  "TRAMIFY",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  final double scale;
  final Size screenSize;

  CircleClipper(this.scale, this.screenSize);

  @override
  Path getClip(Size size) {
    final center = Offset(screenSize.width / 2, screenSize.height / 2);
    final radius = screenSize.longestSide * scale;
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
