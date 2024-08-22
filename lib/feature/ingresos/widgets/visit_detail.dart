import 'package:flutter/material.dart';

class VisitDetail extends StatelessWidget {
  final String visitId;

  const VisitDetail({super.key, required this.visitId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Row(children: [
          Text(
            'Detalle del ingreso',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 25,
            ),
          ),
        ]),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pagina en construccion',
              style: TextStyle(fontSize: 20),
            ),
            Text('Detalle de la visita id: $visitId'),
          ],
        ),
      ),
    );
  }
}
