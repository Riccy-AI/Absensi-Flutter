import 'package:flutter/material.dart'; // Mengimpor paket material design dari Flutter

class CustomButton extends StatelessWidget {
  // Mendefinisikan kelas CustomButton yang merupakan StatelessWidget
  final String text; // Variabel untuk menyimpan teks tombol
  final VoidCallback
      onPressed; // Variabel untuk menyimpan callback saat tombol ditekan

  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed}); // Konstruktor untuk inisialisasi objek CustomButton

  @override
  Widget build(BuildContext context) {
    // Metode build untuk membangun tampilan widget
    return ElevatedButton(
      // Menggunakan ElevatedButton sebagai tombol
      onPressed: onPressed, // Menghubungkan aksi saat tombol ditekan
      child: Text(text), // Menampilkan teks pada tombol
    );
  }
}
