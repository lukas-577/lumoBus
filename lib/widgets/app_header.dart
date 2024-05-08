import 'package:flutter/material.dart';
import 'package:mibus/firebase/auth.dart';
import 'package:provider/provider.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('MiBus'),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            // Acción cuando se presiona el botón de notificaciones
          },
        ),
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
          },
        ),
        IconButton(
          icon: Icon(Icons.exit_to_app_rounded),
          onPressed: () {
            // Llamar al método logout() al presionar el botón de persona
            Provider.of<AuthProviderMi>(context, listen: false).logout();
          },
        ),
      ],
    );
  }
}
