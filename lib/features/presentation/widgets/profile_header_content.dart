import 'package:flutter/material.dart';

class ProfileHeaderContent extends StatelessWidget {
  const ProfileHeaderContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                ),
                SizedBox(
                  width: 12,
                ),
                Text("User name"),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text("Description"),
          ],
        ),
      ),
    );
  }
}
