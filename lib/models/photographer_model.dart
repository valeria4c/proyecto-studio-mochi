import 'package:cloud_firestore/cloud_firestore.dart';

class Photographer {
  final String id;
  final String certificado;
  final String seccion;
  final String horario;
  final String nombre;
  final double salario;

  Photographer({
    required this.id,
    required this.certificado,
    required this.seccion,
    required this.horario,
    required this.nombre,
    required this.salario,
  });

  factory Photographer.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Photographer(
      id: doc.id,
      certificado: data['certificado'] ?? '',
      seccion: data['seccion'] ?? '',
      horario: data['horarioTurno'] ?? '',
      nombre: data['nombre'] ?? '',
      salario: (data['salario'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'certificado': certificado,
      'seccion': seccion,
      'horarioTurno': horario,
      'nombre': nombre,
      'salario': salario,
    };
  }
}
