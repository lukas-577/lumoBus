import 'package:flutter/material.dart';
import 'package:mibus/models/paradero_model.dart';

class ServicioInfo extends StatelessWidget {
  final Servicio servicio;

  const ServicioInfo({super.key, required this.servicio});

  String getArrivalTimeText(int minArrivalTime, int maxArrivalTime) {
    if (maxArrivalTime <= 5) {
      return 'Menos de 5 min.';
    } else if (minArrivalTime >= 30 ||
        minArrivalTime >= 30 && maxArrivalTime <= 90) {
      return 'Más de 30 minutos';
    } else if (minArrivalTime == 0) {
      const minArrivalTime2 = 1;
      return 'Entre $minArrivalTime2-$maxArrivalTime min.';
    } else {
      return 'Entre $minArrivalTime-$maxArrivalTime min.';
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = servicio.valid ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(
                0, 3), // Cambia la posición de la sombra según sea necesario
          ),
        ],
      ),
      child: ListView(
        shrinkWrap: true,
        physics:
            const ClampingScrollPhysics(), // Para desactivar el scroll de la lista
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.directions_bus,
                color: Colors.white,
                size: 60.0,
              ),
              const SizedBox(width: 5.0),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      servicio.id,
                      style: const TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    if (servicio.valid)
                      Text(
                        servicio.buses.isNotEmpty
                            ? servicio.buses.first.id
                            : '',
                        style: const TextStyle(
                            fontSize: 12.0, color: Colors.white),
                      ),
                    if (servicio.valid)
                      Text(
                        'a ${servicio.buses.isNotEmpty ? servicio.buses.first.metersDistance : ''} mts.',
                        style: const TextStyle(
                            fontSize: 12.0, color: Colors.white),
                      ),
                  ],
                ),
              ),
              if (servicio.valid) const SizedBox(width: 10.0),
              if (servicio.valid)
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: servicio.buses.isNotEmpty
                                    ? getArrivalTimeText(
                                        servicio.buses.first.minArrivalTime,
                                        servicio.buses.first.maxArrivalTime)
                                    : '',
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (!servicio.valid)
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        servicio.statusDescription,
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
