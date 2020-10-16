import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  // @override
  // void initState() {
  //   _animationController = AnimationController();
  //   _colorTween = _animationController
  //       .drive(ColorTween(begin: Colors.grey[600], end: Colors.green[600]));

  //   _animationController.repeat();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Text('Loading...'),
      ),
    );
  }
}
