import 'package:flutter/material.dart';
import 'controller.dart'; 

class LoginScreen extends StatefulWidget {
  final AuthController authController;

  const LoginScreen({super.key, required this.authController});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi untuk mengeksekusi login dan mengatur perpindahan halaman
  Future<void> _prosesLogin() async {
    // 1. Panggil fungsi login yang ada di AuthController
    await widget.authController.login(
      _usernameController.text,
      _passwordController.text,
    );

    // 2. Cek isi toples setelah proses loading selesai
    if (!mounted) return; // Mencegah error jika widget sudah ditutup

    if (widget.authController.status == AuthStatus.success) {
      // 3. Arahkan ke halaman yang sesuai dengan rolenya
      if (widget.authController.role == UserRole.admingudang) {
        // Pindah ke halaman Scanner & GPS
        Navigator.pushReplacementNamed(context, '/');
      } else if (widget.authController.role == UserRole.owner) {
        // Pindah ke halaman Dashboard Tracker
        Navigator.pushReplacementNamed(context, '/');
      }
    } else if (widget.authController.status == AuthStatus.error) {
      // 4. Munculkan pesan error (SnackBar) di bawah layar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.authController.errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        // ListenableBuilder berfungsi untuk mendengarkan perubahan pada AuthController
        child: ListenableBuilder(
          listenable: widget.authController,
          builder: (context, child) {
            final status = widget.authController.status;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'SafeShip',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Logika UI: Kalau toples berisi 'loading', munculkan spinner. 
                // Kalau selain itu (initial/error), munculkan tombol MASUK.
                status == AuthStatus.loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _prosesLogin,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('MASUK'),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}