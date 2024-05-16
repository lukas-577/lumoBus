import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mibus/screens/codigo_paradero_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mibus/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:mibus/firebase/auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<AuthProviderMi>(
      create: (_) => AuthProviderMi(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('MyApp build siendo llamada');
    return MaterialApp(
      title: 'Lumonidy Bus',
      builder: EasyLoading.init(),
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  AuthenticationWrapperState createState() => AuthenticationWrapperState();
}

class AuthenticationWrapperState extends State<AuthenticationWrapper> {
  // Inicializa una instancia de FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProviderMi>(builder: (context, provider, child) {
      // Verifica el estado de autenticación al inicio de la aplicación
      if (_auth.currentUser != null) {
        // Si el usuario está autenticado, muestra la pantalla de inicio
        return const CodigoParaderoScreen();
      } else {
        // Si el usuario no está autenticado, redirige a la pantalla de inicio de sesión
        return const LoginScreen();
      }
    });
  }
}
