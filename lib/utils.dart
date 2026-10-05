double? parse(String s) => double.tryParse(s.trim().replaceAll(',', '.'));

String fmt(double v) {
  var s = v.toStringAsFixed(2);
  s = s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  return s.replaceAll('.', ',');
}

String two(int n) => n.toString().padLeft(2, '0');

const namaHari = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
  'Minggu',
];
