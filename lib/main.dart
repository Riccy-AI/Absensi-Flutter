import 'package:flutter/material.dart'; // Mengimpor paket material design dari Flutter
import 'screens/login_page.dart'; // Mengimpor halaman login
import 'screens/home_page.dart'; // Mengimpor halaman utama
import 'screens/absen_page.dart'; // Mengimpor halaman absen
import 'screens/history_page.dart'; // Mengimpor halaman riwayat
import 'screens/user_info.dart'; // Mengimpor halaman user info
import 'services/database_helper.dart'; // Mengimpor helper untuk database
import 'screens/splash_screen.dart'; // Mengimpor halaman splash screen

void main() async {
  // Fungsi utama aplikasi
  WidgetsFlutterBinding
      .ensureInitialized(); // Memastikan binding diinisialisasi
  await DatabaseHelper.instance.database; // Menginisialisasi database
  runApp(
      const MyApp()); // Menjalankan aplikasi dengan MyApp sebagai root widget
}

class MyApp extends StatelessWidget {
  // Mendefinisikan kelas MyApp yang merupakan StatelessWidget
  const MyApp(
      {super.key}); // Konstruktor yang menggunakan super.key untuk mendukung key

  @override
  Widget build(BuildContext context) {
    // Metode build untuk membangun tampilan widget
    return MaterialApp(
      // Menggunakan MaterialApp sebagai aplikasi utama
      title: 'Aplikasi Absensi', // Judul aplikasi
      theme: ThemeData(
          primarySwatch: Colors.blue), // Tema aplikasi dengan warna biru
      initialRoute: '/splash', // Rute awal aplikasi
      routes: {
        // Mendefinisikan rute aplikasi
        '/splash': (context) =>
            const SplashScreen(), // Rute untuk splash screen
        '/login': (context) => const LoginPage(), // Rute untuk halaman login
        '/home': (context) => const HomePage(), // Rute untuk halaman utama
        '/absen': (context) => const AbsenPage(), // Rute untuk halaman absen
        '/history': (context) =>
            const HistoryPage(), // Rute untuk halaman riwayat
        '/user_info': (context) => const UserInfoPage(), // Tambahkan rute baru
      },
    );
  }
}
