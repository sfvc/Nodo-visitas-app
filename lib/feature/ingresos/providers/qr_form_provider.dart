import 'package:flutter_riverpod/flutter_riverpod.dart';

final qrFormProvider =
    StateNotifierProvider<QrFormNotifier, QrFormState>((ref) {
  return QrFormNotifier();
});

class QrFormState {
  final String qrValue;
  final String numeroTramite;
  final String apellido;
  final String nombre;
  final String sexo;
  final String dni;
  final String ejemplar;
  final String fechaNacimiento;
  final String fechaEmision;

  QrFormState({
    this.qrValue = "",
    this.numeroTramite = "",
    this.apellido = "",
    this.nombre = "",
    this.sexo = "",
    this.dni = "",
    this.ejemplar = "",
    this.fechaNacimiento = "",
    this.fechaEmision = "",
  });

  QrFormState copyWith({
    String? qrValue,
    String? numeroTramite,
    String? apellido,
    String? nombre,
    String? sexo,
    String? dni,
    String? ejemplar,
    String? fechaNacimiento,
    String? fechaEmision,
  }) {
    return QrFormState(
      qrValue: qrValue ?? this.qrValue,
      numeroTramite: numeroTramite ?? this.numeroTramite,
      apellido: apellido ?? this.apellido,
      nombre: nombre ?? this.nombre,
      sexo: sexo ?? this.sexo,
      dni: dni ?? this.dni,
      ejemplar: ejemplar ?? this.ejemplar,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      fechaEmision: fechaEmision ?? this.fechaEmision,
    );
  }
}

class QrFormNotifier extends StateNotifier<QrFormState> {
  QrFormNotifier() : super(QrFormState());

  void setQRValue(String? qrValue) {
    if (qrValue == null) return;

    List<String> parts = qrValue.split('@');
    if (parts.length == 9) {
      state = state.copyWith(
        numeroTramite: parts[0],
        apellido: parts[1],
        nombre: parts[2],
        sexo: parts[3],
        dni: parts[4],
        ejemplar: parts[5],
        fechaNacimiento: parts[6],
        fechaEmision: parts[7],
      );
    }
  }
}
