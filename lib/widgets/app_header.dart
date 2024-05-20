import 'package:flutter/material.dart';
import 'package:mibus/firebase/auth.dart';
import 'package:provider/provider.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool isSecondary;

  // Constructor con el parámetro isSecondary, por defecto es false
  const AppHeader({super.key, this.isSecondary = false});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffa1ffce), Color(0xfffaffd1)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/pngwing.com.png', // Ruta de la imagen en los assets
              height: 50, // Ajusta el tamaño de la imagen según tus necesidades
            ),
            const SizedBox(width: 10), // Espacio entre la imagen y el texto
            const Text(
              'Lumo Bus',
              style: TextStyle(
                color: Colors.white, // Ajusta el color del texto
                fontSize: 20, // Ajusta el tamaño del texto
                fontWeight: FontWeight.bold, // Ajusta el peso del texto
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Acción cuando se presiona el botón de notificaciones
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Llamar al método logout() al presionar el botón de persona
              Provider.of<AuthProviderMi>(context, listen: false).logout();
              if (!isSecondary) {
                // Si no es una pantalla secundaria, hacer pop
                Navigator.pop(context);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app_rounded),
            onPressed: () {
              // Llamar al método logout() al presionar el botón de salida
              Provider.of<AuthProviderMi>(context, listen: false).logout();
              if (isSecondary) {
                // Si no es una pantalla secundaria, hacer pop
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
