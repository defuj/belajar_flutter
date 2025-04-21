import 'package:belajar_flutter/networking.dart';
import 'package:belajar_flutter/page/update.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late SharedPreferences prefs;
  final TextEditingController searchController = TextEditingController();
  final ApiServices apiServices = ApiServices();
  List<dynamic> items = [];

  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> seachData() async {
    if (searchController.text.isNotEmpty) {
      await apiServices.getList().then((value) {
        setState(() {
          items = value;
        });
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $error'),
            duration: const Duration(seconds: 2),
          ),
        );
      });
    } else {
      setState(() {
        items = [];
      });
    }
  }

  Future<void> _deleteData(int id) async {
    await apiServices.deleteData(id).then((_) {
      Navigator.pop(context);
      setState(() {
        items.removeWhere((item) => item['id'] == id);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil dihapus'),
          duration: Duration(seconds: 2),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    seachData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: "What are you looking for?",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    seachData();
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var data = items[index];
                  return ListTile(
                    onTap: () {
                      // Show dialog to confirm deletion or update
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Choose an action'),
                            content: const Text(
                                'Do you want to update or delete this item?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  prefs.setString('data', data.toString());
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdatePage(
                                        id: data['id'],
                                        title: data['title'],
                                        body: data['body'],
                                      ),
                                      settings: RouteSettings(
                                        arguments: {
                                          'id': data['id'],
                                          'title': data['title'],
                                          'body': data['body'],
                                        },
                                        name: '/update',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Update'),
                              ),
                              TextButton(
                                onPressed: () {
                                  _deleteData(data['id']);
                                },
                                child: const Text('Delete'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150',
                      ),
                    ),
                    title: Text(
                      data['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(data['body']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
