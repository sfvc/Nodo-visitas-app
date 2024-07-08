import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Row(children: [
          Text(
            '¡Hola Nodo',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 25,
            ),
          ),
        ]),
        actions: [
          IconButton(
              onPressed: () {
                // ref.read(goRouterProvider).push('/notifications');
              },
              icon: const Icon(Icons.notifications))
        ],
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
      
    );
  }
}
