import 'package:flutter/material.dart';
import 'package:nodo_app_2/api_client.dart'; // Import your ApiClient class

class PersonalLista extends StatefulWidget {
  @override
  _PersonalListaState createState() => _PersonalListaState();
}

class _PersonalListaState extends State<PersonalLista> {
  final ApiClient _apiClient = ApiClient();
  List<Map<String, dynamic>> personas = []; // List to hold fetched persona data

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Map<String, dynamic>> fetchedPersonas = await _apiClient.fetchPersonas();
    setState(() {
      personas = fetchedPersonas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: personas.length,
      itemBuilder: (context, index) {
        // Extracting persona details from the map
        String name = personas[index]['name'];
        String role = personas[index]['role'];

        return ListTile(
          title: Text(name),
          subtitle: Text(role),
          trailing: const Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () {
            // Handle tap if needed
          },
        );
      },
    );
  }
}
