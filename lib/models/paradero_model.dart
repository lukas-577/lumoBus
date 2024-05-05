class Paradero {
  final String id;
  final String name;
  final int statusCode;
  final String statusDescription;
  final List<Servicio> servicios;

  Paradero({
    required this.id,
    required this.name,
    required this.statusCode,
    required this.statusDescription,
    required this.servicios,
  });

  factory Paradero.fromJson(Map<String, dynamic> json) {
    List<Servicio> serviciosList = [];
    if (json['services'] != null) {
      json['services'].forEach((servicio) {
        serviciosList.add(Servicio.fromJson(servicio));
      });
    }

    return Paradero(
      id: json['id'],
      name: json['name'],
      statusCode: json['status_code'],
      statusDescription: json['status_description'],
      servicios: serviciosList,
    );
  }
}

class Servicio {
  final String id;
  final bool valid;
  final String statusDescription;
  final List<Bus> buses;

  Servicio({
    required this.id,
    required this.valid,
    required this.statusDescription,
    required this.buses,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) {
    List<Bus> busesList = [];
    if (json['buses'] != null) {
      json['buses'].forEach((bus) {
        busesList.add(Bus.fromJson(bus));
      });
    }

    return Servicio(
      id: json['id'],
      valid: json['valid'],
      statusDescription: json['status_description'],
      buses: busesList,
    );
  }
}

class Bus {
  final String id;
  final int metersDistance;
  final int minArrivalTime;
  final int maxArrivalTime;

  Bus({
    required this.id,
    required this.metersDistance,
    required this.minArrivalTime,
    required this.maxArrivalTime,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id'],
      metersDistance: json['meters_distance'],
      minArrivalTime: json['min_arrival_time'],
      maxArrivalTime: json['max_arrival_time'],
    );
  }
}
