import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    try {
      // Verifica si los servicios de ubicación están habilitados.
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Los servicios de ubicación están deshabilitados.');
      }

      // Verifica los permisos de ubicación.
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Permisos de ubicación denegados.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Permisos de ubicación denegados permanentemente. No se pueden solicitar permisos.');
      }

      // Obtiene la posición actual del dispositivo.
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener la ubicación: $e');
      }
      return null;
    }
  }

  static Future<bool> requestLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permisos de ubicación denegados.');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error al solicitar permisos de ubicación: $e');
      }
      return false;
    }
  }
}
