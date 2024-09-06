import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical/utils/constants.dart';
import 'package:medical/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormularioService {
  Future<void> submitFormulario({
    required BuildContext context,
    required Map<String, dynamic> formData,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${Constants.uri}/api/formulario'),
      );

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'x-auth-token': token ?? '',
      });

      request.fields['tipoSangre'] = formData['tipoSangre'];
      request.fields['nombre'] = formData['nombre'];
      request.fields['apellidoPaterno'] = formData['apellidoPaterno'];
      request.fields['apellidoMaterno'] = formData['apellidoMaterno'];
      request.fields['rfc'] = formData['rfc'];
      request.fields['calle'] = formData['calle'];
      request.fields['colonia'] = formData['colonia'];
      request.fields['numero'] = formData['numero'];
      request.fields['edad'] = formData['edad'];
      request.fields['enfermedades'] = formData['enfermedades'];
      request.fields['telefonoCasa'] = formData['telefonoCasa'];
      request.fields['telefonoMovil'] = formData['telefonoMovil'];

      request.files.add(await http.MultipartFile.fromPath(
        'actaNacimiento',
        formData['actaNacimiento'].path,
        filename: 'acta_nacimiento.pdf',
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'curp',
        formData['curp'].path,
        filename: 'curp.pdf',
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'ine',
        formData['ine'].path,
        filename: 'ine.jpg',
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        showSnackBar(context, 'Formulario enviado exitosamente');
      } else {
        showSnackBar(context, 'Error al enviar el formulario');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
