import 'package:flutter/material.dart';
import 'utils.dart';
import 'komponen.dart';

class Zona {
  final String nama;
  final int std;
  final bool dst;
  const Zona(this.nama, this.std, this.dst);
}

const zonaList = [
  Zona('Indonesia (WIB)', 7, false),
  Zona('Malaysia', 8, false),
  Zona('Kanada - Toronto', -5, true),
  Zona('Kanada - Vancouver', -8, true),
];

int _hariMinggu(int year, int month, int n) {
  final first = DateTime.utc(year, month, 1);
  return 1 + (7 - first.weekday) % 7 + 7 * (n - 1);
}

bool isDst(DateTime utc, int std) {
  final start = DateTime.utc(utc.year, 3, _hariMinggu(utc.year, 3, 2), 2 - std);
  final end =
      DateTime.utc(utc.year, 11, _hariMinggu(utc.year, 11, 1), 2 - (std + 1));
  return !utc.isBefore(start) && utc.isBefore(end);
}

int offsetZona(Zona z, DateTime utc) =>
    z.std + ((z.dst && isDst(utc, z.std)) ? 1 : 0);

class WaktuPage extends StatefulWidget {
  const WaktuPage({super.key});

  @override
  State<WaktuPage> createState() => _WaktuPageState();
}

class _WaktuPageState extends State<WaktuPage> {
  int asal = 0;
  DateTime tanggal = DateTime.now();
  TimeOfDay jam = TimeOfDay.now();
  List<List<String>>? hasil;

  void konversi() {
    final z = zonaList[asal];
    final lokal = DateTime.utc(
        tanggal.year, tanggal.month, tanggal.day, jam.hour, jam.minute);
    var utc = lokal.subtract(Duration(hours: z.std));
    if (z.dst && isDst(utc, z.std)) {
      utc = lokal.subtract(Duration(hours: z.std + 1));
    }
    setState(() {
      hasil = zonaList.map((t) {
        final off = offsetZona(t, utc);
        final d = utc.add(Duration(hours: off));
        return [
          '${t.nama} (UTC${off >= 0 ? '+' : ''}$off)',
          '${namaHari[d.weekday - 1].substring(0, 3)}, ${two(d.day)}/${two(d.month)}/${d.year} ${two(d.hour)}:${two(d.minute)}',
        ];
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) => HalamanDasar('Konversi Waktu', [
        const Text('Zona waktu asal'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            for (var i = 0; i < zonaList.length; i++)
              ChoiceChip(
                label: Text(zonaList[i].nama),
                selected: asal == i,
                onSelected: (_) => setState(() => asal = i),
              ),
          ],
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          icon: const Icon(Icons.calendar_today),
          label:
              Text('${two(tanggal.day)}/${two(tanggal.month)}/${tanggal.year}'),
          onPressed: () async {
            final d = await showDatePicker(
                context: context,
                initialDate: tanggal,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100));
            if (d != null) setState(() => tanggal = d);
          },
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          icon: const Icon(Icons.access_time),
          label: Text('${two(jam.hour)}:${two(jam.minute)}'),
          onPressed: () async {
            final t = await showTimePicker(context: context, initialTime: jam);
            if (t != null) setState(() => jam = t);
          },
        ),
        const SizedBox(height: 16),
        FilledButton(onPressed: konversi, child: const Text('Konversi')),
        const SizedBox(height: 12),
        HasilCard(rows: hasil),
      ]);
}
