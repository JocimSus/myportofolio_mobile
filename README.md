# portfolio_mobile

Aplikasi mobile portofolio pribadi berbasis Flutter, dikerjakan untuk mata kuliah
Pemrograman Berbasis Platform (CSGE602022) Fakultas Ilmu Komputer Universitas
Indonesia, Semester Gasal 2026/2027. Proyek ini melanjutkan rangkaian Tutorial dan
Individual Assignment mingguan, dimulai dari Tutorial 08 (setup proyek Flutter &
struktur dasar widget).

## Deskripsi Proyek

Aplikasi ini menampilkan halaman utama portofolio berisi:

- 3 `InfoCard` (NPM, Name, Class) yang menampilkan identitas pemilik portofolio.
- 4 `ItemCard` (Lihat Proyek, Tambah Proyek, Tambah Pengalaman, Logout) sebagai
  tombol aksi dengan warna latar berbeda-beda dan `SnackBar` interaktif saat
  ditekan. Kartu **Tambah Proyek** dan **Tambah Pengalaman** membuka halaman
  formulir masing-masing lewat `Navigator.push()`.
- Drawer kiri (`LeftDrawer`) dengan opsi **Home**, **Add Project**, dan
  **Add Experience** yang dipakai bersama oleh halaman utama dan kedua halaman
  formulir.

Halaman formulir:

- **Add Project Form** (`lib/screens/project_form.dart`, Tutorial 09): nama,
  deskripsi, kategori, teknologi, dan tautan proyek dengan validasi dasar.
- **Add Experience Form** (`lib/screens/experience_form.dart`, Tugas 8):
  meniru model `Experience` pada portofolio web (judul, deskripsi, kategori,
  thumbnail URL, tanggal mulai/selesai) dengan `showDatePicker()`, validasi
  format URL, validasi urutan tanggal, serta saklar bonus "Sedang berlangsung"
  yang menonaktifkan tanggal selesai. Setelah validasi lolos, ringkasan isian
  ditampilkan dalam `AlertDialog`.

Struktur kode memisahkan `main.dart` (bootstrap aplikasi, `MyApp`) dari
`lib/screens/` (halaman `MyHomePage`, `ProjectFormPage`, `ExperienceFormPage`)
dan `lib/widgets/` (`LeftDrawer`, `ItemCard`), sesuai dengan materi Tutorial
08–09.

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

### Tugas 8

