import 'package:flutter/material.dart';

class FirstSplash extends StatefulWidget {
  final AnimationController animationController;

  const FirstSplash({Key? key, required this.animationController})
      : super(key: key);

  @override
  _FirstSplashState createState() => _FirstSplashState();
}

class _FirstSplashState extends State<FirstSplash> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 170,
              ),
              Center(
                child: SizedBox(
                  height: 160, // Adjust the height as needed
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4), // Shadow color
                          spreadRadius: 5, // Spread radius
                          blurRadius: 24, // Blur radius
                          // offset: const Offset(1, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/logos/splash.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  "Your welcome!",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 64, right: 64),
                child: Text(
                  "Welcome to SmartRental  application where you can feed all of your needs "
                  "concerning to home ",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 16),
                child: InkWell(
                  onTap: () {
                    widget.animationController.animateTo(0.2);
                  },
                  child: Container(
                    height: 58,
                    padding: const EdgeInsets.only(
                      left: 56.0,
                      right: 56.0,
                      top: 16,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38.0),
                      color: const Color(0xff132137),
                    ),
                    child: const Text(
                      "lets start",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
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
