const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const fs = require('fs'); // Importa fs para manejar el sistema de archivos
const Formulario = require('../models/formulario');
const auth = require('../middleware/auth');

// Verifica si el directorio 'uploads/' existe, si no, lo crea
const uploadDir = path.join(__dirname, '../uploads');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir);
}

// Configuración de multer para almacenamiento de archivos
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, uploadDir); // Usa el directorio que acabamos de crear o verificar
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, uniqueSuffix + path.extname(file.originalname));
  }
});

const upload = multer({ storage: storage });

// Ruta para manejar la carga del formulario
router.post('/api/formulario', auth, upload.fields([
  { name: 'actaNacimiento', maxCount: 1 },
  { name: 'curp', maxCount: 1 },
  { name: 'ine', maxCount: 1 },
]), async (req, res) => {
  try {
    const {
      tipoSangre,
      nombre,
      apellidoPaterno,
      apellidoMaterno,
      rfc,
      calle,
      colonia,
      numero,
      edad,
      enfermedades,
      telefonoCasa,
      telefonoMovil,
    } = req.body;

    const formulario = new Formulario({
      tipoSangre,
      nombre,
      apellidoPaterno,
      apellidoMaterno,
      rfc,
      calle,
      colonia,
      numero,
      edad,
      enfermedades,
      telefonoCasa,
      telefonoMovil,
      actaNacimiento: req.files['actaNacimiento'][0].path,
      curp: req.files['curp'][0].path,
      ine: req.files['ine'][0].path,
      user: req.user, // Asociamos el formulario al usuario autenticado
    });

    await formulario.save();

    res.status(200).json({ message: 'Formulario guardado exitosamente' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al guardar el formulario' });
  }
});


// Ruta para obtener todos los formularios
router.get('/api/formulario', async (req, res) => {
    try {
      // Usa populate para obtener la información del usuario si es necesario
      const formularios = await Formulario.find().populate('user', 'nombre apellidoPaterno apellidoMaterno');
      res.status(200).json(formularios);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Error al obtener los formularios' });
    }
  });
  
module.exports = router;
