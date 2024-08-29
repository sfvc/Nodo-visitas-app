import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nodo_app_2/config/router/app_router.dart';
import 'package:nodo_app_2/feature/ingresos/domain/services/visits_service.dart';
import 'package:nodo_app_2/feature/ingresos/providers/form_ingreso_provider.dart';
import 'package:nodo_app_2/shared/providers/aler_toast_provider.dart';

class FormIngresos extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final dniController = TextEditingController();
  final turnoController = TextEditingController();
  final serviceIngresos = VisitService();

  FormIngresos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingresoFormState = ref.watch(ingresoFormProvider);
    final ingresosProvider = ref.read(ingresoFormProvider.notifier);
    final routerProvider = ref.read(goRouterProvider);
    final alerToast = ref.read(alertProvider.notifier);

    return Scaffold(
        appBar: AppBar(),
        body: /* ingresoFormState.persona == null
          ?  */
            FormCreateIngreso(
          formKey: _formKey,
          alerToast: alerToast,
          dniController: dniController,
          ingresosProvider: ingresosProvider,
          turnoController: turnoController,
          ingresoFormState: ingresoFormState,
          serviceIngresos: serviceIngresos,
          routerProvider: routerProvider,
        )
        // : ConfirmPersonaData(
        //     alerToast: alerToast,
        //     ingresoFormState: ingresoFormState,
        //     ingresosProvider: ingresosProvider,
        //     routerProvider: routerProvider,
        //     serviceIngresos: serviceIngresos,
        //   ),
        );
  }
}

class FormCreateIngreso extends ConsumerWidget {
  const FormCreateIngreso({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.dniController,
    required this.ingresosProvider,
    required this.turnoController,
    required this.routerProvider,
    required this.ingresoFormState,
    required this.serviceIngresos,
    required this.alerToast,
  }) : _formKey = formKey;

  final AlertNotifier alerToast;
  final GlobalKey<FormState> _formKey;
  final TextEditingController dniController;
  final IngresoNotifier ingresosProvider;
  final TextEditingController turnoController;
  final GoRouter routerProvider;
  final IngresoFormState ingresoFormState;
  final VisitService serviceIngresos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final textThemes = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    clearForm() {
      dniController.text = "";
      turnoController.text = "";
    }

    createIngresoValues() async {
      ingresosProvider.updateIsPosting(true);
      try {
        final getPeronaByDniResponse =
            await serviceIngresos.getPeronaByDni(dni: ingresoFormState.dni);

        if (getPeronaByDniResponse.statusCode == 200) {
          final personaData = getPeronaByDniResponse.data;
          final Map<String, dynamic> body = {
            'turno': ingresoFormState.turno,
            'personaId': personaData['id'],
          };

          final createTurnoResponse =
              await serviceIngresos.createNewVisit(body);
          if (createTurnoResponse.statusCode == 201) {
            alerToast.showAlert(
                message: 'Turno creado con exito',
                alertType: AlertType.success);
            clearForm();
          } else {
            alerToast.showAlert(
                message: 'ah Ocurrido un error al crear este turno',
                alertType: AlertType.error);
          }

          return createTurnoResponse;
        } else {
          routerProvider.push('/shift-person-not-found');
          alerToast.showAlert(
              message: 'DNI no encontrado', alertType: AlertType.warning);
        }
      } catch (error) {
        alerToast.showAlert(
            message: 'Ah ocurrido un error al crear el turno',
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
              controller: dniController,
              onChanged: (value) {
                ingresosProvider.updateDni(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el DNI';
                }
                if (value.length < 8) {
                  return 'Por favor ingrese valido';
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

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                  child: Column(
                children: [
                  _TurnoSelection(),
                  const SizedBox(height: 10),
                  ingresoFormState.turno == -1
                      ? Text(
                          'Seleccione un turno valido*',
                          style: TextStyle(
                              color: colors.primary,
                              fontWeight: FontWeight.bold),
                        )
                      : const SizedBox(),
                ],
              )),
            ),

            const SizedBox(height: 20),
            ingresoFormState.isPosting
                ? const LinearProgressIndicator()
                : FilledButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        createIngresoValues();
                      }
                    },
                    label: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Agregar',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            // OutlinedButton(
            //   onPressed: () {
            //     ref.read(goRouterProvider).pop('/');
            //   },
            //   child: const Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: Text(
            //       'Cerrar',
            //       style: TextStyle(fontSize: 20),
            //     ),
            //   ),
            // ),
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
    int selectedTurno = ref.watch(ingresoFormProvider).turno;

    setState(() {
      for (int i = 0; i < _selections.length; i++) {
        _selections[i] = i == index;
      }
      selectedTurno = index;
    });
    ref.read(ingresoFormProvider.notifier).updateTurno(selectedTurno);
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

// class ConfirmPersonaData extends StatelessWidget {
//   const ConfirmPersonaData({
//     super.key,
//     required this.alerToast,
//     required this.ingresoFormState,
//     required this.ingresosProvider,
//     required this.routerProvider,
//     required this.serviceIngresos,
//   });

//   final AlertNotifier alerToast;
//   final IngresoFormState ingresoFormState;
//   final IngresoNotifier ingresosProvider;
//   final GoRouter routerProvider;
//   final VisitService serviceIngresos;

//   @override
//   Widget build(BuildContext context) {
//     Future createTruno() async {
//       ingresosProvider.updateIsPosting(true);
//       try {
//         final body = {
//           'tiempo': ingresoFormState.turno,
//           'motivo': ingresoFormState.motivo,
//           'personaId': ingresoFormState.persona?.id,
//         };
//         final response = await serviceIngresos.createNewVisit(body);
//         if (response.statusCode == 201) {
//           alerToast.showAlert(
//               alertType: AlertType.success, message: 'Turno creado');
//           ingresosProvider.reset();
//           routerProvider.replace('/');
//         } else {
//           alerToast.showAlert(
//               alertType: AlertType.error, message: 'no se pudo crear turno');
//         }
//       } catch (e) {
//         alerToast.showAlert(
//             alertType: AlertType.error, message: 'Error al crear turno');
//       }
//       ingresosProvider.updateIsPosting(false);
//     }

//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: ListView(
//         children: [
//           const Text(
//             'Confirmar Turno',
//             style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Text(
//               'Nombre: ${ingresoFormState.persona?.apellido} ${ingresoFormState.persona?.nombre}',
//               style: const TextStyle(fontSize: 18)),
//           Text('DNI: ${ingresoFormState.persona?.dni}',
//               style: const TextStyle(fontSize: 18)),
//           Text('Funcion: ${ingresoFormState.persona?.funcion}',
//               style: const TextStyle(fontSize: 18)),
//           const Divider(
//             color: Colors.black,
//           ),
//           Text('Turno:  ${ingresoFormState.turno}',
//               style: const TextStyle(fontSize: 18)),
//           Text('Motivo:  ${ingresoFormState.motivo}',
//               style: const TextStyle(fontSize: 18)),
//           const Divider(
//             color: Colors.black,
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           OutlinedButton(
//             onPressed: () {
//               ingresosProvider.reset();
//               routerProvider.replace('/');
//             },
//             child: const Text('Cancelar'),
//           ),
//           ingresoFormState.isPosting
//               ? const LinearProgressIndicator(
//                   minHeight: 20,
//                 )
//               : FilledButton.icon(
//                   icon: const Icon(Icons.add),
//                   label: const Text('Confirmar turno'),
//                   onPressed: () async {
//                     createTruno();
//                   },
//                 ),
//         ],
//       ),
//     );
//   }
// }
