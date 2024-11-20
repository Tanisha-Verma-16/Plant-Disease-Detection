import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class CropPredictionModel {
  late tfl.Interpreter interpreter;
  late List<double> mean;
  late List<double> std;
  late List<String> cropLabels;
  bool _isModelLoaded = false;

  Future<void> loadModel() async {
    interpreter = await tfl.Interpreter.fromAsset('lib/assets/model.tflite');
    await loadScaler();
    await loadLabels();
    _isModelLoaded = true;
  }

  Future<void> loadScaler() async {
    // Load scaler mean and std from a JSON file or directly define it here
    String scalerJson = await rootBundle.loadString('lib/assets/scaler.json');
    var scaler = json.decode(scalerJson);
    mean = List<double>.from(scaler['mean'].map((item) => item.toDouble()));
    std = List<double>.from(scaler['std'].map((item) => item.toDouble()));
  }

  Future<void> loadLabels() async {
    // Load label encoder classes from a JSON file
    String labelsJson =
        await rootBundle.loadString('lib/assets/label_encoder.json');
    cropLabels = List<String>.from(json.decode(labelsJson));
  }

  Future<String> predictCrop(
    double n,
    double p,
    double k,
    double temperature,
    double humidity,
    double ph,
    double rainfall,
  ) async {
    if (!_isModelLoaded) {
      throw Exception('Model not loaded');
    }

    // Prepare the input data and normalize
    var input = [
      (n - mean[0]) / std[0],
      (p - mean[1]) / std[1],
      (k - mean[2]) / std[2],
      (temperature - mean[3]) / std[3],
      (humidity - mean[4]) / std[4],
      (ph - mean[5]) / std[5],
      (rainfall - mean[6]) / std[6]
    ];

    // Ensure the input array has the correct shape [1, 7]
    var inputArray = [input];
    var outputArray = List<double>.filled(cropLabels.length, 0.0);

    // Run the inference
    interpreter.run(inputArray, [outputArray]);

    // Get the index of the class with the highest probability
    double maxVal = outputArray.reduce((a, b) => a > b ? a : b);
    int predictedClassIndex = outputArray.indexOf(maxVal);

    // Return the corresponding crop label
    print(cropLabels[predictedClassIndex]);
    return cropLabels[predictedClassIndex];
  }

  Future<void> dispose() async {
    if (_isModelLoaded) {
      interpreter.close();
    }
  }
}
