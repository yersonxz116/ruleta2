import 'dart:math' as math;
import 'user.dart';

class GameState {
  final User user1;
  final User user2;
  
  // Tambor con 6 posiciones (0-5)
  final List<bool> chamber = List.filled(6, false); // false = vacío, true = bala
  int currentChamberPosition = 0; // Posición actual del tambor (0-5)
  
  // Estado del juego
  bool isSpinning = false;
  bool isShooting = false;
  bool gameOver = false;
  
  // Número de balas en el tambor (configurable)
  int numBullets = 1;
  
  // Posición del cañón (0 = apunta a user1, 1 = apunta a user2)
  // Solo hay dos posiciones posibles: 0 grados (arriba, posición 0) y 180 grados (abajo, posición 1)
  int canonPosition = 0;
  
  GameState({
    required this.user1,
    required this.user2,
  }) {
    // La inicialización del tambor se hará cuando el usuario elija el número de balas
  }
  
  // Inicializar el tambor con el número de balas especificado
  void initChamber(int bullets) {
    numBullets = bullets.clamp(1, 5); // Limitar entre 1 y 5 balas
    resetChamber();
  }
  
  // Reiniciar el tambor con el número de balas configurado
  void resetChamber() {
    // Limpiar el tambor
    for (int i = 0; i < chamber.length; i++) {
      chamber[i] = false;
    }
    
    // Colocar balas aleatorias según el número configurado
    final random = math.Random();
    List<int> positions = List.generate(6, (index) => index);
    positions.shuffle(random); // Mezclar posiciones aleatoriamente
    
    // Colocar las balas en posiciones aleatorias
    for (int i = 0; i < numBullets; i++) {
      chamber[positions[i]] = true; // Colocar bala
    }
    
    // Posición inicial aleatoria
    currentChamberPosition = 0; // Siempre empezar desde la posición 0
    
    // Posición inicial del cañón aleatoria (0 o 1)
    canonPosition = random.nextInt(2); // 0 = 0 grados (arriba), 1 = 180 grados (abajo)
  }
  
  // Girar el tambor a una posición aleatoria y el cañón
  void spin() {
    final random = math.Random();
    // Avanzar a una posición aleatoria entre 1 y 5 posiciones
    int steps = random.nextInt(5) + 1;
    currentChamberPosition = (currentChamberPosition + steps) % 6;
    
    // Cambiar aleatoriamente a quién apunta el cañón (solo 2 posiciones)
    canonPosition = random.nextInt(2); // 0 = 0 grados (arriba), 1 = 180 grados (abajo)
  }
  
  // Verificar si hay una bala en la posición actual
  bool hasBulletInCurrentPosition() {
    return chamber[currentChamberPosition];
  }
  
  // Avanzar a la siguiente posición del tambor
  void moveToNextChamberPosition() {
    currentChamberPosition = (currentChamberPosition + 1) % 6;
  }
  
  // Obtener el usuario al que apunta el cañón
  User getTargetUser() {
    return canonPosition == 0 ? user1 : user2;
  }
  
  // Obtener el usuario que no está en la mira
  User getNonTargetUser() {
    return canonPosition == 0 ? user2 : user1;
  }
  
  // Obtener el ángulo de rotación del cañón en radianes
  // En Flutter, RotationTransition usa 'turns' donde 1.0 = 360 grados
  // 0.0 = 0 grados (arriba), 0.5 = 180 grados (abajo)
  double getCanonAngle() {
    return canonPosition == 0 ? 0.0 : 0.5; // 0 grados (arriba) o 180 grados (abajo)
  }
  
  // Disparar el revólver y verificar si hay una bala en la posición actual
  bool shoot() {
    bool hasBullet = hasBulletInCurrentPosition();
    // Después de disparar, avanzamos a la siguiente posición
    moveToNextChamberPosition();
    return hasBullet;
  }
}