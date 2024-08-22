import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/feature/ingresos/providers/qr_form_provider.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrFormState = ref.watch(qrFormProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Datos escaneados:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Número de Trámite: ${qrFormState.numeroTramite}'),
            Text('Apellido: ${qrFormState.apellido}'),
            Text('Nombre: ${qrFormState.nombre}'),
            Text('Sexo: ${qrFormState.sexo}'),
            Text('DNI: ${qrFormState.dni}'),
            Text('Ejemplar: ${qrFormState.ejemplar}'),
            Text('Fecha de Nacimiento: ${qrFormState.fechaNacimiento}'),
            Text('Fecha de Emisión: ${qrFormState.fechaEmision}'),
          ],
        ),
      ),
    );
  }
}
