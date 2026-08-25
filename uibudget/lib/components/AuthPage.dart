import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:uibudget/main.dart'; // MyHomePage'in olduğu dosya

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final String _baseUrl = "http://10.0.2.2:5268"; // API Adresin
  bool _isLogin = false; // true: Giriş, false: Kayıt
  bool _isLoading = false;

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _surnameCtrl = TextEditingController();

  Future<void> _submitAuth() async {
    setState(() => _isLoading = true);

    String endpoint = _isLogin
        ? "/api/Users/login"
        : "/api/Users"; // API route'larını kendi sistemine göre uyarla

    Map<String, dynamic> payload = _isLogin
        ? {"email": _emailCtrl.text, "password": _passwordCtrl.text}
        : {
            "name": _nameCtrl.text,
            "surname": _surnameCtrl.text,
            "email": _emailCtrl.text,
            "password": _passwordCtrl.text,
          };

    try {
      final response = await http.post(
        Uri.parse("$_baseUrl$endpoint"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      // 200 OK veya 201 Created
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Backend'den dönen user nesnesini parse et
        final userData = jsonDecode(response.body);
        int userId =
            userData['id'] ?? userData['Id'] ?? 1; // Backend'in döndüğü ID
        String userName = userData['name'] ?? userData['Name'] ?? "Kullanıcı";

        // Yerel depolamaya kaydet (30 gün hatırlama için)
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', userId);
        await prefs.setString('userName', userName);
        await prefs.setString('loginDate', DateTime.now().toIso8601String());

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MyHomePage(title: 'Bütçe Özeti', userName: userName),
          ),
        );
      } else {
        throw Exception("Bilgiler hatalı veya sunucu yanıt vermiyor.");
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Hata: $e"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  size: 80,
                  color: colors.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  _isLogin ? "Tekrar Hoş Geldiniz!" : "Hesap Oluşturun",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 32),

                if (!_isLogin) ...[
                  _buildTextField("Adınız", Icons.person_outline, _nameCtrl),
                  const SizedBox(height: 16),
                  _buildTextField(
                    "Soyadınız",
                    Icons.person_outline,
                    _surnameCtrl,
                  ),
                  const SizedBox(height: 16),
                ],

                _buildTextField(
                  "E-Posta",
                  Icons.email_outlined,
                  _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  "Şifre",
                  Icons.lock_outline,
                  _passwordCtrl,
                  obscureText: true,
                ),
                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _isLoading ? null : _submitAuth,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            _isLogin ? "GİRİŞ YAP" : "KAYIT OL",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin
                        ? "Hesabınız yok mu? Kayıt Olun"
                        : "Zaten hesabınız var mı? Giriş Yapın",
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    TextEditingController controller, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final colors = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(color: colors.onSurface),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: colors.onSurfaceVariant),
        prefixIcon: Icon(icon, color: colors.primary),
        filled: true,
        fillColor: colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colors.onSurfaceVariant.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
      ),
    );
  }
}
