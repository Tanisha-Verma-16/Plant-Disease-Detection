import 'package:flutter/material.dart';

class CropInputUI extends StatefulWidget {
  final Function(Map<String, double>) onPredict;

  const CropInputUI({required this.onPredict});

  @override
  _CropInputUIState createState() => _CropInputUIState();
}

class _CropInputUIState extends State<CropInputUI> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, double> _inputValues = {
    'N': 0.0,
    'P': 0.0,
    'K': 0.0,
    'temperature': 0.0,
    'humidity': 0.0,
    'ph': 0.0,
    'rainfall': 0.0,
  };

  Widget _buildTextField(String label, String hint, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        keyboardType: TextInputType.number,
        onSaved: (value) {
          _inputValues[key] = double.tryParse(value!) ?? 0.0;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField('Nitrogen (N)', 'Enter N ratio', 'N'),
            _buildTextField('Phosphorous (P)', 'Enter P ratio', 'P'),
            _buildTextField('Potassium (K)', 'Enter K ratio', 'K'),
            _buildTextField(
                'Temperature', 'Enter temperature (°C)', 'temperature'),
            _buildTextField('Humidity', 'Enter humidity (%)', 'humidity'),
            _buildTextField('pH', 'Enter soil pH', 'ph'),
            _buildTextField('Rainfall', 'Enter rainfall (mm)', 'rainfall'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onPredict(_inputValues);
                }
              },
              child: Text('Crop Recommendation'),
            ),
          ],
        ),
      ),
    );
  }
}
