import 'package:flutter/material.dart';
import 'package:new_flutter_bloc/features/presentation/screens/camera/take_identity_picture.dart';

class RegisterIdentityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TakeIdentityPicture()),
                );
              },
              child: Text("Upload identity card"),
            ),
          ),
        ),
      ),
    );
  }
}
