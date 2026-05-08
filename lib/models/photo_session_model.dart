import 'package:cloud_firestore/cloud_firestore.dart';

class PhotoSession {
  final String id;
  final String nombreCliente;
  final String tipoSesion;
  final String fechaSesion;
  final double costoTotal;
  final bool fotosEntregadas;

  PhotoSession({
    required this.id,
    required this.nombreCliente,
    required this.tipoSesion,
    required this.fechaSesion,
    required this.costoTotal,
    required this.fotosEntregadas,
  });

  factory PhotoSession.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return PhotoSession(
      id: doc.id,
      nombreCliente: data['nombreCliente'] ?? '',
      tipoSesion: data['tipoSesion'] ?? '',
      fechaSesion: data['fechaSesion'] ?? '',
      costoTotal: (data['costoTotal'] ?? 0).toDouble(),
      fotosEntregadas: data['fotosEntregadas'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombreCliente': nombreCliente,
      'tipoSesion': tipoSesion,
      'fechaSesion': fechaSesion,
      'costoTotal': costoTotal,
      'fotosEntregadas': fotosEntregadas,
    };
  }
}
