import 'package:flutter/material.dart';
import 'package:mibus/utils/gradient_background.dart';
import 'package:mibus/widgets/app_header.dart';
import 'package:mibus/widgets/bottom_nav_bar.dart';
import 'package:mibus/widgets/google_maps.dart';

class CodigoParaderoScreen extends StatefulWidget {
  const CodigoParaderoScreen({super.key});

  @override
  CodigoParaderoScreenState createState() => CodigoParaderoScreenState();
}

class CodigoParaderoScreenState extends State<CodigoParaderoScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: Stack(
        children: [
          // Fondo de gradiente
          GradientBackground(
            child: Container(),
          ),
          // Mapa de Google
          const Positioned.fill(
            child: GoogleMapWidget(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Navegación a la pantalla correspondiente según el índice seleccionado
          if (index == 1) {
            // Navegar a la pantalla de favoritos
          }
        },
      ),
    );
  }
}
