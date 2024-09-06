const mongoose = require('mongoose');

const formularioSchema = new mongoose.Schema({
  tipoSangre: {
    type: String,
    required: true,
  },
  nombre: {
    type: String,
    required: true,
  },
  apellidoPaterno: {
    type: String,
    required: true,
  },
  apellidoMaterno: {
    type: String,
    required: true,
  },
  rfc: {
    type: String,
    required: true,
  },
  calle: {
    type: String,
    required: true,
  },
  colonia: {
    type: String,
    required: true,
  },
  numero: {
    type: String,
    required: true,
  },
  edad: {
    type: Number,
    required: true,
  },
  enfermedades: {
    type: String,
    required: true,
  },
  telefonoCasa: {
    type: String,
    required: true,
  },
  telefonoMovil: {
    type: String,
    required: true,
  },
  actaNacimiento: {
    type: String,
    required: true,
  },
  curp: {
    type: String,
    required: true,
  },
  ine: {
    type: String,
    required: true,
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
}, { timestamps: true });

const Formulario = mongoose.model('Formulario', formularioSchema);
module.exports = Formulario;
