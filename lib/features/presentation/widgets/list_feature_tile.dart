import 'package:flutter/material.dart';

class ListFeatureTile extends StatelessWidget {
  const ListFeatureTile({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(this.label),
      onTap: onTap,
      trailing: Icon(Icons.chevron_right),
    );
  }
}
