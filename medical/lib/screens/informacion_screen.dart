import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical/services/formulario_service.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({Key? key}) : super(key: key);

  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tipoSangreController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoPaternoController = TextEditingController();
  final TextEditingController _apellidoMaternoController = TextEditingController();
  final TextEditingController _rfcController = TextEditingController();
  final TextEditingController _calleController = TextEditingController();
  final TextEditingController _coloniaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _enfermedadesController = TextEditingController();
  final TextEditingController _telefonoCasaController = TextEditingController();
  final TextEditingController _telefonoMovilController = TextEditingController();

  File? _actaNacimiento;
  File? _curp;
  File? _ine;

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    _tipoSangreController.dispose();
    _nombreController.dispose();
    _apellidoPaternoController.dispose();
    _apellidoMaternoController.dispose();
    _rfcController.dispose();
    _calleController.dispose();
    _coloniaController.dispose();
    _numeroController.dispose();
    _edadController.dispose();
    _enfermedadesController.dispose();
    _telefonoCasaController.dispose();
    _telefonoMovilController.dispose();
    super.dispose();
  }

  Future<void> _pickFile({required Function(File) onFilePicked, required String fileType}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType == 'pdf' ? FileType.custom : FileType.image,
      allowedExtensions: fileType == 'pdf' ? ['pdf'] : null,
    );

    if (result != null && result.files.single.path != null) {
      onFilePicked(File(result.files.single.path!));
    }
  }

  Future<void> _pickImage({required Function(File) onImagePicked}) async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onImagePicked(File(image.path));
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_actaNacimiento == null ||
          _curp == null ||
          _ine == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, adjunta todos los documentos requeridos')),
        );
        return;
      }

      // Crear un mapa con todos los datos
      Map<String, dynamic> formData = {
        'tipoSangre': _tipoSangreController.text,
        'nombre': _nombreController.text,
        'apellidoPaterno': _apellidoPaternoController.text,
        'apellidoMaterno': _apellidoMaternoController.text,
        'rfc': _rfcController.text,
        'calle': _calleController.text,
        'colonia': _coloniaController.text,
        'numero': _numeroController.text,
        'edad': _edadController.text,
        'enfermedades': _enfermedadesController.text,
        'telefonoCasa': _telefonoCasaController.text,
        'telefonoMovil': _telefonoMovilController.text,
        'actaNacimiento': _actaNacimiento,
        'curp': _curp,
        'ine': _ine,
      };

      // Enviar datos al servicio
      FormularioService().submitFormulario(context: context, formData: formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Información Médica'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Tipo de Sangre
              TextFormField(
                controller: _tipoSangreController,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Sangre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu tipo de sangre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Nombre
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Apellido Paterno
              TextFormField(
                controller: _apellidoPaternoController,
                decoration: const InputDecoration(
                  labelText: 'Apellido Paterno',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu apellido paterno';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Apellido Materno
              TextFormField(
                controller: _apellidoMaternoController,
                decoration: const InputDecoration(
                  labelText: 'Apellido Materno',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu apellido materno';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Acta de Nacimiento
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: Text(_actaNacimiento != null ? 'Acta de Nacimiento seleccionada' : 'Adjuntar Acta de Nacimiento (PDF)'),
                trailing: IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    _pickFile(
                      onFilePicked: (file) {
                        setState(() {
                          _actaNacimiento = file;
                        });
                      },
                      fileType: 'pdf',
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // CURP
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: Text(_curp != null ? 'CURP seleccionada' : 'Adjuntar CURP (PDF)'),
                trailing: IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    _pickFile(
                      onFilePicked: (file) {
                        setState(() {
                          _curp = file;
                        });
                      },
                      fileType: 'pdf',
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // RFC
              TextFormField(
                controller: _rfcController,
                decoration: const InputDecoration(
                  labelText: 'RFC',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu RFC';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Calle
              TextFormField(
                controller: _calleController,
                decoration: const InputDecoration(
                  labelText: 'Calle',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu calle';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Colonia
              TextFormField(
                controller: _coloniaController,
                decoration: const InputDecoration(
                  labelText: 'Colonia',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu colonia';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Número Exterior e Interior
              TextFormField(
                controller: _numeroController,
                decoration: const InputDecoration(
                  labelText: 'Número Exterior e Interior',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu número exterior e interior';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Edad
              TextFormField(
                controller: _edadController,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu edad';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, ingresa una edad válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Enfermedades o Alergias
              TextFormField(
                controller: _enfermedadesController,
                decoration: const InputDecoration(
                  labelText: 'Enfermedades o Alergias',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tus enfermedades o alergias';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Teléfono de Casa
              TextFormField(
                controller: _telefonoCasaController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono de Casa',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu teléfono de casa';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Teléfono Móvil
              TextFormField(
                controller: _telefonoMovilController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono Móvil',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu teléfono móvil';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // INE
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: Text(_ine != null ? 'INE seleccionada' : 'Adjuntar INE (Imagen)'),
                trailing: IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    _pickImage(
                      onImagePicked: (file) {
                        setState(() {
                          _ine = file;
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Botón de Enviar
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Enviar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
