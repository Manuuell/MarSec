# MarSec - Ciberseguridad para embarcaciones

**MarSec** es una aplicación de ciberseguridad diseñada para mejorar la seguridad de las embarcaciones a través de lecciones interactivas, cuestionarios educativos, y un asistente virtual llamado *Capitán Ciber*. El objetivo principal de este proyecto es capacitar a las tripulaciones de los barcos para identificar y mitigar amenazas cibernéticas, asegurando la protección de los sistemas a bordo.

## Funcionalidades
- **Lecciones interactivas** sobre temas de ciberseguridad como ingeniería social, phishing, malware, entre otros.
- **Cuestionarios** de opción múltiple al final de cada lección para evaluar el conocimiento.
- **Asistente virtual "Capitán Ciber"** basado en inteligencia artificial para proporcionar consejos de seguridad en tiempo real.
- **Autenticación de usuarios** para gestionar el acceso a las lecciones y el progreso de cada usuario.
  
## Tecnologías utilizadas

### Backend:
- **Node.js**: Para el servidor y la lógica de backend.
- **Express.js**: Framework para Node.js.
- **SQL Server en Azure**: Para la base de datos de usuarios y registros.


### Frontend:
- **Flutter**: Framework para crear la aplicación móvil (Android/iOS) y la versión web.
- **Lottie**: Animaciones para mejorar la experiencia de usuario.
- **Flutter Dotenv**: Para la carga de variables de entorno (por ejemplo, claves de la API).
  
## Requisitos

1. Tener **Node.js** instalado en tu máquina para correr el servidor backend.
2. Tener **Flutter** instalado para compilar la aplicación móvil y web.

## Instalación

### Backend

1. Clona este repositorio:
   ```bash
   git clone https://github.com/tu-usuario/marsec.git

2. Dirígete a la carpeta del backend:
   ```bash
   cd marsec/backend

3. Instala las dependencias de Flutter:
   ```bash
   flutter pub get

4. Para ejecutar la aplicación en un emulador o dispositivo físico:
   ```bash
   flutter run
