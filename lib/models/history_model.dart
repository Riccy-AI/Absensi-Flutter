class HistoryModel {
  final int? id; // Primary key, nullable saat membuat data baru
  final String datetime;
  final String latitude;
  final String longitude;
  final String status;

  HistoryModel({
    this.id, // Optional saat insert
    required this.datetime,
    required this.latitude,
    required this.longitude,
    required this.status,
  });

  // Konversi ke Map untuk penyimpanan di database
  Map<String, dynamic> toMap() {
    final map = {
      'datetime': datetime,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
    };
    if (id != null) {
      map['id'] = id as String; // Tambahkan id jika ada
    }
    return map;
  }

  // Konversi dari Map untuk membaca data dari database
  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'], // Baca id dari database
      datetime: map['datetime'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      status: map['status'],
    );
  }
}
