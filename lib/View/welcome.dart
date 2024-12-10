import 'package:flutter/material.dart';
import 'package:guidedlayout2_1748/View/login.dart';
import 'package:guidedlayout2_1748/View/register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; // Animasi teks

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  double _scale = 0.8;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    // Animasi untuk logo fade-in dan scale
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
        _scale = 1.0;
      });
    });

    // Animasi pulsating untuk logo
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3E5FC), // Background color light blue
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo dengan animasi fade-in, scale, dan pulsating
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: _opacity,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.1).animate(
                    CurvedAnimation(
                      parent: _pulseController,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Custom Logo Image
                        Image.asset(
                          'assets/imagesGYM.png', // Logo GYM
                          width: 200,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "STAY FIT , STAY STRONG",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // Welcome Text dengan gradient color
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      '!!! WELCOME TO !!!',
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      colors: [Colors.black, Colors.blue, Colors.green, Colors.orange],
                    ),
                  ],
                  isRepeatingAnimation: true,
                ),
              ),
              const SizedBox(height: 10),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Gym In\nFitness Zone',
                      textStyle: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      colors: [Colors.purple, Colors.red, Colors.blue, Colors.cyan],
                    ),
                  ],
                  isRepeatingAnimation: true,
                ),
              ),
              const SizedBox(height: 50),

              // Tombol Log in
              GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                    msg: "Silahkan Login...",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const LoginView(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 300, // Lebar tombol
                  height: 40, // Tinggi tombol
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30), // Sudut
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Tombol Registrasi
              GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                    msg: "Silahkan Registrasi...",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const RegisterView(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 300, // Lebar tombol
                  height: 40, // Tinggi tombol
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(30), // Sudut
                  ),
                  child: const Center(
                    child: Text(
                      'Registrasi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
