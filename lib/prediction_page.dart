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
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController polyuriaController = TextEditingController();
  final TextEditingController polydipsiaController = TextEditingController();
  final TextEditingController suddenWeightLossController = TextEditingController();
  final TextEditingController weaknessController = TextEditingController();
  final TextEditingController polyphagiaController = TextEditingController();
  final TextEditingController genitalThrushController = TextEditingController();
  final TextEditingController visualBlurringController = TextEditingController();
  final TextEditingController itchingController = TextEditingController();
  final TextEditingController irritabilityController = TextEditingController();
  final TextEditingController delayedHealingController = TextEditingController();
  final TextEditingController partialParesisController = TextEditingController();
  final TextEditingController muscleStiffnessController = TextEditingController();
  final TextEditingController alopeciaController = TextEditingController();
  final TextEditingController obesityController = TextEditingController();

  String prediction = "";

Future<void> makePrediction() async {
  try {
    final response = await http.post(
      Uri.parse('https://diabetics-api.onrender.com/predict/'), // Updated endpoint
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "age": int.tryParse(ageController.text) ?? 0,
        "gender": genderController.text,
        "polyuria": polyuriaController.text,
        "polydipsia": polydipsiaController.text,
        "sudden_weight_loss": suddenWeightLossController.text,
        "weakness": weaknessController.text,
        "polyphagia": polyphagiaController.text,
        "genital_thrush": genitalThrushController.text,
        "visual_blurring": visualBlurringController.text,
        "itching": itchingController.text,
        "irritability": irritabilityController.text,
        "delayed_healing": delayedHealingController.text,
        "partial_paresis": partialParesisController.text,
        "muscle_stiffness": muscleStiffnessController.text,
        "alopecia": alopeciaController.text,
        "obesity": obesityController.text,
        "outcome": 0 // You can adjust this value based on your logic or the user input
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
                _buildTextField(ageController, 'Age', Icons.calendar_today, TextInputType.number),
                _buildTextField(genderController, 'Gender', Icons.person, TextInputType.text),
                _buildTextField(polyuriaController, 'Polyuria', Icons.local_hospital, TextInputType.text),
                _buildTextField(polydipsiaController, 'Polydipsia', Icons.local_hospital, TextInputType.text),
                _buildTextField(suddenWeightLossController, 'Sudden Weight Loss', Icons.accessibility_new, TextInputType.text),
                _buildTextField(weaknessController, 'Weakness', Icons.access_alarm, TextInputType.text),
                _buildTextField(polyphagiaController, 'Polyphagia', Icons.restaurant, TextInputType.text),
                _buildTextField(genitalThrushController, 'Genital Thrush', Icons.local_pharmacy, TextInputType.text),
                _buildTextField(visualBlurringController, 'Visual Blurring', Icons.remove_red_eye, TextInputType.text),
                _buildTextField(itchingController, 'Itching', Icons.touch_app, TextInputType.text),
                _buildTextField(irritabilityController, 'Irritability', Icons.sentiment_very_dissatisfied, TextInputType.text),
                _buildTextField(delayedHealingController, 'Delayed Healing', Icons.accessibility, TextInputType.text),
                _buildTextField(partialParesisController, 'Partial Paresis', Icons.accessibility_new, TextInputType.text),
                _buildTextField(muscleStiffnessController, 'Muscle Stiffness', Icons.access_alarm, TextInputType.text),
                _buildTextField(alopeciaController, 'Alopecia', Icons.content_cut, TextInputType.text),
                _buildTextField(obesityController, 'Obesity', Icons.fitness_center, TextInputType.text),
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
    ageController.dispose();
    genderController.dispose();
    polyuriaController.dispose();
    polydipsiaController.dispose();
    suddenWeightLossController.dispose();
    weaknessController.dispose();
    polyphagiaController.dispose();
    genitalThrushController.dispose();
    visualBlurringController.dispose();
    itchingController.dispose();
    irritabilityController.dispose();
    delayedHealingController.dispose();
    partialParesisController.dispose();
    muscleStiffnessController.dispose();
    alopeciaController.dispose();
    obesityController.dispose();
    super.dispose();
  }
}