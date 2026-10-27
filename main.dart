import 'fitur.dart';
import 'input.dart';

void main() {
  print('=== Pengisian KRS ===');
  var berjalan = true;

  while (berjalan) {
    print('');
    print('1. Lihat mata kuliah ditawarkan');
    print('2. Ambil mata kuliah');
    print('3. Lihat KRS dan total SKS');
    print('4. Drop mata kuliah            [Mudah]');
    print('5. Mata kuliah per hari        [Mudah]');
    print('6. Jadwal kuliah saya          [Sedang]');
    print('7. Cetak KRS lengkap           [Sulit]');
    print('0. Keluar');

    final pilihan = bacaInt('Pilih menu', min: 0, max: 7);
    switch (pilihan) {
      case 1:
        tampilkanMatkul();
      case 2:
        ambilMatkul();
      case 3:
        tampilkanKrs();
      case 4:
        dropMatkul();
      case 5:
        tampilkanMatkulPerHari();
      case 6:
        tampilkanJadwal();
      case 7:
        cetakKrsLengkap();
      case 0:
        berjalan = false;
    }
  }

  print('Terima kasih.');
}
