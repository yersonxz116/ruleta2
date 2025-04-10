import 'dart:math';
import 'question.dart';

class QuestionRepository {
  // Lista de preguntas predefinidas
  static final List<Question> _questions = [
    Question(
      text: '¿Cuál es la capital de Francia?',
      options: ['Madrid', 'París', 'Roma', 'Berlín'],
      correctOptionIndex: 1,
    ),
    Question(
      text: '¿Cuántos lados tiene un hexágono?',
      options: ['5', '6', '7', '8'],
      correctOptionIndex: 1,
    ),
    Question(
      text: '¿Qué planeta es conocido como el planeta rojo?',
      options: ['Venus', 'Júpiter', 'Marte', 'Saturno'],
      correctOptionIndex: 2,
    ),
    Question(
      text: '¿Cuál es el elemento químico con símbolo H?',
      options: ['Helio', 'Hidrógeno', 'Hierro', 'Hafnio'],
      correctOptionIndex: 1,
    ),
    Question(
      text: '¿En qué año comenzó la Segunda Guerra Mundial?',
      options: ['1939', '1941', '1945', '1938'],
      correctOptionIndex: 0,
    ),
    Question(
      text: '¿Quién pintó La Mona Lisa?',
      options: ['Vincent van Gogh', 'Pablo Picasso', 'Leonardo da Vinci', 'Miguel Ángel'],
      correctOptionIndex: 2,
    ),
    Question(
      text: '¿Cuál es el río más largo del mundo?',
      options: ['Nilo', 'Amazonas', 'Misisipi', 'Yangtsé'],
      correctOptionIndex: 1,
    ),
    Question(
      text: '¿Cuál es el hueso más largo del cuerpo humano?',
      options: ['Fémur', 'Húmero', 'Tibia', 'Radio'],
      correctOptionIndex: 0,
    ),
    Question(
      text: '¿Cuál es el animal terrestre más grande?',
      options: ['Elefante africano', 'Jirafa', 'Hipopótamo', 'Rinoceronte'],
      correctOptionIndex: 0,
    ),
    Question(
      text: '¿Cuál es el metal más caro del mundo?',
      options: ['Oro', 'Platino', 'Rodio', 'Paladio'],
      correctOptionIndex: 2,
    ),
  ];

  // Obtener una pregunta aleatoria
  static Question getRandomQuestion() {
    final random = Random();
    return _questions[random.nextInt(_questions.length)];
  }
}