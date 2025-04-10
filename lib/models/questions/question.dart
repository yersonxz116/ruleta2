class Question {
  final String text;
  final List<String> options; // Opciones A, B, C, D
  final int correctOptionIndex; // Índice de la opción correcta (0-3)

  Question({
    required this.text,
    required this.options,
    required this.correctOptionIndex,
  }) {
    // Validar que hay 4 opciones (A, B, C, D)
    assert(options.length == 4, 'Debe haber exactamente 4 opciones');
    // Validar que el índice correcto está entre 0 y 3
    assert(correctOptionIndex >= 0 && correctOptionIndex < 4, 
           'El índice correcto debe estar entre 0 y 3');
  }

  // Verificar si una respuesta es correcta
  bool isCorrect(int selectedOptionIndex) {
    return selectedOptionIndex == correctOptionIndex;
  }
}