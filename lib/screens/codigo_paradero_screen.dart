import 'package:flutter/material.dart';
import 'package:mibus/utils/gradient_background.dart';
import 'package:mibus/widgets/app_header.dart';
import 'package:mibus/widgets/codigo_paradero_form.dart';

class CodigoParaderoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(),
      body: Stack(
        children: [
          // Fondo de gradiente
          GradientBackground(
            child:
                Container(), // Podemos proporcionar cualquier widget como hijo
          ),
          // Contenido de la pantalla (CodigoParaderoForm)
          Padding(
            padding: EdgeInsets.all(30.0),
            child: CodigoParaderoForm(
              onSubmit: (codigo) {
                // Acción cuando se envía el código de paradero
              },
            ),
          ),
        ],
      ),
    );
  }
}
