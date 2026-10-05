import 'package:flutter/material.dart';

const namaProfil = 'Afwan Ayasyin';
const nimProfil = '124240193';
const ttlProfil = 'Sleman, 14 April 2004';
const hobiProfil = 'Membaca Komik, Ngegame, Dengerin Musik';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Widget item(IconData i, String k, String v) => ListTile(
          leading: Icon(i, color: cs.primary),
          title: Text(k, style: const TextStyle(fontSize: 12)),
          subtitle: Text(v,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface)),
        );
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 8),
        Center(
          child: CircleAvatar(
            radius: 64,
            backgroundColor: cs.primaryContainer,
            child: ClipOval(
              child: Image.asset(
                'assets/foto.jpg',
                width: 128,
                height: 128,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.person, size: 72, color: cs.primary),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
            child: Text(namaProfil,
                style: Theme.of(context).textTheme.titleLarge)),
        const SizedBox(height: 16),
        Card(
          child: Column(children: [
            item(Icons.person, 'Nama', namaProfil),
            item(Icons.badge, 'NIM', nimProfil),
            item(Icons.cake, 'Tempat, tanggal lahir', ttlProfil),
            item(Icons.favorite, 'Hobi', hobiProfil),
          ]),
        ),
      ],
    );
  }
}
