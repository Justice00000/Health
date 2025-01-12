// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final TextEditingController pregnanciesController = TextEditingController();
  final TextEditingController glucoseController = TextEditingController();
  final TextEditingController bloodPressureController = TextEditingController();
  final TextEditingController skinThicknessController = TextEditingController();
  final TextEditingController insulinController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController diabetesPedigreeController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  String prediction = "";

  Future<void> makePrediction() async {
    try {
      final response = await http.post(
        Uri.parse('https://fast-api-vv4w.onrender.com/predict/'), // Fixed trailing slash
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "pregnancies": int.tryParse(pregnanciesController.text) ?? 0,
          "glucose": double.tryParse(glucoseController.text) ?? 0.0,
          "blood_pressure": double.tryParse(bloodPressureController.text) ?? 0.0,
          "skin_thickness": double.tryParse(skinThicknessController.text) ?? 0.0,
          "insulin": double.tryParse(insulinController.text) ?? 0.0,
          "bmi": double.tryParse(bmiController.text) ?? 0.0,
          "diabetes_pedigree_function": double.tryParse(diabetesPedigreeController.text) ?? 0.0,
          "age": int.tryParse(ageController.text) ?? 0,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          prediction = jsonDecode(response.body)["prediction"];
        });
      } else {
        print("Error Status Code: ${response.statusCode}");
        print("Error Response Body: ${response.body}");
        setState(() {
          prediction = "Error: ${response.statusCode}\n${response.body}";
        });
      }
    } catch (e) {
      print("Exception occurred: $e");
      setState(() {
        prediction = "An error occurred: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensures the keyboard doesn't cause overflow
      body: SingleChildScrollView( // Makes the content scrollable
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.white], // Gradient background
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter Your Health Data',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(pregnanciesController, 'Pregnancies', Icons.pregnant_woman, TextInputType.number),
                _buildTextField(glucoseController, 'Glucose Level', Icons.bloodtype, const TextInputType.numberWithOptions(decimal: true)),
                _buildTextField(bloodPressureController, 'Blood Pressure', Icons.favorite, const TextInputType.numberWithOptions(decimal: true)),
                _buildTextField(skinThicknessController, 'Skin Thickness', Icons.accessibility_new, const TextInputType.numberWithOptions(decimal: true)),
                _buildTextField(insulinController, 'Insulin', Icons.medical_services, const TextInputType.numberWithOptions(decimal: true)),
                _buildTextField(bmiController, 'BMI', Icons.fitness_center, const TextInputType.numberWithOptions(decimal: true)),
                _buildTextField(diabetesPedigreeController, 'Diabetes Pedigree Function', Icons.show_chart, const TextInputType.numberWithOptions(decimal: true)),
                _buildTextField(ageController, 'Age', Icons.calendar_today, TextInputType.number),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: makePrediction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: const Text(
                    'Predict',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Prediction: $prediction',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: Colors.blueAccent),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pregnanciesController.dispose();
    glucoseController.dispose();
    bloodPressureController.dispose();
    skinThicknessController.dispose();
    insulinController.dispose();
    bmiController.dispose();
    diabetesPedigreeController.dispose();
    ageController.dispose();
    super.dispose();
  }
}