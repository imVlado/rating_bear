import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controlador para la animación Rive
  late RiveAnimationController _animationController;
  
  // Estado para controlar la carga del botón
  bool isLoading = false;
  
  // Rating actual seleccionado por el usuario
  double currentRating = 3.0;
  
  // Nombre de la animación actual que se está reproduciendo
  String _currentAnimation = "idle";

  @override
  void initState() {
    super.initState();
    // Inicializar la animación con el estado "idle" (inactivo)
    _animationController = SimpleAnimation('idle');
  }

  /// Método para cambiar la animación del personaje Rive
  /// [newAnimation] - nombre de la nueva animación a reproducir
  void _changeAnimation(String newAnimation) {
    // Evitar cambiar a la misma animación actual (optimización)
    if (_currentAnimation == newAnimation) return;
    
    setState(() {
      _currentAnimation = newAnimation;
      // Crear un nuevo controlador con la animación especificada
      // Esto reinicia la animación cada vez que cambia
      _animationController = SimpleAnimation(newAnimation);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtener las dimensiones de la pantalla para diseño responsive
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      // Evitar que el teclado superponga el contenido
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Contenedor para la animación Rive - ocupa 40% de la altura de la pantalla
                SizedBox(
                  width: size.width,
                  height: size.height * 0.4,
                  child: RiveAnimation.asset(
                    // Ruta del archivo Rive (debe estar en la carpeta assets)
                    'assets/animated_login_character.riv',
                    // Lista de animaciones a reproducir (solo la actual)
                    animations: [_currentAnimation],
                    // Controladores de animación (el actual)
                    controllers: [_animationController],
                    // Escalar la animación para que quepa en el contenedor
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 20),

                // Título principal de la pantalla
                Text(
                  "Enjoying sounter?",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // Subtítulo que pregunta por la calificación
                Text(
                  "with how many stars would you rate us?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // Widget de barras de rating con 5 estrellas
                RatingBar.builder(
                  // Rating inicial de 3 estrellas
                  initialRating: 3,
                  // Rating mínimo permitido (1 estrella)
                  minRating: 1,
                  // Dirección horizontal de las estrellas
                  direction: Axis.horizontal,
                  // Número total de estrellas
                  itemCount: 5,
                  // Espaciado horizontal entre estrellas
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  // Builder para cada estrella individual
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber, // Color amarillo para las estrellas
                  ),
                  // Tamaño grande de las estrellas (70px)
                  itemSize: 70,
                  // Callback que se ejecuta cuando el usuario cambia el rating
                  onRatingUpdate: (rating) {
                    
                    if (rating >= 4) {
                      _changeAnimation("success");
                    } else if (rating <= 2) {
                      _changeAnimation("fail");
                    } else {
                      _changeAnimation("idle");
                    }
                  },
                ),

                const SizedBox(height: 30),

                // Botón principal para enviar la calificación
                SizedBox(
                  width: size.width, // Ancho completo de la pantalla
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // Color morado para el botón
                      backgroundColor: Colors.purple,
                      // Bordes redondeados
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implementar lógica de envío de rating
                    },
                    child: isLoading
                        ? // Mostrar indicador de carga si está cargando
                        const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : // Mostrar texto "Rate" en estado normal
                        const Text(
                            'Rate',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),
                
                // Botón secundario para saltar la calificación
                TextButton(
                  onPressed: () {
                    // TODO: Implementar lógica para saltar la calificación
                  },
                  child: const Text(
                    "NO THANKS",
                    style: TextStyle(
                      color: Colors.purple, // Color morado para coincidir con el tema
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
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