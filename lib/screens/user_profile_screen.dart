import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de ${user.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: user.avatarUrl != null
                  ? NetworkImage(user.avatarUrl!)
                  : null,
              child: user.avatarUrl == null
                  ? Text(
                      user.name.substring(0, 1).toUpperCase(),
                      style: TextStyle(fontSize: 40),
                    )
                  : null,
            ),
            SizedBox(height: 20),
            Text(
              user.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Mostrar corazones
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < user.maxLives; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(
                      i < user.lives ? Icons.favorite : Icons.favorite_border,
                      color: user.heartColor,
                      size: 30,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            _buildStatCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Estadísticas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SizedBox(height: 10),
            _buildStatRow('Victorias', user.wins.toString()),
            SizedBox(height: 10),
            _buildStatRow('Derrotas', user.losses.toString()),
            SizedBox(height: 10),
            _buildStatRow('Vidas restantes', '${user.lives}/${user.maxLives}'),
            SizedBox(height: 10),
            _buildStatRow(
                'Porcentaje de Victoria', '${user.getWinRate().toStringAsFixed(1)}%'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}