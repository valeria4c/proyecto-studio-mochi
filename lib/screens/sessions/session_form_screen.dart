import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/photo_session_model.dart';

class SessionFormScreen extends StatefulWidget {
  final PhotoSession? session;

  const SessionFormScreen({super.key, this.session});

  @override
  State<SessionFormScreen> createState() => _SessionFormScreenState();
}

class _SessionFormScreenState extends State<SessionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreClienteCtrl;
  late TextEditingController _tipoSesionCtrl;
  late TextEditingController _fechaSesionCtrl;
  late TextEditingController _costoTotalCtrl;
  bool _fotosEntregadas = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fotosEntregadas = widget.session?.fotosEntregadas ?? false;
    _nombreClienteCtrl = TextEditingController(text: widget.session?.nombreCliente ?? '');
    _tipoSesionCtrl = TextEditingController(text: widget.session?.tipoSesion ?? '');
    _fechaSesionCtrl = TextEditingController(text: widget.session?.fechaSesion ?? '');
    _costoTotalCtrl = TextEditingController(text: widget.session?.costoTotal.toString() ?? '');
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final collection = FirebaseFirestore.instance.collection('photo_sessions');
        final data = {
          'nombreCliente': _nombreClienteCtrl.text,
          'tipoSesion': _tipoSesionCtrl.text,
          'fechaSesion': _fechaSesionCtrl.text,
          'costoTotal': double.tryParse(_costoTotalCtrl.text) ?? 0.0,
          'fotosEntregadas': _fotosEntregadas,
        };

        if (widget.session == null) {
          await collection.add(data);
        } else {
          await collection.doc(widget.session!.id).update(data);
        }

        if (mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.session == null ? 'Nueva Sesión' : 'Editar Sesión'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreClienteCtrl,
                decoration: const InputDecoration(labelText: 'Nombre del Cliente', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _tipoSesionCtrl,
                decoration: const InputDecoration(labelText: 'Tipo de Sesión (Ej. Boda, Retrato)', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _fechaSesionCtrl,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Fecha de la Sesión', 
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                    helpText: 'Selecciona la fecha',
                  );
                  if (date != null) {
                    _fechaSesionCtrl.text = "${date.day}/${date.month}/${date.year}";
                  }
                },
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _costoTotalCtrl,
                decoration: const InputDecoration(labelText: 'Costo Total', border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 15),
              SwitchListTile(
                title: const Text('¿Fotos Entregadas al Cliente?'),
                subtitle: Text(_fotosEntregadas ? 'Sí, ya se entregaron' : 'Aún pendientes de entrega'),
                value: _fotosEntregadas,
                onChanged: (val) => setState(() => _fotosEntregadas = val),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E3B6E),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _isLoading ? null : _save,
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Guardar Cambios'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
