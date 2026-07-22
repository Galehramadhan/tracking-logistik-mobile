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
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (widget.authController.role == UserRole.owner) {
        // Pindah ke halaman Dashboard Tracker
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } else if (widget.authController.status == AuthStatus.error) {
      // 4. Munculkan pesan error (SnackBar) di bawah layar
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.authController.errorMessage),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), 
      body: SafeArea( 
        child: Center( 
          child: SingleChildScrollView( 
            padding: const EdgeInsets.all(24.0),
      
            // ListenableBuilder berfungsi untuk mendengarkan perubahan pada AuthController
            child: ListenableBuilder(
              listenable: widget.authController,
              builder: (context, child) {
                final status = widget.authController.status;

                return Card(
                  elevation: 8,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.local_shipping_rounded,
                          size: 72,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'SafeShip',
                          style: TextStyle(
                            fontSize: 32, 
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1E293B),
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Silakan masuk ke akun Anda',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 40),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20), 
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        // Logika UI: Kalau toples berisi 'loading', munculkan spinner. 
                        // Kalau selain itu (initial/error), munculkan tombol MASUK.
                        status == AuthStatus.loading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: _prosesLogin,
                                
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 55),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
                                child: const Text(
                                  'MASUK',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}