import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/feature/ingresos/providers/qr_form_provider.dart';

class NewTurnoForm extends ConsumerWidget {
  final dniController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  NewTurnoForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrFormState = ref.watch(qrFormProvider);
    final textStyles = Theme.of(context).textTheme;
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
              controller: dniController,
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
              controller: dniController,
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
              controller: dniController,
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
            const SizedBox(height: 30),
            /* ingresoFormState.isPosting */ false
                ? const LinearProgressIndicator()
                : FilledButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        // createIngresoValues();
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
          ]),
        ),
      ),
    );
  }
}
