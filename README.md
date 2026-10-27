# UTS: 04 Pengisian KRS

Aplikasi console untuk mengisi Kartu Rencana Studi (KRS): memilih mata kuliah, memeriksa batas SKS, dan melihat jadwal.

Sebagian fitur **sudah jadi**. Tugas kamu adalah **melanjutkan aplikasi ini** dengan membuat fitur yang belum tersedia.

## Ketentuan

- Dikerjakan **individu**.
- Pilih **minimal 3 fitur** dari daftar fitur pilihan di bawah. Tingkatnya bebas.
- Kerjakan di `fitur.dart`, pada fungsi yang bertanda `// TODO`. Hapus baris `print('Fitur belum tersedia.');` setelah fiturnya kamu buat.
- Kamu boleh menambah fungsi bantu sendiri.
- Hasilnya dipresentasikan di **pertemuan #8**: jalankan programnya, tunjukkan fitur yang kamu buat, dan jelaskan kodenya.

## Cara menjalankan

```bash
dart run main.dart
```

Data hanya disimpan di memori. Setelah program ditutup, KRS kembali kosong.

## Struktur file

| File | Isi |
| --- | --- |
| `main.dart` | Menu utama |
| `data.dart` | Enum `Hari`, identitas dan IPK mahasiswa, daftar mata kuliah, dan `krs` |
| `input.dart` | Fungsi membaca input keyboard: `bacaTeks()`, `bacaInt()`, `bacaDouble()` |
| `fitur.dart` | Semua fitur. **Bagian yang kamu kerjakan ada di sini.** |

Mata kuliah yang diambil disimpan di `krs`, sebuah `Set<String>` berisi kode mata kuliah. Jam kuliah ditulis sebagai angka jam: `8` = 08.00, `13` = 13.00.

## Fitur yang sudah jadi

| Menu | Fitur | Fungsi |
| --- | --- | --- |
| 1 | Lihat mata kuliah yang ditawarkan | `tampilkanMatkul()` |
| 2 | Ambil mata kuliah (cek kode, duplikat, batas SKS, bentrok) | `ambilMatkul()` |
| 3 | Lihat KRS dan total SKS | `tampilkanKrs()` |

Pelajari fitur ini dulu. Fungsi bantu `cariByKode()`, `cetakMatkul()`, `hitungTotalSks()`, dan `bacaHari()` bisa kamu pakai lagi.

## Fitur pilihan

| No | Fitur | Tingkat | Fungsi | Catatan |
| --- | --- | --- | --- | --- |
| 1 | Drop mata kuliah (menu 4) | Mudah | `dropMatkul()` | |
| 2 | Mata kuliah per hari (menu 5) | Mudah | `tampilkanMatkulPerHari()` | |
| 3 | Batas SKS berdasarkan IPK | Sedang | `hitungBatasSks()` | Sudah dipanggil di menu 2 dan 3 |
| 4 | Jadwal kuliah saya (menu 6) | Sedang | `tampilkanJadwal()` | |
| 5 | Cek jadwal bentrok | Sulit | `cariBentrok()` | Sudah dipanggil di menu 2 |
| 6 | Cetak KRS lengkap (menu 7) | Sulit | `cetakKrsLengkap()` | |

### Fitur 1 — Drop mata kuliah (Mudah)

Contoh: KRS berisi IF201 dan IF209.

```
=== Drop Mata Kuliah ===
Kode mata kuliah: IF209
Mata kuliah IF209 berhasil di-drop.
```

### Fitur 2 — Mata kuliah per hari (Mudah)

Pakai `bacaHari()` untuk memilih hari.

```
=== Mata Kuliah per Hari ===
Hari (1=senin, 2=selasa, 3=rabu, 4=kamis, 5=jumat): 4
IF207 | Sistem Operasi | 3 SKS | kamis 8-11
IF208 | Interaksi Manusia dan Komputer | 2 SKS | kamis 9-11
```

### Fitur 3 — Batas SKS berdasarkan IPK (Sedang)

Selama fungsi ini belum dibuat, batas SKS selalu 24. Aturannya:

| IPK | Batas SKS |
| --- | --- |
| ≥ 3.00 | 24 |
| ≥ 2.50 | 21 |
| ≥ 2.00 | 18 |
| < 2.00 | 15 |

IPK di data contoh 2.75, jadi batasnya 21 SKS. Contoh setelah mengambil 21 SKS, lalu mencoba mengambil IF210 (2 SKS):

```
=== Ambil Mata Kuliah ===
Kode mata kuliah: IF210
Gagal: total SKS menjadi 23, batas SKS Anda 21.
```

### Fitur 4 — Jadwal kuliah saya (Sedang)

Kelompokkan mata kuliah di KRS per hari, dari senin sampai jumat. Hari tanpa kuliah tidak ditampilkan. Contoh dengan KRS berisi IF201, IF207, IF202, dan IF203:

```
=== Jadwal Kuliah Saya ===
senin:
  8-12 Pemrograman Perangkat Bergerak 1
  13-16 Basis Data Lanjut
selasa:
  8-11 Jaringan Komputer
kamis:
  8-11 Sistem Operasi
```

### Fitur 5 — Cek jadwal bentrok (Sulit)

Dua mata kuliah bentrok jika **harinya sama** dan **jamnya beririsan**. Contoh: 8–11 dan 10–13 bentrok, sedangkan 8–10 dan 10–14 tidak bentrok. Selama fungsi ini belum dibuat, mata kuliah yang bentrok tetap bisa diambil. Contoh dengan KRS berisi IF203 (selasa 8–11), lalu mencoba mengambil IF204 (selasa 10–13):

```
=== Ambil Mata Kuliah ===
Kode mata kuliah: IF204
Gagal: jadwal bentrok dengan Jaringan Komputer.
```

### Fitur 6 — Cetak KRS lengkap (Sulit)

Contoh dengan KRS berisi IF201, IF203, dan IF205 (batas SKS sudah memakai fitur 3):

```
========== KARTU RENCANA STUDI ==========
Nama : Andi
NIM  : 2401001
IPK  : 2.75 (batas 21 SKS)
-----------------------------------------
1. IF201 Pemrograman Perangkat Bergerak 1 (4 SKS) - senin 8-12
2. IF203 Jaringan Komputer (3 SKS) - selasa 8-11
3. IF205 Statistika (2 SKS) - rabu 8-10
-----------------------------------------
Total SKS: 9
Sisa SKS : 12
```
