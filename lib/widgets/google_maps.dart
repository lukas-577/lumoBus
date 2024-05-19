import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mibus/models/paradero_model.dart';
import 'package:mibus/services/api_service.dart';
import 'package:mibus/screens/paradero_info_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart'; // Importa la librería EasyLoading
import 'package:mibus/services/location_service.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  GoogleMapWidgetState createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 5.0),
            "assets/parada-de-autobus.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  late GoogleMapController _controller;
  final zoomThreshold = 16.0;
  List<Marker> _markers = [];
  bool _locationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    addCustomIcon();
    _requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(-33.4372, -70.6506),
        zoom: 10,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
      myLocationButtonEnabled: _locationPermissionGranted,
      myLocationEnabled: _locationPermissionGranted,
      onCameraIdle: () async {
        final zoomLevel = await _controller.getZoomLevel();
        if (zoomLevel >= zoomThreshold) {
          _loadMarkers(); // Carga los marcadores si el zoom es suficiente
        } else {
          _markers.clear(); // Limpia los marcadores si el zoom es insuficiente
          setState(() {});
        }
      },
      markers: Set<Marker>.of(_markers),
    );
  }

  Future<void> _loadMarkers() async {
    final LatLngBounds visibleRegion = await _controller.getVisibleRegion();
    EasyLoading.show(); // Muestra el indicador de carga

    String data = await rootBundle.loadString('assets/paraderos.json');
    List<dynamic> paraderos = json.decode(data)['features'];

    final List<Marker> markers = [];

    for (var paradero in paraderos) {
      var properties = paradero['properties'];
      var geometry = paradero['geometry'];

      double lat = geometry['coordinates'][1];
      double lng = geometry['coordinates'][0];

      if (visibleRegion.contains(LatLng(lat, lng))) {
        if (properties['clasificac'] == 'ACTIVO') {
          markers.add(
            Marker(
              markerId: MarkerId(properties['id'].toString()),
              position: LatLng(lat, lng),
              icon: markerIcon,
              infoWindow: InfoWindow(
                title: '${properties['simt']} - ${properties['nombre_ust']}',
                snippet:
                    'Desde: ${properties['desde']} - Hacia: ${properties['hacia']}',
                onTap: () {
                  obtenerDatosParadero(properties['simt'].toString(), context);
                },
              ),
            ),
          );
        }
      }
    }

    //test

    setState(() {
      _markers = markers;
    });

    EasyLoading
        .dismiss(); // Oculta el indicador de carga cuando se completa la carga
  }

  // Función para obtener los datos del paradero
  Future<void> obtenerDatosParadero(
      String codigoParadero, BuildContext context) async {
    try {
      EasyLoading
          .show(); // Muestra el indicador de carga mientras se procesa la solicitud

      final jsonResponse =
          await ApiService.obtenerDatosParadero(codigoParadero);
      final paradero = Paradero.fromJson(jsonResponse);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParaderoInfo(paradero: paradero),
        ),
      );

      EasyLoading
          .dismiss(); // Oculta el indicador de carga cuando se completan los datos
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      EasyLoading
          .dismiss(); // Asegúrate de ocultar el indicador de carga en caso de error
    }
  }

  void _requestLocationPermission() async {
    final bool permissionGranted =
        await LocationService.requestLocationPermission();
    if (permissionGranted) {
      setState(() {
        _locationPermissionGranted = true;
      });
      _moveToUserLocation();
    }
  }

  Future<void> _moveToUserLocation() async {
    final Position? userPosition = await LocationService.getCurrentLocation();
    if (userPosition != null) {
      final LatLng userLatLng =
          LatLng(userPosition.latitude, userPosition.longitude);
      _controller.animateCamera(CameraUpdate.newLatLngZoom(userLatLng, 16));
    }
  }
}
