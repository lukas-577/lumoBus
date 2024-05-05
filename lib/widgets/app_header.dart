import 'package:flutter/material.dart';

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
            // Acción cuando se presiona el botón de usuario
          },
        ),
      ],
    );
  }
}
