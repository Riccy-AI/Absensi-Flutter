import 'package:geolocator/geolocator.dart'; // Paket untuk akses lokasi

class LocationService {
  // Mendapatkan posisi saat ini
  static Future<Position> getCurrentPosition() async {
    try {
      return await _getLocation(); // Mengembalikan posisi saat ini
    } catch (e) {
      throw Exception('Gagal mendapatkan posisi: ${e.toString()}');
    }
  }

  // Fungsi privat untuk mendapatkan lokasi
  static Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Memeriksa apakah layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Layanan lokasi tidak aktif. Aktifkan GPS Anda.');
    }

    // Memeriksa apakah aplikasi memiliki izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Izin lokasi ditolak.');
      }
    }

    // Mengambil posisi saat ini dengan akurasi tinggi
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
