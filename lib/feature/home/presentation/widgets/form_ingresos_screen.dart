import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nodo_app_2/config/router/app_router.dart';
import 'package:nodo_app_2/feature/home/domain/person_entity.dart';
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
    // ref.read(goRouterProvider).push('/notifications');
    final routerProvider = ref.read(goRouterProvider);

    // _createNewIngreso() {
    //   final Map<String, dynamic> ingresoData = {
    //     // "tiempo": ingresoFormState.turno,
    //     "motivo":
    //         ingresoFormState.motivo, /* "personaId":ingresoFormState.turno */
    //   };

    //   try {
    //     final response = serviceIngresos.createNewVisit(ingresoData);
    //   } catch (e) {}
    // }

    // Future getPersonaByDni() async {
    //   try {
    //     if (ingresoFormState.dni.length > 7) {
    //       final response =
    //           await serviceIngresos.getPeronaByDni(ingresoFormState.dni);
    //       return response;
    //     }
    //   } catch (error) {
    //     throw Exception(error);
    //   }
    // }

    return Scaffold(
        appBar: AppBar(),
        body: ingresoFormState.persona == null
            ? FormCreateIngreso(
                formKey: _formKey,
                dniController: dniController,
                ingresosProvider: ingresosProvider,
                turnoController: turnoController,
                motivoController: motivoController,
                ingresoFormState: ingresoFormState,
                serviceIngresos: serviceIngresos)
            : ConfirmPersonaData(
                ingresoFormState: ingresoFormState,
                ingresosProvider: ingresosProvider,
                routerProvider: routerProvider,
                serviceIngresos: serviceIngresos));
  }
}

class ConfirmPersonaData extends StatelessWidget {
  const ConfirmPersonaData({
    super.key,
    required this.ingresoFormState,
    required this.ingresosProvider,
    required this.routerProvider,
    required this.serviceIngresos,
  });

  final IngresoFormState ingresoFormState;
  final IngresoNotifier ingresosProvider;
  final GoRouter routerProvider;
  final VisitService serviceIngresos;

  @override
  Widget build(BuildContext context) {
    Future createTruno() async {
      try {
        final body = {
          'tiempo': ingresoFormState.turno,
          'motivo': ingresoFormState.motivo,
          'personaId': ingresoFormState.persona?.id,
        };
        final response = await serviceIngresos.createNewVisit(body);

        if (response.statusCode == 200) {
          // Manejar el éxito
          print('Turno creado exitosamente');
        } else {
          // Manejar el error
          print('Error al crear el turno: ${response.statusCode}');
        }
      } catch (e) {
        // Manejar el error si es necesario
        print('Excepción al crear el turno: $e');
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Text(
            'Confirmar Turno',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
              'Nombre: ${ingresoFormState.persona?.apellido} ${ingresoFormState.persona?.nombre}',
              style: const TextStyle(fontSize: 18)),
          Text('DNI: ${ingresoFormState.persona?.dni}',
              style: const TextStyle(fontSize: 18)),
          Text('Funcion: ${ingresoFormState.persona?.funcion}',
              style: const TextStyle(fontSize: 18)),
          const Divider(
            color: Colors.black,
          ),
          Text('Turno:  ${ingresoFormState.turno}',
              style: const TextStyle(fontSize: 18)),
          Text('Motivo:  ${ingresoFormState.motivo}',
              style: const TextStyle(fontSize: 18)),
          const Divider(
            color: Colors.black,
          ),
          const SizedBox(
            height: 15,
          ),
          OutlinedButton(
            onPressed: () {
              ingresosProvider.reset();
              routerProvider.push('/');
            },
            child: const Text('Cancelar'),
          ),
          FilledButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Confirmar turno'),
            onPressed: () async {
              createTruno();
            },
          ),
        ],
      ),
    );
  }
}

class FormCreateIngreso extends StatelessWidget {
  const FormCreateIngreso({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.dniController,
    required this.ingresosProvider,
    required this.turnoController,
    required this.motivoController,
    required this.ingresoFormState,
    required this.serviceIngresos,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController dniController;
  final IngresoNotifier ingresosProvider;
  final TextEditingController turnoController;
  final TextEditingController motivoController;
  final IngresoFormState ingresoFormState;
  final VisitService serviceIngresos;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              onSaved: (value) {
                ingresosProvider.updateTurno(value as String);
              },
              onChanged: (value) {
                ingresosProvider.updateTurno(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el turno';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'turno',
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
              onSaved: (value) {
                ingresosProvider.updateMotivo(value as String);
              },
              onChanged: (value) {
                ingresosProvider.updateMotivo(value);
              },
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

                  try {
                    if (ingresoFormState.dni.length > 7) {
                      final response = await serviceIngresos
                          .getPeronaByDni(ingresoFormState.dni);
                      if (response.statusCode == 200) {
                        final personaData = Persona.fromJson(response.data);
                        ingresosProvider.updatePersona(personaData);
                      }
                      return response;
                    }
                  } catch (error) {
                    throw Exception(error);
                  }
                  // Aquí puedes agregar la lógica para guardar los datos
                }
              },
              label: const Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }
}
