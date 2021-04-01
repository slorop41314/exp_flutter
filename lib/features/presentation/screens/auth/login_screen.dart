import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBiometric = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  void _checkBiometricAvailability() async {
    try {
      _canCheckBiometric = await _localAuthentication.canCheckBiometrics;
      setState(() {});
    } catch (e) {}
  }

  void _authenticateBiometrics() async {
    final x = await _localAuthentication.authenticate(
      localizedReason: "",
      androidAuthStrings: AndroidAuthMessages(
        biometricHint: "Gunakan identitas biometrik yang telah terdaftar",
      ),
      biometricOnly: true,
    );
    if (x) {
      _showSnackbar("Login biometric berhasil");
    } else {
      _showSnackbar("Login biometric gagal", color: Colors.red);
    }
  }

  void _showSnackbar(String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      backgroundColor: color ?? Colors.black,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text("Login Screen"),
                      SizedBox(
                        height: 24,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Padding _buildActionButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Login"),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          ElevatedButton(
            onPressed: _canCheckBiometric ? _authenticateBiometrics : null,
            child: Icon(Icons.fingerprint),
          ),
        ],
      ),
    );
  }
}
