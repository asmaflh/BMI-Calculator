import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // the controller for the text field associated with "height"
  final _heightController = TextEditingController();

  // the controller for the text field associated with "weight"
  final _weightController = TextEditingController();

  double? _bmi;
  // the message at the beginning
  String _message = 'Please enter your height an weight';
  String image="";

  // This function is triggered when the user pressess the "Calculate" button
  void _calculate() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);


    setState(() {
      double? heightm=height!/100;
      _bmi = (weight! / (heightm * heightm))!;
      if (_bmi! < 18.5) {
        _message = "You are underweight";
         image="assets/images/underw.jpg";
      } else if (_bmi! < 25) {
        _message = 'You body is fine';
        image="assets/images/normal.jpg";
      } else if (_bmi! < 30) {
        _message = 'You are overweight';
        image='assets/images/overw.jpg';
      } else {
        _message = 'You are obese';
        image='assets/images/obesse.jpg';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SizedBox(
            width: 320,
            child: Card(
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      decoration:
                      const InputDecoration(labelText: 'Height (cm)'),
                      controller: _heightController,
                    ),
                    TextField(
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                      ),
                      controller: _weightController,
                    ),
                    ElevatedButton(
                      onPressed: _calculate,
                      child: const Text('Calculate'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      _bmi == null ? 'No Result' : _bmi!.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 50),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      _message,
                      textAlign: TextAlign.center,
                    ),
              Image.asset(
                image,
                height: 400,
                width: 400,)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}