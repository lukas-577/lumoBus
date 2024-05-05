import 'package:flutter/material.dart';
import 'package:mibus/models/paradero_model.dart';
import 'package:mibus/widgets/app_header.dart';
import 'package:mibus/utils/gradient_background.dart';
import 'package:mibus/widgets/servicio_info.dart'; // Importa el widget ServicioInfo

class ParaderoInfo extends StatelessWidget {
  final Paradero paradero;

  ParaderoInfo({required this.paradero});

  @override
  Widget build(BuildContext context) {
    // Ordenar los servicios según su estado de validez (válidos primero)
    List<Servicio> servicios = [...paradero.servicios];
    servicios.sort((a, b) => a.valid == b.valid
        ? 0
        : a.valid
            ? -1
            : 1);

    return Scaffold(
      appBar: AppHeader(),
      body: Stack(
        children: [
          GradientBackground(
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                height: 600,
                padding: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        'Paradero ${paradero.id}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '${paradero.name}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      height: 400, // Altura máxima del contenedor
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey[100]!),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: servicios.map((service) {
                            return ServicioInfo(
                              servicio: service,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
