// lib/main.dart

import 'package:crop_care/on_boarding.dart';
import 'package:flutter/material.dart';
// Import the new file

void main() {
  runApp(CropCareApp());
}

class CropCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
    );
  }
}
