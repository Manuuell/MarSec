import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para manejar los datos JSON

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(CiberShieldApp());
}


class CiberShieldApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CiberShield',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.grey[800],
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: AppBarTheme(
          color: Colors.grey[800],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.grey[900]),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => MainMenuScreen(),
        '/quiz': (context) {
          final questions = ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>;
          return QuizScreen(questions: questions);
        },
        '/tips': (context) => TipsScreen(),
        '/profile': (context) => ProfilePage(),
        '/lessons': (context) => LessonsPage(),  // Aquí agregamos la ruta para Lecciones
        '/chatbot': (context) => ChatbotScreen(),  // Aquí agregamos la ruta para Capitán Ciber
      },
    );
  }
}


class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0A1229),
              Color(0xFF0C1A3C),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bienvenido a\nMarSec',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40),
                  Image.asset(
                    'assets/images/marsec2_logo.png',
                    width: 280,
                    height: 280,
                  ),
                  SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF36C9C9),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    ),
                    child: Text(
                      'Comenzar',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 17, 43, 1),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),
                Image.asset(
                  'assets/images/marsec_logo.png',
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 16),
                Text(
                  'CiberShield',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 32),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(20, 40, 70, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                      hintText: 'Correo Electrónico',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.email, color: Colors.white70),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(20, 40, 70, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                      hintText: 'Contraseña',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.lock, color: Colors.white70),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(11, 123, 142, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  ),
                  child: Text(
                    'Entrar',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class MainMenuScreen extends StatefulWidget {
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  List<Map<String, dynamic>> _questions = [];
  bool isLoading = true;  // Esta variable controla el indicador de carga

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      // Simulamos la carga de preguntas
      final questions = await generateQuizQuestions();
      setState(() {
        _questions = questions;
        isLoading = false; // Cambiar el estado de carga cuando termine
      });
    } catch (e) {
      print('Error cargando las preguntas: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 17, 43, 1),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/marsec_logo.png',
                  width: 120,
                  height: 120,
                ),
                SizedBox(height: 20),
                Text(
                  'MarSec',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                // Aquí mostramos un indicador de carga solo cuando estamos cargando las preguntas
                if (isLoading)
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF36C9C9)),
                  ),
                SizedBox(height: 20),
                _MenuButton(
                  icon: Icons.book,
                  label: 'Lecciones',
                  onPressed: () {
                    // Navegar a la página de Lecciones
                    Navigator.pushNamed(context, '/lessons');
                  },
                ),
                _MenuButton(
                  icon: Icons.chat,
                  label: 'Capitán Ciber',
                  onPressed: () {
                    // Navegar al chatbot
                    Navigator.pushNamed(context, '/chatbot');
                  },
                ),
                if (!isLoading)
                  _MenuButton(
                    icon: Icons.quiz,
                    label: 'Quiz',
                    onPressed: () {
                      if (_questions.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Error"),
                            content: Text("No se cargaron preguntas. Intenta nuevamente."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          '/quiz',
                          arguments: _questions,
                        );
                      }
                    },
                  ),
                _MenuButton(
                  icon: Icons.lightbulb,
                  label: 'Consejos',
                  onPressed: () {
                    // Navegar a la página de Consejos
                    Navigator.pushNamed(context, '/tips');
                  },
                ),
                _MenuButton(
                  icon: Icons.person,
                  label: 'Perfil',
                  onPressed: () {
                    // Navegar a la página de Perfil
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages = [];

  // Función para enviar el mensaje y obtener la respuesta de GPT-4o
  Future<void> _sendMessage(String userMessage) async {
    setState(() {
      _messages.add({'sender': 'user', 'message': userMessage});
    });

    try {
      print('Intentando hacer la solicitud...');

      // Realiza la solicitud a la API de OpenAI
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'), // Endpoint correcto
        headers: {
          'Authorization': 'Bearer ${dotenv.env['OPENAI_API_KEY']}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'model': 'gpt-4o', // Usamos el modelo GPT-4o
          'messages': [
            {
              'role': 'system',
              'content': '''
              Eres un asistente virtual llamado **"Capitán Ciber"** diseñado específicamente para el proyecto **MarSec**, el cual tiene como objetivo mejorar la ciberseguridad de individuos y organizaciones de manera clara y accesible.

Tu misión es proporcionar **consejos de ciberseguridad** amigables y prácticos, así como **soluciones claras** para problemas relacionados con la protección de datos, seguridad en línea y prevención de ataques. Responde de manera **educativa** y **práctica**, adaptándote al **nivel de conocimiento** del usuario, ya sea principiante o avanzado.

Cuando respondas:
- **Usa ejemplos claros y aplicables** a situaciones cotidianas o de trabajo.
- **Explica términos técnicos de forma sencilla**, para que cualquiera pueda entenderlos, incluso si no tiene experiencia previa en tecnología o ciberseguridad.
- **Sé conciso pero detallado**: Evita sobrecargar al usuario con demasiada información, pero asegúrate de que tus respuestas sean completas y útiles.
- **Incorpora emojis** cuando sea apropiado para hacer la conversación más accesible y amena.
- **Mantén un tono profesional pero cercano**, ayudando al usuario a sentir que está aprendiendo y mejorando su seguridad digital.

Recuerda que tu objetivo principal es **educar, prevenir y proteger** a los usuarios, para que puedan implementar medidas de seguridad eficaces sin sentirse abrumados.

              '''
            },
            {
              'role': 'user',
              'content': userMessage,
            },
          ],
          'max_tokens': 1000,
          'temperature': 0.5, // Temperatura ajustada para mayor coherencia
        }),
      );

      print('Respuesta recibida: ${response.statusCode}');
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        String botMessage = responseData['choices'][0]['message']['content'];

        // Asegúrate de que el texto esté correctamente decodificado
        botMessage = utf8.decode(botMessage.runes.toList()); // Decodificación UTF-8

        // Extraer el número de tokens utilizados
        int tokensUsed = responseData['usage']['total_tokens'];
        print('Tokens utilizados en esta solicitud: $tokensUsed');

        setState(() {
          _messages.add({'sender': 'bot', 'message': botMessage.trim()});
        });
      } else {
        print('Error en la solicitud: ${response.statusCode}');
        print('Mensaje de error: ${response.body}');
        setState(() {
          _messages.add({'sender': 'bot', 'message': 'Lo siento, no pude entender eso.'});
        });
      }
    } catch (e) {
      print('Error en la conexión: $e');
      setState(() {
        _messages.add({'sender': 'bot', 'message': 'Hubo un problema al conectar con el servidor.'});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capitán Ciber'),
        backgroundColor: Color(0xFF0C1A3C),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message['sender'] == 'user'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: message['sender'] == 'user'
                            ? Color(0xFF36C9C9) // Fondo cian para el usuario
                            : Color(0xFF1A2637), // Fondo oscuro para el bot
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        message['message']!,
                        style: TextStyle(
                          color: message['sender'] == 'user'
                              ? Colors.white
                              : Colors.white70, // Texto blanco o ligeramente opaco para el bot
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFF36C9C9)),
                  onPressed: () {
                    String userMessage = _controller.text.trim();
                    if (userMessage.isNotEmpty) {
                      _sendMessage(userMessage);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _MenuButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(20, 40, 70, 1),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            SizedBox(width: 16),
            Icon(icon, color: Colors.white),
            SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}


class LessonsPage extends StatefulWidget {
  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  List<bool> completed = [true, false, false, false, false, false, false, false, false, false];

  final List<Map<String, dynamic>> lessons = [
    {
      'title': 'Ingeniería social',
      'icon': Icons.psychology,
      'description': 'Manipulación para obtener información confidencial.'
    },
    {
      'title': 'Phishing',
      'icon': Icons.email_outlined,
      'description': 'Fraudes que buscan obtener tus credenciales.'
    },
    {
      'title': 'Malware',
      'icon': Icons.bug_report,
      'description': 'Software malicioso que daña tu sistema.'
    },
    {
      'title': 'Ransomware',
      'icon': Icons.lock,
      'description': 'Secuestra tu información hasta pagar un rescate.'
    },
    {
      'title': 'Seguridad de red',
      'icon': Icons.wifi,
      'description': 'Medidas para proteger redes informáticas.'
    },
    {
      'title': 'Contraseñas seguras',
      'icon': Icons.vpn_key,
      'description': 'Claves robustas que previenen accesos no autorizados.'
    },
    {
      'title': 'Autenticación 2FA',
      'icon': Icons.security,
      'description': 'Método de verificación en dos pasos.'
    },
    {
      'title': 'Amenazas móviles',
      'icon': Icons.smartphone,
      'description': 'Riesgos y ataques dirigidos a dispositivos móviles.'
    },
    {
      'title': 'Navegación segura',
      'icon': Icons.shield,
      'description': 'Técnicas para evitar peligros al navegar por internet.'
    },
    {
      'title': 'Criptografía básica',
      'icon': Icons.code,
      'description': 'Cifrado de datos para proteger la información.'
    },
  ];

  void markLessonCompleted(int index) {
    setState(() {
      if (index < completed.length - 1) {
        completed[index + 1] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1A3C),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 24,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Column(
                  children: [
                    const Text(
                      '¡Hola, Usuario!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Stack(
                          children: [
                            CustomPaint(
                              size: Size(double.infinity, lessons.length * 140),
                              painter: ConnectionLinesPainter(lessons.length),
                            ),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return SizedBox(
                                  height: lessons.length * 140,
                                  child: Stack(
                                    children: List.generate(lessons.length, (index) {
                                      final isLeft = index % 2 == 0;
                                      final topPosition = index * 130.0;

                                      return Positioned(
                                        top: topPosition,
                                        left: isLeft ? 40 : null,
                                        right: isLeft ? null : 40,
                                        child: GestureDetector(
                                          onTap: completed[index]
                                              ? () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) {
                                                if (index == 0) {
                                                  return SocialEngineeringLesson(onComplete: () => markLessonCompleted(index));
                                                } else if (index == 1) {
                                                  return PhishingLesson(onComplete: () => markLessonCompleted(index));
                                                } else if (index == 2) {
                                                  return MalwareLesson(onComplete: () => markLessonCompleted(index));
                                                } else {
                                                  return Placeholder(); // Puedes seguir reemplazando esto con más lecciones
                                                }
                                              },
                                            ),

                                          )
                                              : null,
                                          child: Opacity(
                                            opacity: completed[index] ? 1.0 : 0.3,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white.withOpacity(0.05),
                                                  ),
                                                  child: Icon(
                                                    lessons[index]['icon'],
                                                    size: 50,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  lessons[index]['title'],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0C1A3C),
        selectedItemColor: const Color(0xFF36C9C9),
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: ''),
        ],
      ),
    );
  }
}

class ConnectionLinesPainter extends CustomPainter {
  final int lessonCount;
  ConnectionLinesPainter(this.lessonCount);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.3)
      ..strokeWidth = 2;

    for (int i = 0; i < lessonCount - 1; i++) {
      final fromX = (i % 2 == 0) ? 90.0 : size.width - 90.0;
      final fromY = i * 130.0 + 50;
      final toX = ((i + 1) % 2 == 0) ? 90.0 : size.width - 90.0;
      final toY = (i + 1) * 130.0 + 50;
      canvas.drawLine(Offset(fromX, fromY), Offset(toX, toY), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}



class _SocialEngineeringQuiz extends StatefulWidget {
  final VoidCallback onSuccess;

  const _SocialEngineeringQuiz({required this.onSuccess});

  @override
  State<_SocialEngineeringQuiz> createState() => _SocialEngineeringQuizState();
}

class _SocialEngineeringQuizState extends State<_SocialEngineeringQuiz> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _answered = false;
  bool _showRetryMessage = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': '¿Qué es la ingeniería social en ciberseguridad?',
      'options': [
        'Un tipo de software malicioso',
        'Una técnica para manipular personas y obtener información',
        'Un método de cifrado',
        'Una herramienta de red'
      ],
      'answer': 1,
    },
    {
      'question': '¿Cuál es una señal de posible intento de ingeniería social?',
      'options': [
        'Correos urgentes que piden información personal',
        'Actualizaciones de software',
        'Llamadas de amigos',
        'Mensajes de texto de familiares'
      ],
      'answer': 0,
    },
    {
      'question': '¿Qué debes hacer ante una solicitud sospechosa?',
      'options': [
        'Responder rápido para ayudar',
        'Compartir la información',
        'Verificar con fuentes oficiales',
        'Ignorarla completamente'
      ],
      'answer': 2,
    },
    {
      'question': '¿Quién puede ser víctima de la ingeniería social?',
      'options': [
        'Solo los expertos en tecnología',
        'Solo los niños',
        'Cualquier persona',
        'Solo los empleados de empresas'
      ],
      'answer': 2,
    },
    {
      'question': '¿Cuál es el objetivo de la ingeniería social?',
      'options': [
        'Mejorar la seguridad en redes',
        'Obtener acceso a información o sistemas',
        'Hacer amigos en línea',
        'Reparar computadoras dañadas'
      ],
      'answer': 1,
    },
  ];

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _questions[_currentQuestionIndex]['answer']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedAnswer = null;
      _answered = false;
    });
  }

  void _finishQuiz() {
    if (_score >= 3) {
      widget.onSuccess();
      Navigator.pop(context); // cerrar quiz
      Navigator.pop(context); // volver a LessonsPage
    } else {
      setState(() {
        _showRetryMessage = true;
        _currentQuestionIndex = 0;
        _score = 0;
        _selectedAnswer = null;
        _answered = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= _questions.length) {
      return Scaffold(
        backgroundColor: const Color(0xFF0C1A3C),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/capitannn.png', height: 150),
                const SizedBox(height: 24),
                Icon(
                  _score >= 3 ? Icons.emoji_events : Icons.error,
                  color: _score >= 3 ? Colors.greenAccent : Colors.redAccent,
                  size: 80,
                ),
                const SizedBox(height: 20),
                Text(
                  _score >= 3
                      ? '¡Bien hecho, has aprobado!'
                      : 'No alcanzaste el mínimo. Intenta nuevamente.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _finishQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF36C9C9),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _score >= 3 ? 'Finalizar' : 'Reintentar',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    var question = _questions[_currentQuestionIndex];
    return Scaffold(
      backgroundColor: const Color(0xFF0C1A3C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _questions.length,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF36C9C9)),
              ),
              const SizedBox(height: 32),
              Text(
                question['question'],
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ...List.generate(question['options'].length, (index) {
                Color color = Colors.white.withOpacity(0.05);
                if (_answered) {
                  if (index == question['answer']) {
                    color = Colors.green.withOpacity(0.8);
                  } else if (index == _selectedAnswer) {
                    color = Colors.red.withOpacity(0.7);
                  }
                }
                return GestureDetector(
                  onTap: () => _selectAnswer(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Text(
                      question['options'][index],
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              }),
              const Spacer(),
              if (_showRetryMessage)
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: Center(
                    child: Text(
                      'Debes obtener al menos 3 respuestas correctas para continuar.',
                      style: TextStyle(color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              Center(
                child: ElevatedButton(
                  onPressed: _answered ? _nextQuestion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF36C9C9),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Siguiente', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class SocialEngineeringLesson extends StatelessWidget {
  final VoidCallback onComplete;

  const SocialEngineeringLesson({required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1A3C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                '¡Hola Marinero!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Soy el Capitán Ciber y hoy aprenderemos sobre Ingeniería Social.',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'La ingeniería social es una técnica utilizada por atacantes para manipularte y obtener información confidencial. ¡Aprende a identificarla!',
                style: TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Image.asset('assets/images/capitannn.png', height: 220),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BFA6),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _SocialEngineeringQuiz(onSuccess: onComplete),
                    ),
                  );
                },
                child: const Text('¡Entendido, Capitán!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}


class PhishingLesson extends StatelessWidget {
  final VoidCallback onComplete;

  const PhishingLesson({required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1A3C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                '¡Hola Marinero!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Soy el Capitán Ciber y hoy aprenderemos sobre Phishing.',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'El phishing es una técnica utilizada por cibercriminales para engañarte y robar tus credenciales o datos personales. ¡Aprende a identificarlo!',
                style: TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Image.asset('assets/images/capitannn.png', height: 220),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BFA6),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PhishingQuiz(onSuccess: onComplete),
                    ),
                  );
                },
                child: const Text('¡Entendido, Capitán!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class PhishingQuiz extends StatefulWidget {
  final VoidCallback onSuccess;

  const PhishingQuiz({required this.onSuccess});

  @override
  _PhishingQuizState createState() => _PhishingQuizState();
}

class _PhishingQuizState extends State<PhishingQuiz> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _answered = false;
  bool _showRetryMessage = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': '¿Qué es el phishing?',
      'options': [
        'Un correo con descuentos reales',
        'Un intento de engaño para robar datos personales',
        'Una herramienta de seguridad',
        'Una forma de autenticación'
      ],
      'answer': 1,
    },
    {
      'question': '¿Cómo suele presentarse el phishing?',
      'options': [
        'Correos que piden información urgente',
        'Aplicaciones oficiales del banco',
        'Antivirus legítimos',
        'Redes sociales con seguridad'
      ],
      'answer': 0,
    },
    {
      'question': '¿Qué debes hacer si recibes un correo sospechoso?',
      'options': [
        'Responder rápidamente',
        'Ignorarlo y reportarlo',
        'Abrir los archivos adjuntos',
        'Enviar tu contraseña para verificar'
      ],
      'answer': 1,
    },
    {
      'question': '¿Cuál es un ejemplo de phishing?',
      'options': [
        'Un correo de tu banco pidiendo acceso inmediato a tu cuenta',
        'Una llamada de un amigo',
        'Un mensaje de tu jefe real',
        'Un correo del antivirus que instalaste'
      ],
      'answer': 0,
    },
    {
      'question': '¿Qué hace el Capitán Ciber?',
      'options': [
        'Robar información',
        'Educar sobre ciberseguridad',
        'Crear virus',
        'Enviar spam'
      ],
      'answer': 1,
    },
  ];

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _questions[_currentQuestionIndex]['answer']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedAnswer = null;
      _answered = false;
    });
  }

  void _finishQuiz() {
    if (_score >= 3) {
      widget.onSuccess(); // Marca la lección como completada
      Navigator.pop(context); // ← Esto cierra el quiz
      Navigator.pop(context); // ← Esto cierra el PhishingLesson y vuelve a LessonsPage
    } else {
      setState(() {
        _showRetryMessage = true;
        _currentQuestionIndex = 0;
        _score = 0;
        _selectedAnswer = null;
        _answered = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= _questions.length) {
      return Scaffold(
        backgroundColor: const Color(0xFF0C1A3C),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _score >= 3 ? Icons.emoji_events : Icons.error,
                  color: _score >= 3 ? Colors.greenAccent : Colors.redAccent,
                  size: 80,
                ),
                const SizedBox(height: 20),
                Text(
                  _score >= 3
                      ? '¡Bien hecho, has aprobado!'
                      : 'No alcanzaste el mínimo. Intenta nuevamente.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _finishQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF36C9C9),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _score >= 3 ? 'Finalizar' : 'Reintentar',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    var question = _questions[_currentQuestionIndex];
    return Scaffold(
      backgroundColor: const Color(0xFF0C1A3C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _questions.length,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF36C9C9)),
              ),
              const SizedBox(height: 32),
              Text(
                question['question'],
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ...List.generate(question['options'].length, (index) {
                Color color = Colors.white.withOpacity(0.05);
                if (_answered) {
                  if (index == question['answer']) {
                    color = Colors.green.withOpacity(0.8);
                  } else if (index == _selectedAnswer) {
                    color = Colors.red.withOpacity(0.7);
                  }
                }
                return GestureDetector(
                  onTap: () => _selectAnswer(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Text(
                      question['options'][index],
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              }),
              const Spacer(),
              if (_showRetryMessage)
                const Text(
                  'No alcanzaste el mínimo de respuestas correctas. ¡Intenta de nuevo!',
                  style: TextStyle(color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _answered ? _nextQuestion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF36C9C9),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Continuar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MalwareLesson extends StatelessWidget {
  final VoidCallback onComplete;

  const MalwareLesson({required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1A3C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                '¡Hola Marinero!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Soy el Capitán Ciber y hoy aprenderemos sobre Malware.',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'El malware es un software malicioso que puede dañar tu sistema o robar información. ¡Aprende a protegerte!',
                style: TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Image.asset('assets/images/capitannn.png', height: 220),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BFA6),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MalwareQuiz(onSuccess: onComplete),
                    ),
                  );
                },
                child: const Text('¡Entendido, Capitán!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
class MalwareQuiz extends StatefulWidget {
  final VoidCallback onSuccess;

  const MalwareQuiz({required this.onSuccess});

  @override
  _MalwareQuizState createState() => _MalwareQuizState();
}

class _MalwareQuizState extends State<MalwareQuiz> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _answered = false;
  bool _showRetryMessage = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': '¿Qué es el malware?',
      'options': [
        'Una actualización del sistema',
        'Un software malicioso',
        'Una herramienta para programar',
        'Una extensión de navegador'
      ],
      'answer': 1,
    },
    {
      'question': '¿Qué puede hacer un virus informático?',
      'options': [
        'Aumentar tu velocidad de internet',
        'Reparar tu sistema',
        'Eliminar o robar información',
        'Hacer copias de seguridad'
      ],
      'answer': 2,
    },
    {
      'question': '¿Qué debes evitar para no infectarte con malware?',
      'options': [
        'Actualizar tu software',
        'Usar antivirus',
        'Descargar archivos sospechosos',
        'Navegar en sitios seguros'
      ],
      'answer': 2,
    },
    {
      'question': '¿Qué herramienta ayuda a proteger contra malware?',
      'options': [
        'Firewall',
        'Calculadora',
        'Bloc de notas',
        'Excel'
      ],
      'answer': 0,
    },
    {
      'question': '¿Cuál es un tipo de malware?',
      'options': [
        'Ransomware',
        'Bluetooth',
        'Zip',
        'Java'
      ],
      'answer': 0,
    },
  ];

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _questions[_currentQuestionIndex]['answer']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedAnswer = null;
      _answered = false;
    });
  }

  void _finishQuiz() {
    if (_score >= 3) {
      widget.onSuccess();
      Navigator.pop(context); // Cierra el quiz
      Navigator.pop(context); // Cierra la lección
    } else {
      setState(() {
        _showRetryMessage = true;
        _currentQuestionIndex = 0;
        _score = 0;
        _selectedAnswer = null;
        _answered = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= _questions.length) {
      return Scaffold(
        backgroundColor: const Color(0xFF0C1A3C),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _score >= 3 ? Icons.emoji_events : Icons.error,
                  color: _score >= 3 ? Colors.greenAccent : Colors.redAccent,
                  size: 80,
                ),
                const SizedBox(height: 20),
                Text(
                  _score >= 3
                      ? '¡Bien hecho, has aprobado!'
                      : 'No alcanzaste el mínimo. Intenta nuevamente.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _score >= 3 ? _finishQuiz : () {
                    setState(() {
                      _showRetryMessage = false;
                      _currentQuestionIndex = 0;
                      _score = 0;
                      _selectedAnswer = null;
                      _answered = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF36C9C9),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _score >= 3 ? 'Finalizar' : 'Reintentar',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    var question = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0C1A3C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _questions.length,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF36C9C9)),
              ),
              const SizedBox(height: 32),
              Text(
                question['question'],
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ...List.generate(question['options'].length, (index) {
                Color color = Colors.white.withOpacity(0.05);
                if (_answered) {
                  if (index == question['answer']) {
                    color = Colors.green.withOpacity(0.8);
                  } else if (index == _selectedAnswer) {
                    color = Colors.red.withOpacity(0.7);
                  }
                }
                return GestureDetector(
                  onTap: () => _selectAnswer(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Text(
                      question['options'][index],
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              }),
              const Spacer(),
              if (_showRetryMessage)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'No alcanzaste el mínimo de respuestas correctas. ¡Intenta de nuevo!',
                    style: TextStyle(color: Colors.redAccent),
                    textAlign: TextAlign.center,
                  ),
                ),
              Center(
                child: ElevatedButton(
                  onPressed: _answered ? _nextQuestion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF36C9C9),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Continuar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<Map<String, dynamic>>> generateQuizQuestions() async {
  try {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['OPENAI_API_KEY']}',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'model': 'gpt-4o',
        'messages': [
          {
            'role': 'system',
            'content': 'Eres un asistente que genera preguntas de opción múltiple sobre ciberseguridad. ¡Devuélvelas únicamente como un array JSON, sin texto adicional!'
          },
          {
            'role': 'user',
            'content': '''Genera 5 preguntas de opción múltiple sobre seguridad informática para un quiz.
Devuélvelas **solo** en este formato JSON:
[
  {
    "question": "¿…?",
    "options": ["A", "B", "C", "D"],
    "correctAnswer": 0
  },
  … (5 objetos)
]'''
          }
        ],
        'max_tokens': 500,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode != 200) {
      print('Error API: ${response.statusCode}');
      return [];
    }

    // Aquí viene el cambio clave: leemos los bytes crudos y los decodificamos como UTF-8
    final raw = utf8.decode(response.bodyBytes);

    // Parseamos el JSON completo
    final data = json.decode(raw);
    final content = data['choices'][0]['message']['content'] as String;

    // Extraemos solo el array JSON
    final start = content.indexOf('[');
    final end = content.lastIndexOf(']');
    if (start < 0 || end <= start) {
      print('JSON no encontrado en la respuesta: $content');
      return [];
    }
    final jsonString = content.substring(start, end + 1);

    // Parseamos el array de preguntas
    final List<dynamic> parsed = json.decode(jsonString);
    return parsed.map((e) => {
      'question': e['question'] as String,
      'options': List<String>.from(e['options'] as List),
      'correctAnswer': e['correctAnswer'] as int,
    }).toList();
  } catch (e) {
    print('Error generando preguntas: $e');
    return [];
  }
}

class QuizScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  QuizScreen({Key? key, required this.questions}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _answered = false;
  bool _showResult = false;

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == widget.questions[_currentQuestionIndex]['correctAnswer']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex + 1 < widget.questions.length) {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _answered = false;
      } else {
        _finishQuiz();
      }
    });
  }

  void _finishQuiz() {
    setState(() {
      _showResult = true; // Mostramos el resultado final
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showResult) {
      return Scaffold(
        backgroundColor: const Color(0xFF0C1A3C),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _score >= 3 ? Icons.emoji_events : Icons.error,
                  color: _score >= 3 ? Colors.greenAccent : Colors.redAccent,
                  size: 80,
                ),
                const SizedBox(height: 20),
                Text(
                  _score >= 3
                      ? '¡Bien hecho, has aprobado!'
                      : 'No alcanzaste el mínimo. Intenta nuevamente.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_score >= 3) {
                      Navigator.pop(context); // Cerrar quiz
                    } else {
                      setState(() {
                        _currentQuestionIndex = 0;
                        _score = 0;
                        _selectedAnswer = null;
                        _answered = false;
                        _showResult = false; // Reintentar quiz
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF36C9C9),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _score >= 3 ? 'Finalizar' : 'Reintentar',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Validar si hay preguntas
    if (widget.questions.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF0C1A3C),
        body: Center(
          child: Text(
            "No hay preguntas disponibles.",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      );
    }

    var question = widget.questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0C1A3C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C1A3C),
        elevation: 0,
        title: const Text("Quiz de Ciberseguridad"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / widget.questions.length,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF36C9C9)),
            ),
            const SizedBox(height: 32),
            Text(
              question['question'],
              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...List.generate(question['options'].length, (index) {
              Color color = Colors.white.withOpacity(0.05);
              if (_answered) {
                if (index == question['correctAnswer']) {
                  color = Colors.green.withOpacity(0.8);
                } else if (index == _selectedAnswer) {
                  color = Colors.red.withOpacity(0.7);
                }
              }
              return GestureDetector(
                onTap: () => _selectAnswer(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Text(
                    question['options'][index],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              );
            }),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _answered ? _nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF36C9C9),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Siguiente', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}




class TipsScreen extends StatelessWidget {
  final List<String> tips = [
    'Usa contraseñas seguras y únicas para cada cuenta.',
    'No compartas información personal en línea.',
    'Mantén tu software y antivirus actualizados.',
    'Activa la autenticación de dos factores siempre que sea posible.',
    'Desconfía de correos y mensajes sospechosos.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0A1229),
              Color(0xFF0C1A3C),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFF36C9C9)),
                  onPressed: () => Navigator.pop(context),
                ),
                Center(
                  child: Text(
                    'CONSEJOS DE\nSEGURIDAD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    itemCount: tips.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.verified_user,
                                color: Color(0xFF36C9C9), size: 28),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                tips[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo con degradado
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0A1229),
              Color(0xFF0C1A3C),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Flecha de retroceso
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Ícono circular
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF36C9C9),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: Color(0xFF36C9C9),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Nombre',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '10 / 20 PARA EL PRÓXIMO NIVEL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        // Barra de progreso
                        Container(
                          width: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: 0.5,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF36C9C9),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        // Tarjetas de Insignias y Puntos
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Insignias
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFF36C9C9),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.emoji_events,
                                    color: Color(0xFF36C9C9),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Insignias',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            // Puntos
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFF36C9C9),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: Color(0xFF36C9C9),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Puntos',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '350',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            // Acción al presionar "Editar perfil"
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF36C9C9),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Editar perfil',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
