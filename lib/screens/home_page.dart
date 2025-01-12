import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Untuk melacak tab yang dipilih
  String userName = "Admin"; // Contoh nama user
  String userRole = "Administrator"; // Contoh role user

  // Fungsi navigasi berdasarkan tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigasi berdasarkan index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/absen'); // Menu Absen
        break;
      case 1:
        Navigator.pushNamed(context, '/history'); // Riwayat Absensi
        break;
      case 2:
        Navigator.pushNamed(context, '/user_info'); // User Information
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Absensi"),
      ),
      body: Column(
        children: [
          // Header dengan Card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Foto profil
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: const AssetImage(
                        'assets/images/ubsi.png', // Ganti dengan path gambar Anda
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Welcome message dan role
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, $userName",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Role: $userRole",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Isi konten lainnya
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pilih menu di bawah",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Tab yang dipilih
        onTap: _onItemTapped, // Fungsi navigasi saat tab dipilih
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: "Menu Absen",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Riwayat Absensi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "User Info",
          ),
        ],
      ),
    );
  }
}
