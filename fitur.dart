import 'data.dart';
import 'input.dart';

// ============================================================
// Fungsi bantu
// ============================================================

/// Mencari mata kuliah berdasarkan kode. Mengembalikan null jika tidak ada.
Map<String, dynamic>? cariByKode(String kode) {
  for (final matkul in daftarMatkul) {
    if (matkul['kode'] == kode) return matkul;
  }
  return null;
}

/// Mencetak satu baris data mata kuliah.
void cetakMatkul(Map<String, dynamic> matkul) {
  final hari = matkul['hari'] as Hari;
  print(
    '${matkul['kode']} | ${matkul['nama']} | ${matkul['sks']} SKS | '
    '${hari.name} ${matkul['mulai']}-${matkul['selesai']}',
  );
}

/// Menjumlahkan SKS semua mata kuliah di KRS.
int hitungTotalSks() {
  var total = 0;
  for (final kode in krs) {
    total += cariByKode(kode)!['sks'] as int;
  }
  return total;
}

/// Meminta pengguna memilih hari.
Hari bacaHari() {
  final pilihan = bacaInt(
    'Hari (1=senin, 2=selasa, 3=rabu, 4=kamis, 5=jumat)',
    min: 1,
    max: 5,
  );
  return switch (pilihan) {
    1 => Hari.senin,
    2 => Hari.selasa,
    3 => Hari.rabu,
    4 => Hari.kamis,
    _ => Hari.jumat,
  };
}

// ============================================================
// Fitur yang sudah jadi
// ============================================================

/// Menu 1: menampilkan semua mata kuliah yang ditawarkan.
void tampilkanMatkul() {
  print('\n=== Mata Kuliah Ditawarkan ===');
  for (final matkul in daftarMatkul) {
    cetakMatkul(matkul);
  }
}

/// Menu 2: mengambil mata kuliah ke KRS.
void ambilMatkul() {
  print('\n=== Ambil Mata Kuliah ===');
  final kode = bacaTeks('Kode mata kuliah').toUpperCase();
  final matkul = cariByKode(kode);
  if (matkul == null) {
    print('Mata kuliah $kode tidak ditemukan.');
    return;
  }
  if (krs.contains(kode)) {
    print('${matkul['nama']} sudah ada di KRS.');
    return;
  }
  final batas = hitungBatasSks(ipk);
  final sksBaru = hitungTotalSks() + (matkul['sks'] as int);
  if (sksBaru > batas) {
    print('Gagal: total SKS menjadi $sksBaru, batas SKS Anda $batas.');
    return;
  }
  final bentrok = cariBentrok(matkul);
  if (bentrok != null) {
    print('Gagal: jadwal bentrok dengan ${bentrok['nama']}.');
    return;
  }
  krs.add(kode);
  print('${matkul['nama']} berhasil diambil.');
}

/// Menu 3: menampilkan isi KRS dan total SKS.
void tampilkanKrs() {
  print('\n=== KRS Saya ===');
  if (krs.isEmpty) {
    print('KRS masih kosong.');
    return;
  }
  for (final kode in krs) {
    cetakMatkul(cariByKode(kode)!);
  }
  print('Total SKS: ${hitungTotalSks()} dari batas ${hitungBatasSks(ipk)}');
}

// ============================================================
// Fitur pilihan (pilih minimal 3, lihat README.md)
// ============================================================

/// Menu 4 [Mudah]: menghapus mata kuliah dari KRS.
void dropMatkul() {
  // Tampilkan pesan jika kode tersebut tidak ada di KRS.
  print('\n=== Drop Mata Kuliah ===');

  final kode = bacaTeks('Kode mata kuliah').toUpperCase();

  if (!krs.contains(kode)) {
    print('Mata kuliah $kode tidak ada di KRS.');
    return;
  }

  krs.remove(kode);
  print('Mata kuliah $kode berhasil di-drop.');
}

