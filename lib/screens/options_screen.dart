import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/game_options.dart';

class OptionsScreen extends StatefulWidget {
  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  final GameOptions gameOptions = GameOptions();
  final AudioPlayer audioPlayer = AudioPlayer();

  // Variables locales para manejar el estado
  late String selectedWeapon;
  late bool isDarkMode;
  late double brightness;

  @override
  void initState() {
    super.initState();
    // Inicializamos variables con los valores actuales
    selectedWeapon = gameOptions.selectedWeapon;
    isDarkMode = gameOptions.isDarkMode;
    brightness = gameOptions.brightness;

    // Reproducir audio1
    _playAudio();
  }

  Future<void> _playAudio() async {
    try {
      await audioPlayer.play(AssetSource('audio/audio1.mp3'));
    } catch (e) {
      print('Error al reproducir audio: $e');
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OPCIONES',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        centerTitle: true,
        backgroundColor:
            isDarkMode ? Colors.black.withOpacity(0.8) : Colors.blue.shade700,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isDarkMode
                    ? [Colors.black87, Colors.black45]
                    : [Colors.blue[300]!, Colors.blue[50]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título de la sección de armas
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 15.0),
                  child: Text(
                    "SELECCIONA TU ARMA",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.blue[800],
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                // Sección para cambiar arma
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color:
                            isDarkMode
                                ? Colors.black.withOpacity(0.4)
                                : Colors.blue.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: isDarkMode ? Colors.grey[850] : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:
                                gameOptions.getAvailableWeapons().map((weapon) {
                                  bool isSelected =
                                      selectedWeapon == weapon['path'];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedWeapon = weapon['path']!;
                                      });
                                      // Reproducir un pequeño sonido de selección
                                      audioPlayer.stop();
                                      audioPlayer.play(
                                        AssetSource(weapon['sound']!),
                                      );
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color:
                                            isSelected
                                                ? (isDarkMode
                                                    ? Colors.blue[900]
                                                    : Colors.blue[50])
                                                : Colors.transparent,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color:
                                              isSelected
                                                  ? (isDarkMode
                                                      ? Colors.blue
                                                      : Colors.blue[700]!)
                                                  : Colors.transparent,
                                          width: 3,
                                        ),
                                        boxShadow:
                                            isSelected
                                                ? [
                                                  BoxShadow(
                                                    color:
                                                        isDarkMode
                                                            ? Colors.blue
                                                                .withOpacity(
                                                                  0.3,
                                                                )
                                                            : Colors.blue
                                                                .withOpacity(
                                                                  0.2,
                                                                ),
                                                    blurRadius: 10,
                                                    spreadRadius: 2,
                                                  ),
                                                ]
                                                : [],
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            weapon['path']!,
                                            width: 75,
                                            height: 75,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            weapon['name']!,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  isDarkMode
                                                      ? (isSelected
                                                          ? Colors.white
                                                          : Colors.white70)
                                                      : (isSelected
                                                          ? Colors.blue[800]
                                                          : Colors.black87),
                                              fontWeight:
                                                  isSelected
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Título de la sección de apariencia
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 15.0),
                  child: Text(
                    "APARIENCIA",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.blue[800],
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                // Sección para modo oscuro
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color:
                            isDarkMode
                                ? Colors.black.withOpacity(0.4)
                                : Colors.blue.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: isDarkMode ? Colors.grey[850] : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                                color: isDarkMode ? Colors.amber : Colors.amber,
                                size: 30,
                              ),
                              SizedBox(width: 15),
                              Text(
                                'Modo Oscuro',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isDarkMode
                                          ? Colors.white
                                          : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Switch(
                              value: isDarkMode,
                              activeColor: Colors.blue,
                              activeTrackColor: Colors.blue.withOpacity(0.5),
                              inactiveThumbColor: Colors.grey[300],
                              inactiveTrackColor: Colors.grey.withOpacity(0.5),
                              onChanged: (value) {
                                setState(() {
                                  isDarkMode = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Sección para brillo
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color:
                            isDarkMode
                                ? Colors.black.withOpacity(0.4)
                                : Colors.blue.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: isDarkMode ? Colors.grey[850] : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.brightness_6,
                                color:
                                    isDarkMode
                                        ? Colors.white70
                                        : Colors.blue[700],
                                size: 30,
                              ),
                              SizedBox(width: 15),
                              Text(
                                'Brillo',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isDarkMode
                                          ? Colors.white
                                          : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Icon(
                                Icons.brightness_low,
                                color:
                                    isDarkMode
                                        ? Colors.white70
                                        : Colors.black54,
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    activeTrackColor: Colors.blue,
                                    inactiveTrackColor:
                                        isDarkMode
                                            ? Colors.grey[700]
                                            : Colors.grey[300],
                                    thumbColor: Colors.blue,
                                    overlayColor: Colors.blue.withOpacity(0.2),
                                    thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 10.0,
                                    ),
                                    overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 20.0,
                                    ),
                                  ),
                                  child: Slider(
                                    value: brightness,
                                    min: 0.5,
                                    max: 1.5,
                                    divisions: 10,
                                    onChanged: (value) {
                                      setState(() {
                                        brightness = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.brightness_high,
                                color:
                                    isDarkMode
                                        ? Colors.white70
                                        : Colors.black54,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40),

                // Botón guardar
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Guardamos los cambios en el singleton
                        gameOptions.selectedWeapon = selectedWeapon;
                        gameOptions.isDarkMode = isDarkMode;
                        gameOptions.brightness = brightness;

                        // Notificamos a la pantalla principal que debe actualizarse
                        Navigator.pop(context, true);
                      },
                      child: Text(
                        'GUARDAR',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
