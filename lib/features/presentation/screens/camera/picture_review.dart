import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class PictureReviewScreen extends StatefulWidget {
  final File image;
  PictureReviewScreen(this.image);
  @override
  _PictureReviewScreenState createState() => _PictureReviewScreenState();
}

class _PictureReviewScreenState extends State<PictureReviewScreen> {
  onSendPicture() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _buildImageView(),
        SafeArea(
          child: Column(
            children: [
              _buildHeaderActions(),
              Spacer(),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                    color: Colors.black38,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Add a caption...",
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: onSendPicture,
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ));
  }

  SizedBox _buildImageView() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.file(
        widget.image,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _buildHeaderActions extends StatelessWidget {
  const _buildHeaderActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Text(
          "Send photo",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
