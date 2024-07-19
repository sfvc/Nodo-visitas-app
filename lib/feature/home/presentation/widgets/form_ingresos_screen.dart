import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nodo_app_2/config/router/app_router.dart';
import 'package:nodo_app_2/feature/home/domain/person_entity.dart';
import 'package:nodo_app_2/feature/home/infraestructure/services/visits_service.dart';
import 'package:nodo_app_2/feature/home/providers/form_ingreso_provider.dart';
import 'package:nodo_app_2/shared/providers/aler_toast_provider.dart';

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
    final alerToast = ref.read(alertProvider.notifier);

    return Scaffold(
        appBar: AppBar(),
        body: ingresoFormState.persona == null
            ? FormCreateIngreso(
                formKey: _formKey,
                alerToast: alerToast,
                dniController: dniController,
                ingresosProvider: ingresosProvider,
                turnoController: turnoController,
                motivoController: motivoController,
                ingresoFormState: ingresoFormState,
                serviceIngresos: serviceIngresos)
            : ConfirmPersonaData(
                alerToast: alerToast,
                ingresoFormState: ingresoFormState,
                ingresosProvider: ingresosProvider,
                routerProvider: routerProvider,
                serviceIngresos: serviceIngresos));
  }
}

class ConfirmPersonaData extends StatelessWidget {
  const ConfirmPersonaData({
    super.key,
    required this.alerToast,
    required this.ingresoFormState,
    required this.ingresosProvider,
    required this.routerProvider,
    required this.serviceIngresos,
  });

  final AlertNotifier alerToast;
  final IngresoFormState ingresoFormState;
  final IngresoNotifier ingresosProvider;
  final GoRouter routerProvider;
  final VisitService serviceIngresos;

  @override
  Widget build(BuildContext context) {
    Future createTruno() async {
      ingresosProvider.updateIsPosting(true);
      try {
        final body = {
          'tiempo': ingresoFormState.turno,
          'motivo': ingresoFormState.motivo,
          'personaId': ingresoFormState.persona?.id,
        };
        final response = await serviceIngresos.createNewVisit(body);
        if (response.statusCode == 201) {
          alerToast.showAlert(
              alertType: AlertType.success, message: 'Turno creado');
          ingresosProvider.reset();
          routerProvider.replace('/');
        } else {
          alerToast.showAlert(
              alertType: AlertType.error, message: 'no se pudo crear turno');
        }
      } catch (e) {
        alerToast.showAlert(
            alertType: AlertType.error, message: 'Error al crear turno');
      }
      ingresosProvider.updateIsPosting(false);
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
              routerProvider.replace('/');
            },
            child: const Text('Cancelar'),
          ),
          ingresoFormState.isPosting
              ? const LinearProgressIndicator(
                  minHeight: 20,
                )
              : FilledButton.icon(
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
    required this.alerToast,
  }) : _formKey = formKey;

  final AlertNotifier alerToast;
  final GlobalKey<FormState> _formKey;
  final TextEditingController dniController;
  final IngresoNotifier ingresosProvider;
  final TextEditingController turnoController;
  final TextEditingController motivoController;
  final IngresoFormState ingresoFormState;
  final VisitService serviceIngresos;

  @override
  Widget build(BuildContext context) {
    createIngresoValues() async {
      ingresosProvider.updateIsPosting(true);
      try {
        if (ingresoFormState.dni.length < 7) {
          alerToast.showAlert(
              message: 'Ingrese un documento valido',
              alertType: AlertType.warning);
        }
        if (ingresoFormState.turno.isEmpty) {
          alerToast.showAlert(
              message: 'Ingrese un turno', alertType: AlertType.warning);
          return;
        }
        if (ingresoFormState.dni.length > 7) {
          final response =
              await serviceIngresos.getPeronaByDni(dni: ingresoFormState.dni);
          if (response.statusCode == 200) {
            final personaData = Persona.fromJson(response.data);
            ingresosProvider.updatePersona(personaData);
          } else {
            alerToast.showAlert(
                message: 'No se encontro persona con este DNI',
                alertType: AlertType.warning);
          }
          return response;
        }
      } catch (error) {
        alerToast.showAlert(
            message: 'Ah ocurrido un error al buscar documento',
            alertType: AlertType.error);
        throw Exception(error);
      } finally {
        ingresosProvider.updateIsPosting(false);
      }
    }

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
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(child: _TurnoSelection()),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to previous screen
              },
              child: const Text('Cerrar'),
            ),
            ingresoFormState.isPosting
                ? const LinearProgressIndicator()
                : FilledButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();

                        createIngresoValues();
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

class _TurnoSelection extends ConsumerStatefulWidget {
  @override
  _TurnoSelectionState createState() => _TurnoSelectionState();
}

class _TurnoSelectionState extends ConsumerState<_TurnoSelection> {
  final List<bool> _selections = List.generate(3, (_) => false);
  final List<String> _turnos = ['mañana', 'tarde', 'noche'];

  void _updateSelection(int index) {
    String selectedTurno = ref.watch(ingresoFormProvider).turno;

    setState(() {
      for (int i = 0; i < _selections.length; i++) {
        _selections[i] = i == index;
      }
      selectedTurno = _turnos[index];
    });
    // Aquí puedes llamar a tu proveedor para actualizar el estado
    ref.read(ingresoFormProvider.notifier).updateTurno(selectedTurno);
    // ingresosProvider.updateTurno(_selectedTurno);
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: _selections,
      onPressed: _updateSelection,
      children: _turnos
          .map((turno) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(turno),
              ))
          .toList(),
    );
  }
}