/// Menu 5 [Mudah]: menampilkan mata kuliah yang ditawarkan pada satu hari.
void tampilkanMatkulPerHari() {
  // daftarMatkul pada hari tersebut.
  print('\n=== Mata Kuliah per Hari ===');

  final hariDipilih = bacaHari();
  var ditemukan = false;

  for (final matkul in daftarMatkul) {
    if (matkul['hari'] == hariDipilih) {
      cetakMatkul(matkul);
      ditemukan = true;
    }
  }

  if (!ditemukan) {
    print('Tidak ada mata kuliah pada hari ${hariDipilih.name}.');
  }
}

/// [Sedang] Menentukan batas SKS berdasarkan IPK.
///
/// Fungsi ini sudah dipakai di menu 2 dan 3. Selama belum dibuat, batasnya
/// selalu batasSksDefault.
int hitungBatasSks(double ipk) {
  if (ipk >= 3.00) {
    return 24;
  } else if (ipk >= 2.50) {
    return 21;
  } else if (ipk >= 2.00) {
    return 18;
  } else {
    return 15;
  }
}

/// Menu 6 [Sedang]: menampilkan jadwal kuliah dari KRS, dikelompokkan per hari.
void tampilkanJadwal() {
  // pada hari itu beserta jamnya. Hari tanpa kuliah tidak perlu ditampilkan.
  print('\n=== Jadwal Kuliah Saya ===');

  if (krs.isEmpty) {
    print('KRS masih kosong.');
    return;
  }

  for (final hari in Hari.values) {
    final matkulHari = daftarMatkul.where((matkul) {
      return krs.contains(matkul['kode']) &&
      matkul['hari'] == hari;
    }).toList();

    if (matkulHari.isEmpty) {
      continue;
    }

    matkulHari.sort((a, b) {
      return (a['mulai'] as int)
          .compareTo(b['mulai'] as int);
    });

    print('\n${hari.name}:');

    for (final matkul in matkulHari) {
      print(
        ' ${matkul['mulai']}-${matkul['selesai']} '
        '${matkul['nama']}',
      );
    }
  }
}

/// [Sulit] Mencari mata kuliah di KRS yang jadwalnya bentrok dengan [baru].
///
/// Fungsi ini sudah dipakai di menu 2. Selama belum dibuat, tidak pernah ada
/// jadwal bentrok.
Map<String, dynamic>? cariBentrok(Map<String, dynamic> baru) {
  for (final kode in krs) {
    final matkulLama = cariByKode(kode)!;

    if (matkulLama['hari'] != baru['hari']) {
      continue;
    }

    final mulaiLama = matkulLama['mulai'] as int;
    final selesaiLama = matkulLama['selesai'] as int;
    final mulaiBaru = baru['mulai'] as int;
    final selesaiBaru = baru['selesai'] as int;

    if (mulaiBaru < selesaiLama &&
        selesaiBaru > mulaiLama) {
      return matkulLama;
    }
  }

  return null;
}

/// Menu 7 [Sulit]: mencetak KRS lengkap dengan identitas mahasiswa.
void cetakKrsLengkap() {
  print('\n=== KRS Lengkap ===');
  print('Nama: $namaMahasiswa');
  print('Nim: $nimMahasiswa');
  print('Ipk: $ipk');

  final batas = hitungBatasSks(ipk);
  print('Batas Sks: $batas');

  if (krs.isEmpty) {
    print('KRS masih kosong.');
    print('Total sks: 0');
    print('Sisa SKS: $batas');
    return;
  }

  print('\nDaftar mata Kuliah:');
  var nomor = 1;

  for (final kode in krs) {
    final matkul = cariByKode(kode)!;
    final hari = matkul['hari'].toString().split('.').last;

    print(
      '$nomor. ${matkul['kode']} | ${matkul['nama']} | '
      '${matkul['sks']} SKS | $hari '
      '${matkul['mulai']}-${matkul['selesai']}',
    );
    nomor++;
  }
  
  final total = hitungTotalSks();
  print('\nTotal SKS: $total');
  print('Sisa SKS: ${batas - total}');
}