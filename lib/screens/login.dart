import 'package:flutter/material.dart';
import 'package:mibus/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';
import 'package:mibus/firebase/auth.dart';
import 'package:flutter_moving_background/enums/animation_types.dart';
import 'package:flutter_moving_background/flutter_moving_background.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderMi>(context);

    // Construye el widget de usuario

    // Datos del formulario
    Map<String, String> formData = {
      'email': 'luk@gmail.com',
      'password': '123456',
    };

    // Controladores de los campos de texto
    final emailController = TextEditingController(text: formData['email']);
    final passwordController =
        TextEditingController(text: formData['password']);

    Widget buildButtons(BuildContext context, AuthProviderMi authProvider) {
      return Column(
        children: [
          SignInButtonBuilder(
            text: 'Iniciar Sesión',
            icon: Icons.login,
            onPressed: () {
              authProvider.login(
                formData['email']!,
                formData['password']!,
              );
            },
            backgroundColor: Colors.blueGrey.shade500,
          ),
          SignInButtonBuilder(
            text: 'Registrarse',
            icon: Icons.person_add,
            onPressed: () {
              authProvider.signUp(
                formData['email']!,
                formData['password']!,
              );
            },
            backgroundColor: Colors.blueGrey.shade500,
          ),
          SignInButton(
            Buttons.google,
            text: "Sign up with Google",
            onPressed: () {},
          )
        ],
      );
    }

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Stack(
            children: [
              const Positioned.fill(
                child: MovingBackground(
                  duration: Duration(seconds: 10),
                  animationType: AnimationType.translation,
                  backgroundColor: Color.fromRGBO(228, 226, 226, 0.49),
                  circles: [
                    MovingCircle(color: Colors.green),
                    MovingCircle(color: Colors.lightGreen),
                    MovingCircle(color: Colors.lightGreenAccent),
                    MovingCircle(color: Colors.greenAccent),
                    MovingCircle(color: Colors.white12),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(
                          30), // Ajusta el padding según sea necesario
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.6), // Fondo grisaceo transparente
                        border: Border.all(
                            color: Colors.black.withOpacity(0.3)), // Borde gris
                        borderRadius:
                            BorderRadius.circular(10), // Esquinas redondeadas
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            'assets/bus-stop.png', // Reemplaza 'your_image.png' con el nombre de tu imagen
                            height: 120, // Ajusta la altura según sea necesario
                          ),
                          const SizedBox(height: 30),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              filled: true,
                              fillColor: Colors.grey[250],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onChanged: (value) {
                              formData['email'] = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              filled: true,
                              fillColor: Colors.grey[250],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onChanged: (value) {
                              formData['password'] = value;
                            },
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: buildButtons(context, authProvider)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
