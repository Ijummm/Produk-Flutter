# 🛒 Aplikasi Katalog Produk Luxury

Aplikasi manajemen produk (CRUD) berbasis Flutter yang dirancang dengan antarmuka (UI) modern dan mewah. Aplikasi ini terhubung dengan backend menggunakan REST API untuk pengelolaan data secara real-time.

---

## 🌟 Fitur Utama

* **Desain Mewah**: Menggunakan tema warna Cyan & Purple yang elegan.
* **Manajemen Produk (CRUD)**:
    * **Tambah Produk**: Input data produk baru dengan pratinjau gambar otomatis.
    * **Lihat Detail**: Tampilan detail produk yang bersih dan informatif.
    * **Edit Data**: Memperbarui informasi produk yang sudah ada.
    * **Hapus Data**: Menghapus produk dari katalog dengan aman.
* **Pratinjau Gambar Pintar**: Mendukung tampilan gambar melalui **URL Internet** maupun kode **Base64**.
* **Notifikasi Toast**: Memberikan feedback instan setiap kali data berhasil diproses.

---

## 🛠️ Teknologi yang Digunakan

* **Flutter**: Framework utama untuk pengembangan aplikasi.
* **Http**: Untuk komunikasi data dengan Server/API.
* **Fluttertoast**: Untuk menampilkan pesan sukses atau error.
* **Intl**: Untuk pemformatan mata uang (Rupiah).
* **Dart Convert**: Untuk memproses data JSON dan gambar Base64.

---

## 🚀 Cara Menjalankan Aplikasi

1.  **Clone Repositori**
    ```bash
    git clone [https://github.com/username/nama-proyek.git](https://github.com/username/nama-proyek.git)
    ```

2.  **Instal Dependensi**
    ```bash
    flutter pub get
    ```

3.  **Pengaturan API**
    Buka file `lib/models/api.dart` dan sesuaikan `BaseUrl` dengan alamat server atau IP laptop kamu.

4.  **Jalankan Aplikasi**
    ```bash
    flutter run
    ```

---

## 💡 Catatan untuk Pengguna Web

Jika gambar tidak muncul karena masalah keamanan browser (CORS), jalankan aplikasi dengan perintah:

```bash
flutter run -d chrome --web-renderer html
