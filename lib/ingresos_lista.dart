import 'package:flutter/material.dart';
import 'package:nodo_app_2/api_client.dart'; // Import your ApiClient class

class IngresosLista extends StatefulWidget {
  @override
  _IngresosListaState createState() => _IngresosListaState();
}

class _IngresosListaState extends State<IngresosLista> {
  final ApiClient _apiClient = ApiClient();
  List<String> ingresos = []; // List to hold fetched ingresos data

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<String> fetchedIngresos = await _apiClient.fetchIngresos();
    setState(() {
      ingresos = fetchedIngresos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ingresos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(ingresos[index]),
          trailing: const Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () {
            // Handle tap if needed
          },
        );
      },
    );
  }
}
