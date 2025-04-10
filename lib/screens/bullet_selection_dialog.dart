import 'package:flutter/material.dart';

class BulletSelectionDialog extends StatefulWidget {
  final Function(int) onBulletsSelected;

  const BulletSelectionDialog({Key? key, required this.onBulletsSelected}) : super(key: key);

  @override
  _BulletSelectionDialogState createState() => _BulletSelectionDialogState();
}

class _BulletSelectionDialogState extends State<BulletSelectionDialog> {
  int selectedBullets = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Configurar Juego'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Selecciona el nu00famero de balas en el tambor:'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: selectedBullets > 1 ? () {
                  setState(() {
                    selectedBullets--;
                  });
                } : null,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$selectedBullets',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: selectedBullets < 5 ? () {
                  setState(() {
                    selectedBullets++;
                  });
                } : null,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Nivel de dificultad: ${_getDifficultyText(selectedBullets)}',
            style: TextStyle(
              color: _getDifficultyColor(selectedBullets),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onBulletsSelected(selectedBullets);
          },
          child: Text('Comenzar'),
        ),
      ],
    );
  }

  String _getDifficultyText(int bullets) {
    switch (bullets) {
      case 1:
        return 'Fu00e1cil';
      case 2:
        return 'Normal';
      case 3:
        return 'Difu00edcil';
      case 4:
        return 'Muy Difu00edcil';
      case 5:
        return 'Extremo';
      default:
        return 'Normal';
    }
  }

  Color _getDifficultyColor(int bullets) {
    switch (bullets) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.deepOrange;
      case 5:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}