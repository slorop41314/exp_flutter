import 'dart:io';

import 'package:flutter/material.dart';

class LibraryImage extends StatelessWidget {
  const LibraryImage({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  final File item;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: 80,
        height: 80,
        child: Image.file(
          item,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
