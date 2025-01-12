import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart'; // Import QuickAlert package
import '../services/database_helper.dart';
import '../models/history_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Absensi'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final history = await DatabaseHelper.instance.getHistory();

              if (history.isEmpty) {
                // Show alert if there are no records to delete using QuickAlert
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.info,
                  title: 'Tidak Ada Data',
                  text: 'Riwayat absensi kosong, tidak ada yang dapat dihapus.',
                  confirmBtnText: 'OK',
                );
              } else {
                // Show a confirmation dialog before deleting using QuickAlert
                final confirmDelete = await QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  title: 'Konfirmasi Hapus',
                  text: 'Apakah Anda yakin ingin menghapus riwayat absensi?',
                  confirmBtnText: 'Hapus',
                  cancelBtnText: 'Batal',
                  onConfirmBtnTap: () {
                    Navigator.pop(context,
                        true); // Return true when confirm button is tapped
                  },
                  onCancelBtnTap: () {
                    Navigator.pop(context,
                        false); // Return false when cancel button is tapped
                  },
                );

                if (confirmDelete == true) {
                  await DatabaseHelper.instance
                      .deleteAllHistory(); // Call delete method
                  setState(() {}); // Refresh the UI
                }
              }
            },
            child: const Text("Hapus Riwayat Absensi"), // Delete button
          ),
          Expanded(
            child: FutureBuilder<List<HistoryModel>>(
              future: DatabaseHelper.instance.getHistory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Belum ada riwayat absensi'));
                }

                final history = snapshot.data!;
                return ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final item = history[index];
                    return ListTile(
                      title: Text('${item.status} - ${item.datetime}'),
                      subtitle: Text(
                          'Lokasi: Latitude ${item.latitude}, Longitude ${item.longitude}'),
                      leading: Icon(
                        item.status == 'Masuk' ? Icons.login : Icons.logout,
                        color:
                            item.status == 'Masuk' ? Colors.green : Colors.red,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
