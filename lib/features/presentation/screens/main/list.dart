import 'package:flutter/material.dart';
import 'package:new_flutter_bloc/features/presentation/screens/auth/login_screen.dart';
import 'package:new_flutter_bloc/features/presentation/screens/auth/register_identity.dart';
import 'package:new_flutter_bloc/features/presentation/screens/camera/whatsapp_camera.dart';
import 'package:new_flutter_bloc/features/presentation/screens/main/home_screen.dart';

class ExampleList extends StatelessWidget {
  static const routeName = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text("Bloc Example"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Local Auth"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Register identity with camera detection"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => RegisterIdentityScreen()),
                  );
                },
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                title: Text("Whatsapp send photo"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => WhatsappCameraScreen()),
                  );
                },
                trailing: Icon(Icons.chevron_right),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}
