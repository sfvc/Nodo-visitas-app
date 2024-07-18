import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nodo_app_2/feature/home/domain/person_entity.dart';

final ingresoFormProvider =
    StateNotifierProvider.autoDispose<IngresoNotifier, IngresoFormState>((ref) {
  return IngresoNotifier();
});

class IngresoFormState {
  final String dni;
  final String turno;
  final String motivo;
  final Persona? persona;
  final bool isPosting;

  IngresoFormState({
    this.persona,
    this.isPosting = false,
    this.dni = '',
    this.turno = '',
    this.motivo = '',
  });

  IngresoFormState copyWith({
    String? dni,
    String? turno,
    String? motivo,
    bool? isPosting,
    Persona? persona,
  }) {
    return IngresoFormState(
      dni: dni ?? this.dni,
      isPosting: isPosting ?? this.isPosting,
      turno: turno ?? this.turno,
      motivo: motivo ?? this.motivo,
      persona: persona ?? this.persona,
    );
  }
}

class IngresoNotifier extends StateNotifier<IngresoFormState> {
  IngresoNotifier() : super(IngresoFormState());

  void updateDni(String dni) {
    state = state.copyWith(dni: dni);
  }

  void updateTurno(String turno) {
    state = state.copyWith(turno: turno);
  }

  void updateMotivo(String motivo) {
    state = state.copyWith(motivo: motivo);
  }

  void updatePersona(Persona persona) {
    state = state.copyWith(persona: persona);
  }

  void updateIsPosting(bool isPosting) {
    state = state.copyWith(isPosting: isPosting);
  }

  void reset() {
    state = IngresoFormState();
  }
}
