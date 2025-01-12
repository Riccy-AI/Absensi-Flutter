import 'package:flutter/material.dart'; // Mengimpor paket material design dari Flutter.
import 'package:geolocator/geolocator.dart'; // Mengimpor Geolocator untuk mendapatkan lokasi.
import 'package:quickalert/quickalert.dart'; // Import QuickAlert package
import '../services/database_helper.dart'; // Mengimpor helper untuk mengelola database.
import '../models/history_model.dart'; // Mengimpor model untuk riwayat absen.
import '../services/location_service.dart'; // Import LocationService for location retrieval

class AbsenPage extends StatefulWidget {
  // Kelas untuk halaman absen.
  const AbsenPage({super.key}); // Konstruktor untuk AbsenPage.

  @override
  _AbsenPageState createState() =>
      _AbsenPageState(); // Membuat state untuk halaman absen.
}

class _AbsenPageState extends State<AbsenPage> {
  bool _isLoading =
      false; // Status loading untuk menampilkan indikator loading.

  Future<void> _absen(String status) async {
    // Metode untuk absen.
    setState(() {
      _isLoading = true; // Mengubah status loading menjadi true.
    });

    try {
      // Mendapatkan lokasi saat ini
      Position position = await LocationService
          .getCurrentPosition(); // Mengambil posisi saat ini.
      print(
          'Position: ${position.latitude}, ${position.longitude}'); // Debugging
      print('Status: $status'); // Log the status being recorded

      // Membuat model untuk menyimpan riwayat absen
      final history = HistoryModel(
        datetime: DateTime.now().toString(), // Waktu absen.
        latitude: position.latitude.toString(), // Latitude lokasi.
        longitude: position.longitude.toString(), // Longitude lokasi.
        status: status, // St
      );

      // Simpan ke database
      await DatabaseHelper.instance
          .insertHistory(history); // Menyimpan riwayat ke database.
      print("History inserted: ${history.toMap()}"); // Log the inserted history
      print("Inserting history into database..."); // Debugging

      // Print the contents of the history table
      await DatabaseHelper.instance
          .printHistory(); // Log the contents of the history table

      // Show success animation
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Absen Berhasil',
        text: 'Absen $status berhasil!',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Gagal absen $status: ${e.toString()}')), // Menampilkan pesan kesalahan.
      );
    } finally {
      setState(() {
        _isLoading = false; // Mengubah status loading menjadi false.
      });
    }
  }

  Future<void> _showConfirmationDialog(String status) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Absen $status'),
        content: Text('Apakah Anda yakin ingin absen $status?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya'),
          ),
        ],
      ),
    );

    if (result == true) {
      await _absen(status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absen'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _showConfirmationDialog('Masuk'),
                    child: const Text('Absen Masuk'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _showConfirmationDialog('Keluar'),
                    child: const Text('Absen Keluar'),
                  ),
                ],
              ),
      ),
    );
  }
}
