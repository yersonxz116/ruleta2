import 'package:flutter/material.dart';

class GameOptions {
  // Singleton para mantener las opciones consistentes en toda la app
  static final GameOptions _instance = GameOptions._internal();
  factory GameOptions() => _instance;
  GameOptions._internal();

  // Valores por defecto
  String selectedWeapon = 'assets/img/revolver.png';
  bool isDarkMode = false;
  double brightness = 1.0;

  // Obtiene la lista de armas disponibles con sus sonidos
  List<Map<String, String>> getAvailableWeapons() {
    return [
      {
        'name': 'Revólver',
        'path': 'assets/img/revolver.png',
        'sound': 'audio/revolver.mp3',
      },
      {
        'name': 'Pistola',
        'path': 'assets/img/pistola.png',
        'sound': 'audio/pistola.mp3',
      },
      {'name': '9mm', 'path': 'assets/img/9mm.png', 'sound': 'audio/9mm.mp3'},
    ];
  }

  // Método para obtener el sonido del arma actual
  String getSelectedWeaponSound() {
    for (var weapon in getAvailableWeapons()) {
      if (weapon['path'] == selectedWeapon) {
        return weapon['sound']!;
      }
    }
    // Valor por defecto en caso de no encontrar coincidencia
    return 'audio/revolver.mp3';
  }

  // Método para obtener ThemeData basado en el modo y brillo
  ThemeData getTheme() {
    final Brightness themeBrightness =
        isDarkMode ? Brightness.dark : Brightness.light;

    return ThemeData(
      brightness: themeBrightness,
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        brightness: themeBrightness,
      ).copyWith(brightness: themeBrightness),
    );
  }
}
