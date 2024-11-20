import 'package:crop_care/disease_detection_page.dart';
import 'package:flutter/material.dart';

import 'crop_prediction_model.dart';

class CropCareHomePage extends StatefulWidget {
  @override
  _CropCareHomePageState createState() => _CropCareHomePageState();
}

class _CropCareHomePageState extends State<CropCareHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.eco,
          color: Colors.green,
          size: 30,
        ),
        title: const Text(
          'CropCare',
          style: TextStyle(
            color: Colors.green,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.green,
          tabs: const [
            Tab(text: 'Disease Detection'),
            Tab(text: 'Crop Prediction'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          DiseaseDetectionPage(), // Replace with your widget
          CropPredictionPage(), // Crop Prediction UI
        ],
      ),
    );
  }
}
