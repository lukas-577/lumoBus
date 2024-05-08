import 'package:flutter/material.dart';
import 'package:mibus/utils/gradient_background.dart';
import 'package:mibus/widgets/app_header.dart';
import 'package:mibus/widgets/bottom_nav_bar.dart';
import 'package:mibus/widgets/codigo_paradero_form.dart';
import 'package:mibus/widgets/google_maps.dart';

class CodigoParaderoScreen extends StatefulWidget {
  @override
  _CodigoParaderoScreenState createState() => _CodigoParaderoScreenState();
}

class _CodigoParaderoScreenState extends State<CodigoParaderoScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(),
      body: Stack(
        children: [
          // Fondo de gradiente
          GradientBackground(
            child: Container(),
          ),
          // Contenido de la pantalla (CodigoParaderoForm y GoogleMapWidget)
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Formulario del código de paradero
                CodigoParaderoForm(
                  onSubmit: (codigo) {
                    // Acción cuando se envía el código de paradero
                  },
                ),
                SizedBox(height: 20.0),
                Text(
                  'O busca tu paradero en el mapa:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Mapa de Google
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GoogleMapWidget(),
                  ),
                ),
              ],
            ),
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
