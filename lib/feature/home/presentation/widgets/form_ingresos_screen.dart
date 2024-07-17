import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/feature/home/infraestructure/services/visits_service.dart';
import 'package:nodo_app_2/feature/home/providers/form_ingreso_provider.dart';

class FormIngresos extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final dniController = TextEditingController();
  final turnoController = TextEditingController();
  final motivoController = TextEditingController();
  final serviceIngresos = VisitService();

  FormIngresos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingresoFormState = ref.watch(ingresoFormProvider);
    final ingresosProvider = ref.read(ingresoFormProvider.notifier);

    _createNewIngreso() {
      final Map<String, dynamic> ingresoData = {
        // "tiempo": ingresoFormState.turno,
        "motivo":
            ingresoFormState.motivo, /* "personaId":ingresoFormState.turno */
      };

      try {
        final response = serviceIngresos.createNewVisit(ingresoData);
      } catch (e) {}
    }

    Future getPersonaByDni() async {
      try {
        if (ingresoFormState.dni.length > 7) {
          final response =
              await serviceIngresos.getPeronaByDni(ingresoFormState.dni);
        }
      } catch (error) {
        throw Exception(error);
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                'Crear ingreso',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                // initialValue:
                //     ingresoFormState.dni.isEmpty ? null : ingresoFormState.dni,
                controller: dniController,
                onChanged: (value) {
                  ingresosProvider.updateDni(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el DNI';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'DNI',
                  focusColor: Theme.of(context).primaryColor,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: turnoController,
                // initialValue: ingresoFormState.nombre.isEmpty
                //     ? null
                //     : ingresoFormState.nombre,
                onChanged: (value) {
                  ingresosProvider.updateTurno(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Turno',
                  focusColor: Theme.of(context).primaryColor,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: motivoController,
                onSaved: (value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el motivo';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Motivo',
                  focusColor: Theme.of(context).primaryColor,
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to previous screen
                },
                child: const Text('Cerrar'),
              ),
              FilledButton.icon(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    // Aquí puedes agregar la lógica para guardar los datos
                  }
                },
                label: const Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget _inputText(BuildContext context,
//     {required String title, required TextEditingController textController}) {
//   return TextFormField(
//     controller: textController,
//     validator: (value) {
//       if (value!.isEmpty) return "Campo requerido";
//       return null;
//     },
//     onSaved: (value) {
//       // ref.read(registerFormProvider.notifier).onNameChange;
//     },
//     keyboardType: TextInputType.text,
//     decoration: InputDecoration(
//       labelText: title,
//       focusColor: Theme.of(context).primaryColor,
//       focusedBorder: const UnderlineInputBorder(
//         borderSide: BorderSide(color: Colors.blue),
//       ),
//       enabledBorder: UnderlineInputBorder(
//         borderSide:
//             BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.5)),
//       ),
//     ),
//     cursorColor: Theme.of(context).primaryColor,
//     onChanged: (val) {
//       print(val);
//     },
//   );
// }
