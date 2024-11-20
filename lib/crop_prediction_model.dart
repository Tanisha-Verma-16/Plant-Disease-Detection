import 'package:flutter/material.dart';
import 'package:crop_care/models/crop_prediction_model.dart';

class CropPredictionPage extends StatefulWidget {
  const CropPredictionPage({Key? key}) : super(key: key);

  @override
  _CropPredictionPageState createState() => _CropPredictionPageState();
}

class _CropPredictionPageState extends State<CropPredictionPage> {
  final CropPredictionModel model = CropPredictionModel();
  final TextEditingController nController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  final TextEditingController kController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController humidityController = TextEditingController();
  final TextEditingController phController = TextEditingController();
  final TextEditingController rainfallController = TextEditingController();
  String result = "No recommendation yet";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    await model.loadModel();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> performPrediction() async {
    if (_isLoading) {
      // Optionally show a loading indicator or message
      return;
    }

    try {
      double n = double.parse(nController.text);
      double p = double.parse(pController.text);
      double k = double.parse(kController.text);
      double temperature = double.parse(temperatureController.text);
      double humidity = double.parse(humidityController.text);
      double ph = double.parse(phController.text);
      double rainfall = double.parse(rainfallController.text);

      String prediction =
          await model.predictCrop(n, p, k, temperature, humidity, ph, rainfall);

      setState(() {
        result = prediction;
      });
    } catch (e) {
      // Handle parsing errors or prediction errors
      setState(() {
        result = "Error: ${e.toString()}";
      });
    }
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crop Recommendation',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nController,
                decoration: const InputDecoration(
                  labelText: 'N - Nitrogen content in soil',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: pController,
                decoration: const InputDecoration(
                  labelText: 'P - Phosphorous content in soil',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: kController,
                decoration: const InputDecoration(
                  labelText: 'K - Potassium content in soil',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: temperatureController,
                decoration: const InputDecoration(
                  labelText: 'Temperature (°C)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: humidityController,
                decoration: const InputDecoration(
                  labelText: 'Humidity (%)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phController,
                decoration: const InputDecoration(
                  labelText: 'pH value of the soil',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: rainfallController,
                decoration: const InputDecoration(
                  labelText: 'Rainfall (mm)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: performPrediction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                  foregroundColor: Colors.white, // Text color
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                ),
                child: const Text(
                  'Recommend Crop',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Recommended Crop: $result',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
