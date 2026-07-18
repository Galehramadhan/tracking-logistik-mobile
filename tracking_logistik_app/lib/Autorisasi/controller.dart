import 'package:flutter/material.dart';

// 1. Controller mewarisi ChangeNotifier agar bisa memberi sinyal ke UI
class AuthController extends ChangeNotifier {
  
  // 2. Variabel private (ada underscore) agar data tidak bisa diubah sembarangan dari luar
  String _userRole = ''; 

  // 3. Getter untuk membaca isi variabel _userRole dengan aman
  String get userRole => _userRole;

  // 4. Fungsi utama yang akan dipanggil saat tombol "Masuk" ditekan di layar
  void login(String username, String password) {
    
    // (Di masa depan, baris ini diganti dengan kode tembak ke API/Database)
    // Simulasi logika bisnis:
    if (username == 'supir1') {
      _userRole = 'supir';
    } else if (username == 'bos') {
      _userRole = 'admin';
    } else {
      _userRole = 'unknown';
    }

    // 5. Memberi tahu UI bahwa data sudah berubah dan layar harus diperbarui
    notifyListeners(); 
  }
}