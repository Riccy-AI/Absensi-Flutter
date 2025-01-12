import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Logout"),
          content: const Text("Apakah Anda yakin ingin logout?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
                Navigator.pushReplacementNamed(
                    context, '/login'); // Navigasi ke login
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informasi Pengguna"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              "Nama: Admin",
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              "Email: admin@example.com",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const Text(
              "Role: Administrator",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _showLogoutConfirmation(
                  context), // Memanggil fungsi konfirmasi logout
              child: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Warna tombol merah
              ),
            ),
          ],
        ),
      ),
    );
  }
}
