import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 87, 171),
      body: Center(
        child: Container(
          width: 300,
          height: 500,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/ubsi.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'Selamat datang di Aplikasi Absensi',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () =>
                    _login(context, usernameController, passwordController),
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context, TextEditingController usernameController,
      TextEditingController passwordController) {
    if (usernameController.text == "admin" &&
        passwordController.text == "12345") {
      // Menampilkan dialog loading dengan QuickAlert
      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Login...',
        text: 'Sedang memverifikasi data Anda',
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(); // Menutup dialog loading
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Berhasil Login',
          text: 'Selamat datang!',
          onConfirmBtnTap: () {
            Navigator.of(context).pop(); // Menutup QuickAlert
            Navigator.pushReplacementNamed(context, '/home');
          },
        );
      });
    } else {
      // Menampilkan error login menggunakan QuickAlert
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Login Gagal',
        text: 'Username atau password salah',
        confirmBtnText: 'Coba Lagi',
      );
    }
  }
}
