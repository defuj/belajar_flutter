import 'package:belajar_flutter/networking.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  final int id;
  final String title;
  final String body;
  const UpdatePage({
    super.key,
    required this.id,
    required this.title,
    required this.body,
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final ApiServices apiServices = ApiServices();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  var id = 0;

  Future<void> _submitForm() async {
    if (titleController.text.isEmpty || bodyController.text.isEmpty) {
      // Show alert dialog
      return;
    }

    final Map<String, dynamic> data = {
      'title': titleController.text,
      'body': bodyController.text,
    };

    try {
      await apiServices.putData(id, data);
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil diupdate'),
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
  void initState() {
    super.initState();
    titleController.text = widget.title;
    bodyController.text = widget.body;
    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Judul',
              ),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
              ),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
