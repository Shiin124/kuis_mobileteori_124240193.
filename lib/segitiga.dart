import 'dart:math';
import 'package:flutter/material.dart';
import 'utils.dart';
import 'komponen.dart';

class SegitigaPage extends StatefulWidget {
  const SegitigaPage({super.key});

  @override
  State<SegitigaPage> createState() => _SegitigaPageState();
}

class _SegitigaPageState extends State<SegitigaPage> {
  int tipe = 0;
  final a = TextEditingController(), b = TextEditingController();
  List<List<String>>? hasil;
  String? error;

  static const label = [
    ['Alas (a)', 'sisi miring (b)'],
    ['Panjang sisi (s)', ''],
    ['Alas (a)', 'Tinggi (t)'],
  ];

  void hitung() {
    final x = parse(a.text);
    final y = tipe == 1 ? 1.0 : parse(b.text);
    if (x == null || y == null || x <= 0 || y <= 0) {
      setState(() {
        error = 'Isi semua sisi dengan angka lebih dari 0.';
        hasil = null;
      });
      return;
    }
    late double luas, keliling;
    final extra = <List<String>>[];
    if (tipe == 0) {
      if (2 * y <= x) {
        setState(() {
          error =
              'Segitiga tidak valid: 2 × panjang kaki harus lebih besar dari alas.';
          hasil = null;
        });
        return;
      }
      final h = sqrt(y * y - (x / 2) * (x / 2));
      luas = x * h / 2;
      keliling = x + 2 * y;
      extra.add(['Tinggi', fmt(h)]);
    } else if (tipe == 1) {
      luas = x * x * sqrt(3) / 4;
      keliling = 3 * x;
    } else {
      final c = sqrt(x * x + y * y);
      luas = x * y / 2;
      keliling = x + y + c;
      extra.add(['Sisi miring', fmt(c)]);
    }
    setState(() {
      error = null;
      hasil = [
        ['Luas', '${fmt(luas)} cm²'],
        ['Keliling', '${fmt(keliling)} cm'],
        ...extra,
      ];
    });
  }

  @override
  Widget build(BuildContext context) => HalamanDasar('Segitiga', [
        SegmentedButton<int>(
          segments: const [
            ButtonSegment(value: 0, label: Text('Sama Kaki')),
            ButtonSegment(value: 1, label: Text('Sama Sisi')),
            ButtonSegment(value: 2, label: Text('Siku-siku')),
          ],
          selected: {tipe},
          onSelectionChanged: (v) => setState(() {
            tipe = v.first;
            a.clear();
            b.clear();
            hasil = null;
            error = null;
          }),
        ),
        const SizedBox(height: 16),
        AngkaField(a, label[tipe][0]),
        if (tipe != 1) AngkaField(b, label[tipe][1]),
        FilledButton(onPressed: hitung, child: const Text('Hitung')),
        const SizedBox(height: 12),
        HasilCard(rows: hasil, error: error),
      ]);
}
