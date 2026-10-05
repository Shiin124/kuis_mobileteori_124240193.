import 'package:flutter/material.dart';
import 'utils.dart';
import 'komponen.dart';

class HariPage extends StatefulWidget {
  const HariPage({super.key});

  @override
  State<HariPage> createState() => _HariPageState();
}

class _HariPageState extends State<HariPage> {
  final c = TextEditingController();
  List<List<String>>? hasil;
  String? error;

  void cek() {
    final n = int.tryParse(c.text.trim());
    if (n == null || n < 1) {
      setState(() {
        error = 'Nomor tidak valid. Masukkan bilangan bulat 1 atau lebih.';
        hasil = null;
      });
      return;
    }
    final idx = (n - 1) % 7;
    setState(() {
      error = null;
      hasil = [
        ['Hari ke-$n', namaHari[idx]],
        ['Perhitungan', '($n - 1) mod 7 = $idx'],
      ];
    });
  }

  @override
  Widget build(BuildContext context) => HalamanDasar('Cek Hari', [
        TextField(
          controller: c,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              labelText: 'Masukkan nomor hari (1-7)',
              border: OutlineInputBorder()),
        ),
        const SizedBox(height: 12),
        FilledButton(onPressed: cek, child: const Text('Cek Hari')),
        const SizedBox(height: 12),
        HasilCard(rows: hasil, error: error),
        const SizedBox(height: 12),
        const Text(
            '1 = Senin, 2 = Selasa, 3 = Rabu, 4 = Kamis, 5 = Jumat, 6 = Sabtu, 7 = Minggu'),
      ]);
}
