import 'dart:convert'; // Package untuk mengubah data menjadi JSON (jsonEncode) dan sebaliknya (jsonDecode).
import 'package:shared_preferences/shared_preferences.dart'; // Package utama untuk penyimpanan lokal.

class StorageService {
  // Fungsi untuk menyimpan data ke penyimpanan internal
  Future<void> simpanData(List<Map<String, dynamic>> dataKendaraan) async {
    final prefs = await SharedPreferences.getInstance(); // Menginisialisasi akses ke penyimpanan internal HP.
    String dataJson = jsonEncode(dataKendaraan); // Mengubah List<Map> menjadi format teks JSON agar bisa disimpan.
    await prefs.setString('data_kunci', dataJson); // Menyimpan teks JSON tersebut dengan nama kunci 'data_kunci'.
  }

  // Fungsi untuk memanggil/membaca data dari penyimpanan internal
  Future<List<Map<String, dynamic>>> bacaData() async {
    final prefs = await SharedPreferences.getInstance(); // Menginisialisasi akses ke penyimpanan internal HP.
    String? dataJson = prefs.getString('data_kunci'); // Mengambil teks JSON yang tersimpan menggunakan 'data_kunci'.

    if (dataJson != null) { // Mengecek apakah data dengan kunci tersebut ada isinya.
      List<dynamic> dataDecode = jsonDecode(dataJson); // Jika ada, ubah teks JSON kembali menjadi bentuk List bawaan.
      return dataDecode.map((item) => item as Map<String, dynamic>).toList(); // Menyesuaikan format data kembali menjadi List<Map<String, dynamic>>.
    }
    
    return []; // Jika tidak ada data yang tersimpan, kembalikan List kosong agar aplikasi tidak error.
  }
}