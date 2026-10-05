import 'package:flutter/material.dart';
import 'shell.dart';

void main() => runApp(const BangunDatarApp());

class BangunDatarApp extends StatelessWidget {
  const BangunDatarApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Bangun Datar dan Perhitungan Waktu',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        ),
        home: const Shell(),
      );
}
