import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black.withOpacity(0.5),
      child: Center(child: CircularProgressIndicator()),
    ));
  }
}
