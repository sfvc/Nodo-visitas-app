import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/feature/ingresos/providers/form_ingreso_provider.dart';

class TurnoSelection extends ConsumerStatefulWidget {
  @override
  _TurnoSelectionState createState() => _TurnoSelectionState();
}

class _TurnoSelectionState extends ConsumerState<TurnoSelection> {
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
