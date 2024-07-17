import 'package:flutter_riverpod/flutter_riverpod.dart';

final ingresoFormProvider =
    StateNotifierProvider<IngresoNotifier, IngresoFormState>((ref) {
  return IngresoNotifier();
});

class IngresoFormState {
  final String dni;
  final String turno;
  final String motivo;

  IngresoFormState({
    this.dni = '',
    this.turno = '',
    this.motivo = '',
  });

  IngresoFormState copyWith({
    String? dni,
    String? turno,
    String? motivo,
    bool? isValid,
  }) {
    return IngresoFormState(
      dni: dni ?? this.dni,
      // turno: turno ?? this.turno,
      motivo: motivo ?? this.motivo,
    );
  }
}

class IngresoNotifier extends StateNotifier<IngresoFormState> {
  IngresoNotifier() : super(IngresoFormState());

  void updateDni(String dni) {
    state = state.copyWith(
      dni: dni,
      // isValid: _validateForm(dni, state.nombre, state.motivo),
    );
  }

  void updateTurno(String turno) {
    state = state.copyWith(
      turno: turno,
      // isValid: _validateForm(state.dni, nombre, state.motivo),
    );
  }

  void updateMotivo(String motivo) {
    state = state.copyWith(
      motivo: motivo,
      // isValid: _validateForm(state.dni, state.nombre, motivo),
    );
  }

  // bool _validateForm(String dni, String nombre, String motivo) {
  //   return dni.isNotEmpty && nombre.isNotEmpty && motivo.isNotEmpty;
  // }
}
