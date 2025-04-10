import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  int wins;
  int losses;
  String? avatarUrl;
  int lives; // Número de vidas restantes
  final int maxLives = 2; // Máximo de vidas (2 por defecto)
  final Color heartColor; // Color de los corazones
  
  User({
    required this.id,
    required this.name,
    this.wins = 0,
    this.losses = 0,
    this.avatarUrl,
    this.lives = 2, // Iniciar con 2 vidas
    required this.heartColor, // Color de los corazones
  });

  void addWin() {
    wins++;
  }

  void addLoss() {
    losses++;
  }
  // Perder una vida
  bool loseLife() {
    if (lives > 0) {
      lives--;
      return lives == 0; // Retorna true si se quedó sin vidas
    }
    return true; // Ya no tiene vidas
  }

  // Reiniciar vidas
  void resetLives() {
    lives = maxLives;
  }
  // Calculate win rate percentage
  double getWinRate() {
    if (wins + losses == 0) return 0.0;
    return (wins / (wins + losses)) * 100;
  }
}