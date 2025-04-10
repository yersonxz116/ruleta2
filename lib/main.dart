import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'models/user.dart';
import 'models/game_options.dart';
import 'screens/game_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/options_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GameOptions gameOptions = GameOptions();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ruleta Rusa',
      theme: gameOptions.getTheme(),
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Usuarios predefinidos
  final User user1 = User(
    id: '1',
    name: 'Usuario 1',
    wins: 0,
    losses: 0,
    avatarUrl: null,
    lives: 2,
    heartColor: Colors.red,
  );

  final User user2 = User(
    id: '2',
    name: 'Usuario 2',
    wins: 0,
    losses: 0,
    avatarUrl: null,
    lives: 2,
    heartColor: Colors.blue,
  );

  final AudioPlayer audioPlayer = AudioPlayer();
  final GameOptions gameOptions = GameOptions();

  @override
  void initState() {
    super.initState();
    _playBackgroundMusic();
  }

  Future<void> _playBackgroundMusic() async {
    try {
      await audioPlayer.setReleaseMode(ReleaseMode.loop);
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/portada.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   'RULETA RUSA',
              //   style: TextStyle(
              //     fontSize: 48,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white,
              //     shadows: [
              //       Shadow(
              //         blurRadius: 10.0,
              //         color: Colors.black,
              //         offset: Offset(5.0, 5.0),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 40),
              Image.asset(gameOptions.selectedWeapon, width: 180, height: 180),
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  _showBulletsDialog(context);
                },
                child: Text('JUGAR', style: TextStyle(fontSize: 24)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Ahora navegamos a la pantalla de opciones en lugar de mostrar el diálogo
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OptionsScreen()),
                  );

                  if (result == true) {
                    setState(() {
                      // Actualizar la UI con las nuevas opciones
                    });
                  }
                },
                child: Text('OPCIONES', style: TextStyle(fontSize: 24)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: user1),
                        ),
                      );
                    },
                    child: Text('Perfil Usuario 1'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(user: user2),
                        ),
                      );
                    },
                    child: Text('Perfil Usuario 2'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBulletsDialog(BuildContext context) {
    int selectedBullets = 1;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: gameOptions.isDarkMode ? Colors.grey[850] : null,
              title: Text(
                'Selecciona la cantidad de balas',
                style: TextStyle(
                  color: gameOptions.isDarkMode ? Colors.white : null,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Número de balas: $selectedBullets',
                    style: TextStyle(
                      color: gameOptions.isDarkMode ? Colors.white : null,
                    ),
                  ),
                  Slider(
                    value: selectedBullets.toDouble(),
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: selectedBullets.toString(),
                    onChanged: (double value) {
                      setState(() {
                        selectedBullets = value.toInt();
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      color:
                          gameOptions.isDarkMode
                              ? Colors.lightBlueAccent
                              : null,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => GameScreen(
                              user1: user1,
                              user2: user2,
                              bullets: selectedBullets,
                            ),
                      ),
                    );
                  },
                  child: Text('Comenzar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
