import 'package:flutter/material.dart';
import 'piramida.dart';
import 'segitiga.dart';
import 'waktu.dart';
import 'hari.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final menus = <(IconData, String, String, Widget)>[
      (
        Icons.change_history,
        'Piramida',
        'Volume & keliling',
        const PiramidaPage()
      ),
      (
        Icons.signal_cellular_4_bar,
        'Segitiga',
        'Luas & keliling',
        const SegitigaPage()
      ),
      (
        Icons.access_time,
        'Konversi Waktu',
        'WIB, Malaysia, Kanada',
        const WaktuPage()
      ),
      (Icons.calendar_month, 'Cek Hari', 'Angka 1–7', const HariPage()),
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Bangun Datar dan Perhitungan Waktu',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 4),
        const Text('Pilih menu untuk mulai menghitung.'),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: menus
              .map((m) => Card(
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => m.$4)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(m.$1,
                              size: 40,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(height: 8),
                          Text(m.$2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(m.$3,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
