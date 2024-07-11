import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormIngresos extends StatelessWidget {
  const FormIngresos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Agregar el Ingreso'),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _inputText(context, title: 'Dni'),
                const SizedBox(height: 20),
                _inputText(context, title: 'Nombre'),
                const SizedBox(height: 20),
                _inputText(context, title: 'Motivo'),
                const SizedBox(height: 20), // Added SizedBox for spacing
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(
                            context); // Navigate back to previous screen
                      },
                      child: const Text('Cerrar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle onPressed for the "Agregar" button
                      },
                      child: const Text('Agregar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputText(BuildContext context, {required String title}) {
    return FormBuilderTextField(
      name: 'text',
      decoration: InputDecoration(
        labelText: title,
        focusColor: Theme.of(context).primaryColor,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.5)),
        ),
      ),
      cursorColor: Theme.of(context).primaryColor,
      onChanged: (val) {
        print(val);
      },
    );
  }
}
