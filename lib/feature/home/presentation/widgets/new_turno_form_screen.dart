import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/config/router/app_router.dart';
import 'package:nodo_app_2/feature/home/providers/state.provider.dart';
import 'package:nodo_app_2/feature/ingresos/domain/services/visits_service.dart';

import 'package:nodo_app_2/feature/ingresos/providers/form_ingreso_provider.dart';
import 'package:nodo_app_2/feature/ingresos/widgets/selector_turno.dart';
import 'package:nodo_app_2/shared/providers/aler_toast_provider.dart';

class NewTurnoForm extends ConsumerWidget {
  final dniController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final motivoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final serviceIngresos = VisitService();

  NewTurnoForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final qrFormState = ref.watch(qrFormProvider);
    final ingresosProvider = ref.read(ingresoFormProvider.notifier);
    final ingresoFormState = ref.watch(ingresoFormProvider);
    final textStyles = Theme.of(context).textTheme;
    final alerToast = ref.read(alertProvider.notifier);
    final routerProvider = ref.read(goRouterProvider);
    final navigationIndex = ref.read(bottomNavigationIndexProvider.notifier);
    final colors = Theme.of(context).colorScheme;

    clearForm() {
      dniController.text = "";
      nombreController.text = "";
      motivoController.text = "";
      apellidoController.text = "";
      navigationIndex.update((state) => 0);
      routerProvider.go('/');
    }

    createNewIngresoValues() async {
      ingresosProvider.updateIsPosting(true);
      try {
        final Map<String, dynamic> body = {
          'turno': ingresoFormState.turno,
          'nombre': nombreController.text,
          'apellido': apellidoController.text,
          'dni': dniController.text,
          'motivo': motivoController.text,
        };

        final createTurnoResponse = await serviceIngresos.createNewVisit(body);
        if (createTurnoResponse.statusCode == 201) {
          alerToast.showAlert(
              message: 'Turno creado con exito', alertType: AlertType.success);
          clearForm();
        } else {
          alerToast.showAlert(
              message: 'ah Ocurrido un error al crear este turno',
              alertType: AlertType.error);
        }
        return createTurnoResponse;
      } catch (error) {
        alerToast.showAlert(
            message: 'Ah ocurrido un error al crear el turno',
            alertType: AlertType.error);
        throw Exception(error);
      } finally {
        ingresosProvider.updateIsPosting(false);
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Registrar nueva persona',
                style: textStyles.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Es posible que esta persona no este registrada como trabajador, puedes crear manualmente la visita si es necesario',
                style: textStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: dniController,
              onChanged: (value) {},
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
            const SizedBox(height: 20),
            TextFormField(
              controller: nombreController,
              onChanged: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 3) {
                  return 'Por favor ingrese un nombre valido';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nombre',
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
            const SizedBox(height: 20),
            TextFormField(
              controller: apellidoController,
              onChanged: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 3) {
                  return 'Por favor ingrese un apellido valido';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Apellido',
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
            const SizedBox(height: 20),
            TextFormField(
              controller: motivoController,
              onChanged: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 3) {
                  return 'Por favor ingrese un apellido valido';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Motivo de la visita',
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
              child: Center(
                  child: Column(
                children: [
                  TurnoSelection(),
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
            const SizedBox(height: 30),
            ingresoFormState.isPosting
                ? const LinearProgressIndicator()
                : FilledButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: ingresoFormState.turno == -1
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();
                              createNewIngresoValues();
                            }
                          },
                    label: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Registrar Ingreso',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                ingresosProvider.reset();
                routerProvider.go('/');
                // routerProvider.replace('/');
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Cancelar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
