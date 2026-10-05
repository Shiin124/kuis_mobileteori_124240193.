import 'package:flutter/material.dart';

class AngkaField extends StatelessWidget {
  final TextEditingController c;
  final String label;
  const AngkaField(this.c, this.label, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: c,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
              labelText: label, border: const OutlineInputBorder()),
        ),
      );
}

class HasilCard extends StatelessWidget {
  final List<List<String>>? rows;
  final String? error;
  const HasilCard({super.key, this.rows, this.error});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (error != null) {
      return Card(
        color: cs.errorContainer,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(error!, style: TextStyle(color: cs.onErrorContainer)),
        ),
      );
    }
    if (rows == null) return const SizedBox.shrink();
    return Card(
      color: cs.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: rows!
              .map((r) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(r[0])),
                        const SizedBox(width: 12),
                        Text(r[1],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class HalamanDasar extends StatelessWidget {
  final String judul;
  final List<Widget> children;
  const HalamanDasar(this.judul, this.children, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(judul)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      );
}