1. `Navigator.push()` menumpuk route baru di atas route yang sedang aktif, sehingga halaman sebelumnya tetap ada di stack dan pengguna bisa kembali dengan tombol back. `Navigator.pushReplacement()` mengganti route yang sedang aktif dengan route baru, sehingga halaman lama dihapus dari stack dan tidak bisa dikembalikan dengan tombol back. `Navigator.pop()` mengeluarkan route teratas dari stack dan mengembalikan pengguna ke halaman di bawahnya. Pada proyek ini, kartu aksi "Tambah Pengalaman" (dan "Tambah Proyek") membuka formulir dengan `Navigator.push()` agar pengguna masih bisa kembali ke halaman utama lewat tombol back perangkat. Opsi **Home** di drawer memanggil `Navigator.pushReplacement()` menuju `MyHomePage`, sehingga halaman formulir yang sedang terbuka digantikan oleh halaman utama dan stack tidak menumpuk halaman formulir bekas.
2. `Scaffold` memberi kerangka halaman yang sama di semua layar (AppBar di atas, drawer di kiri, body di tengah), sehingga setiap halaman baru otomatis punya struktur yang seragam. `AppBar` menampilkan judul dan tombol hamburger di posisi yang konsisten, sementara `Drawer` yang sama (`LeftDrawer`) dipasang di halaman utama, formulir proyek, dan formulir pengalaman sehingga navigasi selalu tersedia dari mana pun. Contoh penggunaan warna tema di lebih dari satu halaman: warna indigo (seed `ColorScheme.fromSeed(seedColor: Colors.indigo)`) dipakai pada `AppBar` halaman utama (`Theme.of(context).colorScheme.primary`), `AppBar` kedua halaman formulir, header `DrawerHeader`, dan tombol **Save**; warna sekunder amber dipakai pada saklar "Sedang berlangsung".
3. Formulir disusun sebagai `Column` di dalam `SingleChildScrollView` dengan setiap input dibungkus `Padding`. `Column` membuat input tersusun vertikal berurutan seperti formulir pada umumnya, `Padding` dan `SizedBox` berperan sebagai widget pengatur jarak agar antar-input ada ruang napas dan label tidak saling menempel. `SingleChildScrollView` berperan sebagai widget penggulir: ketika ruang layar terbatas (layar sempit atau papan ketik muncul dan memakan setengah layar), konten yang tidak muat bisa digulir sehingga semua input dan tombol **Save** tetap dapat dijangkau, alih-alih terpotong atau menyebabkan overflow error.
4. `GlobalKey<FormState>` adalah kunci yang menghubungkan widget `Form` dengan state-nya, sehingga dari luar (misalnya tombol **Save**) kita bisa mengakses `_formKey.currentState` untuk memvalidasi atau mereset seluruh formulir. `validator` adalah fungsi per-field yang menerima nilai input dan mengembalikan pesan kesalahan (atau `null` jika valid). `validate()` menjalankan semua `validator` sekaligus saat tombol **Save** ditekan; jika ada yang mengembalikan pesan, pesan itu ditampilkan di bawah field terkait dan `validate()` mengembalikan `false` sehingga dialog ringkasan tidak dimunculkan. Contoh nilai yang ditolak: judul pengalaman berisi `"   "` (hanya spasi) ditolak oleh `value.trim().isEmpty`, dan tanggal selesai yang lebih awal dari tanggal mulai ditolak oleh pemeriksaan `isBefore`. Memilih jenis input atau papan ketik saja (misalnya `keyboardType: TextInputType.url`) belum cukup karena papan ketik hanya menyarankan tata letak tombol, tidak memaksa isi yang benar — pengguna tetap bisa mengetik teks sembarang, mengosongkan field wajib, atau menempel nilai yang salah, sehingga pemeriksaan di `validator` tetap diperlukan.

#### AI Disclosure

Tools yang digunakan: Claude Code (Fable 5).
Pada Individual Assignment 8, AI agent ini digunakan untuk:

- Membaca ketentuan tugas dari berkas PDF soal dan mengekstraknya menjadi checklist implementasi, lalu memetakan field formulir baru terhadap model `Experience` yang sudah ada di portofolio web Django (judul, deskripsi, kategori, thumbnail URL, tanggal mulai/selesai) agar konsisten antar-platform.
- Menulis kerangka `ExperienceFormPage` mengikuti konvensi `ProjectFormPage` dari Tutorial 09 (struktur `Form` + `GlobalKey<FormState>`, `Padding`, `OutlineInputBorder`), termasuk logika `showDatePicker()`, validasi URL dengan `Uri.tryParse`, validasi urutan tanggal, dan saklar bonus "Sedang berlangsung".
- Menambahkan kartu aksi dan opsi drawer baru mengikuti pola navigasi yang sudah ada, serta menjalankan `flutter analyze` sampai bersih tanpa temuan.

Bagian yang tetap dikerjakan manual: pemilihan bagian portofolio (Pengalaman) dan fitur bonus diputuskan sendiri dari opsi yang dibahas bersama AI; pengujian alur di Chrome (buka formulir dari kartu dan drawer, submit input valid/tidak valid, navigasi Home) dilakukan langsung. Jawaban reflektif ditinjau dan disesuaikan dengan pemahaman sendiri sebelum dikumpulkan.

Keterbatasan AI: AI memverifikasi lewat `flutter analyze` yang hanya menangkap kesalahan statis, bukan perilaku runtime — misalnya posisi dialog, perilaku date picker, dan keterjangkauan tombol **Save** saat papan ketik tampil tetap harus dicek manual dengan `flutter run` di Chrome dan di layar selebar ponsel.