import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/photographer_model.dart';

class PhotographerFormScreen extends StatefulWidget {
  final Photographer? photographer;

  const PhotographerFormScreen({super.key, this.photographer});

  @override
  State<PhotographerFormScreen> createState() => _PhotographerFormScreenState();
}

class _PhotographerFormScreenState extends State<PhotographerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _certificadoCtrl;
  late TextEditingController _seccionCtrl;
  late TextEditingController _horarioCtrl;
  late TextEditingController _nombreCtrl;
  late TextEditingController _salarioCtrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _certificadoCtrl = TextEditingController(
      text: widget.photographer?.certificado ?? '',
    );
    _seccionCtrl = TextEditingController(
      text: widget.photographer?.seccion ?? '',
    );
    _horarioCtrl = TextEditingController(
      text: widget.photographer?.horario ?? '',
    );
    _nombreCtrl = TextEditingController(
      text: widget.photographer?.nombre ?? '',
    );
    _salarioCtrl = TextEditingController(
      text: widget.photographer?.salario.toString() ?? '',
    );
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final collection = FirebaseFirestore.instance.collection(
          'photographers',
        );
        final data = {
          'certificado': _certificadoCtrl.text,
          'seccion': _seccionCtrl.text,
          'horarioTurno': _horarioCtrl.text,
          'nombre': _nombreCtrl.text,
          'salario': double.tryParse(_salarioCtrl.text) ?? 0.0,
        };

        if (widget.photographer == null) {
          await collection.add(data);
        } else {
          await collection.doc(widget.photographer!.id).update(data);
        }

        if (mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
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
        title: Text(
          widget.photographer == null ? 'Nuevo Fotógrafo' : 'Editar Fotógrafo',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _certificadoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Certificado (Título)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _seccionCtrl,
                decoration: const InputDecoration(
                  labelText: 'Sección',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _horarioCtrl,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Horario de Turno (Hora de Entrada)',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.access_time),
                ),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    helpText: 'Selecciona la hora de entrada',
                  );
                  if (time != null && mounted) {
                    _horarioCtrl.text = time.format(context);
                  }
                },
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _salarioCtrl,
                decoration: const InputDecoration(
                  labelText: 'Salario',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (v) => v!.isEmpty ? 'Requerido' : null,
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
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
