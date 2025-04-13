const express = require('express');
const sql = require('mssql');
const app = express();
const port = 4000;

// Configuración de la conexión a Azure SQL Database
const config = {
  user: 'Manulito',
  password: 'Qwerty291209*',
  server: 'marsec-serve.database.windows.net',
  port: 1433,
  database: 'marsec_db',
  authentication: {
    type: 'default',
  },
  options: {
    encrypt: true,
  }
};

// Middleware para parsear el cuerpo de las solicitudes como JSON
app.use(express.json());

// Ruta para iniciar sesión (verificación de usuario)
app.post('/login', async (req, res) => {
  const { email, password } = req.body; // Extraemos el correo y la contraseña del cuerpo de la solicitud

  try {
    // Conectarse a la base de datos de Azure SQL
    const pool = await sql.connect(config);

    // Consulta SQL para buscar al usuario con el correo electrónico proporcionado
    const result = await pool.request()
      .input('email', sql.NVarChar, email) // Definir parámetro de entrada
      .query('SELECT * FROM Users WHERE Email = @email');

    const user = result.recordset[0]; // Obtenemos el primer resultado (si existe)

    // Si el usuario no existe
    if (!user) {
      return res.status(400).json({ message: 'Usuario no encontrado' });
    }

    // Comparar la contraseña proporcionada con la almacenada (suponiendo que la contraseña esté almacenada en texto claro)
    // En un escenario real, deberías usar hashing y salt para las contraseñas
    if (user.Password === password) {
      // Si las credenciales son correctas
      return res.status(200).json({ message: 'Inicio de sesión exitoso' });
    } else {
      return res.status(400).json({ message: 'Contraseña incorrecta' });
    }
  } catch (err) {
    console.error('Error al verificar el usuario:', err);
    res.status(500).json({ message: 'Error en el servidor' });
  }
});

// Iniciar el servidor en el puerto 4000
app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});
