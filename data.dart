/// Hari kuliah.
enum Hari { senin, selasa, rabu, kamis, jumat }

/// Identitas mahasiswa yang mengisi KRS.
const String namaMahasiswa = 'Hori';
const String nimMahasiswa = '3042025054';

/// IPK semester sebelumnya, dipakai untuk menentukan batas SKS.
const double ipk = 2.75;

/// Batas SKS jika aturan berdasarkan IPK belum dibuat.
const int batasSksDefault = 24;

/// Data contoh mata kuliah yang ditawarkan. Jam kuliah ditulis sebagai angka
/// jam (8 = 08.00, 13 = 13.00).
final List<Map<String, dynamic>> daftarMatkul = [
  {
    'kode': 'IF201',
    'nama': 'Pemrograman Perangkat Bergerak 1',
    'sks': 4,
    'hari': Hari.senin,
    'mulai': 8,
    'selesai': 12,
  },
  {
    'kode': 'IF202',
    'nama': 'Basis Data Lanjut',
    'sks': 3,
    'hari': Hari.senin,
    'mulai': 13,
    'selesai': 16,
  },
  {
    'kode': 'IF203',
    'nama': 'Jaringan Komputer',
    'sks': 3,
    'hari': Hari.selasa,
    'mulai': 8,
    'selesai': 11,
  },
  {
    'kode': 'IF204',
    'nama': 'Rekayasa Perangkat Lunak',
    'sks': 3,
    'hari': Hari.selasa,
    'mulai': 10,
    'selesai': 13,
  },
  {
    'kode': 'IF205',
    'nama': 'Statistika',
    'sks': 2,
    'hari': Hari.rabu,
    'mulai': 8,
    'selesai': 10,
  },
  {
    'kode': 'IF206',
    'nama': 'Pemrograman Web',
    'sks': 4,
    'hari': Hari.rabu,
    'mulai': 10,
    'selesai': 14,
  },
  {
    'kode': 'IF207',
    'nama': 'Sistem Operasi',
    'sks': 3,
    'hari': Hari.kamis,
    'mulai': 8,
    'selesai': 11,
  },
  {
    'kode': 'IF208',
    'nama': 'Interaksi Manusia dan Komputer',
    'sks': 2,
    'hari': Hari.kamis,
    'mulai': 9,
    'selesai': 11,
  },
  {
    'kode': 'IF209',
    'nama': 'Bahasa Inggris',
    'sks': 2,
    'hari': Hari.jumat,
    'mulai': 8,
    'selesai': 10,
  },
  {
    'kode': 'IF210',
    'nama': 'Kewarganegaraan',
    'sks': 2,
    'hari': Hari.jumat,
    'mulai': 13,
    'selesai': 15,
  },
];

/// Kode mata kuliah yang sudah diambil. Set mencegah kode ganda.
final Set<String> krs = {};
