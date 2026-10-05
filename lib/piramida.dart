// Menu Piramida: volume & keliling (alas persegi).
import 'dart:math';
import 'package:flutter/material.dart';
import 'utils.dart';
import 'komponen.dart';

class PiramidaPage extends StatefulWidget {
  const PiramidaPage({super.key});

  @override
  State<PiramidaPage> createState() => _PiramidaPageState();
}

class _PiramidaPageState extends State<PiramidaPage> {
  final s = TextEditingController(), t = TextEditingController();
  List<List<String>>? hasil;
  String? error;

  void hitung() {
    final a = parse(s.text), h = parse(t.text);
    if (a == null || h == null || a <= 0 || h <= 0) {
      setState(() {
        error = 'Isi sisi alas dan tinggi dengan angka lebih dari 0.';
        hasil = null;
      });
      return;
    }
    final tinggiSisi = sqrt(h * h + (a / 2) * (a / 2));
    setState(() {
      error = null;
      hasil = [
        ['Volume', '${fmt(a * a * h / 3)} cm³'],
        ['Keliling alas', '${fmt(4 * a)} cm'],
        ['Tinggi sisi tegak', '${fmt(tinggiSisi)} cm'],
      ];
    });
  }

  @override
  Widget build(BuildContext context) => HalamanDasar('Piramida', [
        const Text('Piramida dengan alas persegi.'),
        const SizedBox(height: 12),
        AngkaField(s, 'Panjang sisi alas'),
        AngkaField(t, 'Tinggi piramida'),
        FilledButton(onPressed: hitung, child: const Text('Hitung')),
        const SizedBox(height: 12),
        HasilCard(rows: hasil, error: error),
      ]);
}
