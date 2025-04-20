import 'package:belajar_flutter/networking.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final ApiServices apiServices = ApiServices();

  String title = '';
  String body = '';

  Future<void> _submitForm() async {
    if (title.isEmpty || body.isEmpty) {
      // Show alert dialog
      return;
    }

    final Map<String, dynamic> data = {
      'title': title,
      'body': body,
    };

    try {
      await apiServices.postData(data);
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil disimpan'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
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
                labelText: 'Judul',
              ),
              onChanged: (value) {
                title = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Deskripsi',
              ),
              onChanged: (value) {
                body = value;
              },
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
