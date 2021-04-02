import 'package:flutter/material.dart';
import 'package:new_flutter_bloc/features/presentation/screens/auth/login_screen.dart';
import 'package:new_flutter_bloc/features/presentation/screens/auth/register_identity.dart';
import 'package:new_flutter_bloc/features/presentation/screens/camera/whatsapp_camera.dart';
import 'package:new_flutter_bloc/features/presentation/screens/main/bottom_tab.dart';
import 'package:new_flutter_bloc/features/presentation/screens/main/home_screen.dart';
import 'package:new_flutter_bloc/features/presentation/screens/main/pick_location.dart';
import 'package:new_flutter_bloc/features/presentation/widgets/list_feature_tile.dart';

class ExampleList extends StatelessWidget {
  static const routeName = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListFeatureTile(
                label: "Bloc Example",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              ListFeatureTile(
                label: "Local Auth",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
              ListFeatureTile(
                label: "Bottom tab/ Explore UI",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BottomTab()),
                  );
                },
              ),
              // ListFeatureTile(
              //   label: "Register identity with camera detection",
              //   onTap: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //           builder: (context) => RegisterIdentityScreen()),
              //     );
              //   },
              // ),
              ListFeatureTile(
                label: "Whatsapp send photo",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => WhatsappCameraScreen()),
                  );
                },
              ),
              ListFeatureTile(
                label: "Maps pick location",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PickLocation()),
                  );
                },
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}
