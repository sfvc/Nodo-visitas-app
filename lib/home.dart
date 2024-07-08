import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nodo_app_2/form_ingresos.dart';
import 'package:nodo_app_2/personal_lista.dart';
import 'package:nodo_app_2/ingresos_lista.dart';
import 'package:nodo_app_2/api_client.dart'; // Import your ApiClient class

void main() {
  runApp(const MaterialApp(
    home: Home(title: 'Home Page'),
  ));
}

class Home extends StatefulWidget {
  final String title;

  const Home({Key? key, required this.title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showPersonalLista = false; // State variable to toggle between lists

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget;

    if (showPersonalLista) {
      // Render PersonalLista
      bodyWidget = PersonalLista();
    } else {
      // Render IngresosLista
      bodyWidget = IngresosLista();
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(color: Colors.blue),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () {
                      setState(() {
                        showPersonalLista = true; // Show PersonalLista
                      });
                    },
                  ),
                  const Text('Personal'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.view_list),
                    onPressed: () {
                      setState(() {
                        showPersonalLista = false; // Show IngresosLista
                      });
                    },
                  ),
                  const Text('Ingresos'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: bodyWidget, // Display the appropriate list based on state
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMaterialModalBottomSheet(
            context: context,
            builder: (context) => const FormIngresos(),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Define a custom search delegate
class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for app bar
    return [
      Row(
        children: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              query = '';
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              // Perform action when calendar icon is tapped
              // Example action: Open a calendar picker
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              ).then((selectedDate) {
                if (selectedDate != null) {
                  // Handle selected date
                  close(context, selectedDate.toString());
                }
              });
            },
          ),
        ],
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the app bar
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show results based on the search query
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types
    final List<String> suggestions = ['Result 1', 'Result 2', 'Result 3']; // Replace with your actual suggestions
    final List<String> filteredSuggestions = query.isEmpty
        ? suggestions
        : suggestions.where((suggestion) => suggestion.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredSuggestions[index]),
          onTap: () {
            // Perform action when a suggestion is tapped
            close(context, filteredSuggestions[index]);
          },
        );
      },
    );
  }
}
