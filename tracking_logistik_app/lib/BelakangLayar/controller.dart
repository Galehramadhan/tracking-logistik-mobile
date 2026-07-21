import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Gunakan versi package terbaru (misal: ^2.3.2 ke atas)

enum UserRole { admin, driver, unknown }
enum AuthStatus { initial, loading, success, error }

class AuthController extends ChangeNotifier {
  AuthStatus _status = AuthStatus.initial;
  UserRole _role = UserRole.unknown;
  String _errorMessage = '';

  AuthStatus get status => _status;
  UserRole get role => _role;
  String get errorMessage => _errorMessage;

  // 1. Menggunakan SharedPreferencesAsync (API terbaru, lebih cepat dan tidak memblokir UI)
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<void> cekSesiLogin() async {
    final savedRole = await _prefs.getString('user_role'); // 2. Langsung ambil data secara asinkron tanpa .getInstance()

    // 3. Menggunakan Switch-Case Dart 3 (tanpa perlu menulis 'break' lagi)
    switch (savedRole) {
      case 'driver':
        _role = UserRole.driver;
        _status = AuthStatus.success;
        notifyListeners();
      case 'admin':
        _role = UserRole.admin;
        _status = AuthStatus.success;
        notifyListeners();
    }
  }

  Future<void> login(String username, String password) async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      
      // 4. Menggunakan Records / Tuple bawaan Dart 3 untuk membandingkan banyak variabel sekaligus
      final credential = (username, password); 

      if (credential == ('supir1', '123')) { // 5. Cek username & password sekaligus dengan Pattern Matching
        _role = UserRole.driver;
        _status = AuthStatus.success;
        await _prefs.setString('user_role', 'driver'); // 6. Simpan string menggunakan instance async
      } else if (credential == ('bos', 'rahasia')) {
        _role = UserRole.admin;
        _status = AuthStatus.success;
        await _prefs.setString('user_role', 'admin');
      } else {
        _errorMessage = 'Username atau password salah!';
        _status = AuthStatus.error;
      }
    } catch (e) {
      _errorMessage = 'Gagal terhubung ke server.';
      _status = AuthStatus.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _prefs.remove('user_role'); // 7. Hapus sesi langsung melalui instance async
    _role = UserRole.unknown;
    _status = AuthStatus.initial;
    notifyListeners();
  }
}