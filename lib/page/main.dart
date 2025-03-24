import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Variabel yang digunakan untuk menampung judul
  final String _title = 'Flutter Demo';
  int _counter = 0;
  // Tuliskan kode atau fungsi lainnya di sini

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // Kode yang dijalankan saat aplikasi pertama kali dijalankan
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Center(
        child: Text(
          _counter.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Kode yang dijalankan saat tombol ditekan
          _incrementCounter();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
