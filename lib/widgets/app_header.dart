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
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('MiBus'),
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
    );
  }
}
