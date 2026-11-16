# portfolio_mobile

Aplikasi mobile portofolio pribadi berbasis Flutter, dikerjakan untuk mata kuliah
Pemrograman Berbasis Platform (CSGE602022) Fakultas Ilmu Komputer Universitas
Indonesia, Semester Gasal 2026/2027. Proyek ini melanjutkan rangkaian Tutorial dan
Individual Assignment mingguan, dimulai dari Tutorial 08 (setup proyek Flutter &
struktur dasar widget).

## Deskripsi Proyek

Aplikasi ini menampilkan halaman utama portofolio berisi:

- 3 `InfoCard` (NPM, Name, Class) yang menampilkan identitas pemilik portofolio.
- 3 `ItemCard` (Lihat Proyek, Tambah Proyek, Logout) sebagai tombol aksi dengan
  warna latar berbeda-beda dan `SnackBar` interaktif saat ditekan.

Struktur kode memisahkan `main.dart` (bootstrap aplikasi, `MyApp`) dari
`menu.dart` (halaman utama `MyHomePage` beserta widget `InfoCard` dan
`ItemCard`), sesuai dengan materi Tutorial 08.

## Setup Proyek

1. Pastikan Flutter SDK sudah terpasang (`flutter doctor`).
2. Clone repositori ini, lalu jalankan:
   ```bash
   flutter pub get
   flutter run
   ```
3. Untuk memastikan kualitas kode, jalankan:
   ```bash
   flutter analyze
   ```

## Reflections

### Tugas 7

1. Widget tree adalah struktur berbentuk tree yang merepresentasikan seluruh widget pada aplikasi Flutter, mulai dari widget root sampai widget leaf. Hubungan parent-child terbentuk karena setiap widget bisa memiliki satu atau lebih child widget. Parent mengatur layout dan data melalui konstruktor, sementara child merender sesuai batasan. Pada proyek ini misalnya `Scaffold` menjadi parent dari `AppBar` dan `body`, yang di dalamnya berisi `Column`, `Row`, hingga `Card` dan `ItemCard`.
2. Pada proyek ini saya menggunakan `MaterialApp` sebagai root aplikasi, `Scaffold` untuk struktur halaman, serta `Column`, `Row`, `Padding`, `SizedBox`, dan `Center` untuk mengatur layout. Untuk menampilkan data saya memakai `Card` dan `Container` pada `InfoCard`, serta `Material` dan `InkWell` pada `ItemCard` agar warnanya bisa dikustomisasi dan responsif saat disentuh. Selain itu, ada `Icon` dan `Text` untuk menampilkan ikon dan label, `GridView.count` untuk menyusun kartu dalam grid 3 kolom, serta `SnackBar` dan `ScaffoldMessenger` untuk menampilkan notifikasi saat tombol ditekan.
3. `MaterialApp` berfungsi mengatur konfigurasi aplikasi secara keseluruhan, seperti tema warna, judul, dan navigasi antar halaman. Widget ini umumnya dipakai sebagai root widget karena menyediakan konteks yang dibutuhkan widget Material lain di bawahnya, seperti `Theme` dan `Navigator`, lewat `BuildContext`. Tanpa `MaterialApp` di root, widget seperti `Scaffold` atau `Theme.of(context)` tidak ada konfigurasi yang bisa diambil.
4. `StatelessWidget` adalah widget yang tampilannya ditentukan oleh data yang diterima saat dibuat dan tidak bisa berubah sendiri, sedangkan `StatefulWidget` memiliki objek `State` terpisah yang bisa menyimpan data yang berubah seiring waktu dan memicu `setState()` untuk membangun ulang tampilannya. Saya memilih `StatelessWidget` pada `InfoCard`, `ItemCard`, dan `MyHomePage` karena tampilannya hanya bergantung pada data dari luar. `StatefulWidget` baru diperlukan ketika sebuah widget harus mengingat dan memperbarui datanya sendiri, misalnya form input atau counter.
5. `BuildContext` adalah referensi lokasi sebuah widget di dalam widget tree, memungkinkan widget tersebut mengambil data atau layanan dari widget induknya. Pada proyek ini saya menggunakannya melalui `Theme.of(context)` untuk mengambil theme, `MediaQuery.of(context)` untuk ukuran layar, dan `ScaffoldMessenger.of(context)` untuk menampilkan `SnackBar`. Di dalam metode `build`, context ini otomatis disediakan Flutter sesuai posisi widget di tree.
6. Hot reload memasukkan perubahan kode ke aplikasi yang sedang berjalan tanpa mengulang `main()`, sehingga state aplikasi tetap terjaga dan hanya widget tree yang di rebuild dengan sangat cepat dan minimal. Hot restart menjalankan ulang aplikasi dari awal sehingga seluruh state hilang, namun tetap lebih cepat dibanding rebuild penuh. Saya perlu melakukan hot restart ketika mengubah kode di `main()` atau `initState()`, atau saat mengubah struktur class seperti menambah field `color` pada `ItemHomepage`, karena perubahan itu tidak bisa disuntikkan ke state yang sudah berjalan.

#### AI Disclosure

Tools yang digunakan: Claude Code (Sonnet 5).
Pada Individual Assignment 7, AI agent ini digunakan untuk:

- Membaca dan merangkum ketentuan tugas dari berkas PDF soal, lalu memetakannya menjadi checklist terhadap kode `menu.dart`/`main.dart` yang sudah ada dari Tutorial 08.
- Menemukan dan memperbaiki bug `colorScheme: .fromSeed(...)` di `main.dart` (kurang nama kelas `ColorScheme`) yang jika dibiarkan akan membuat kode gagal dikompilasi.

Bagian yang tetap dikerjakan manual: isi data `InfoCard` (NPM, nama, kelas) sudah memuat data asli dan diverifikasi ulang agar sesuai data pemilik portofolio, bukan data contoh Burhan. Jawaban pertanyaan reflektif ditulis berdasarkan pemahaman sendiri terhadap konsep Flutter, dengan AI membantu menyusun kalimat agar lebih terstruktur.

Keterbatasan AI: AI tidak menjalankan aplikasi secara visual di emulator/device asli, sehingga verifikasi tampilan (misalnya kontras warna tombol) tetap perlu dicek langsung saat `flutter run`.