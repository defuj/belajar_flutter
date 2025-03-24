import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late SharedPreferences prefs;

  String name = '';
  String email = '';

  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveForm() async {
    if (name.isEmpty || email.isEmpty) {
      // Show alert dialog
      return;
    }
    // save to shared preferences
    await prefs.setString('name', name);
    await prefs.setString('email', email);

    _submitForm();
  }

  Future<void> _submitForm() async {
    Navigator.pushNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (value) {
                name = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) {
                email = value;
              },
            ),
            ElevatedButton(
              onPressed: _saveForm,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
