import 'package:flutter/material.dart';

class OrderProductStatus extends StatelessWidget {
  const OrderProductStatus(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.status,
      required this.thisStatus});

  final String title;
  final String subtitle;
  final int status;
  final int thisStatus;

  @override
  Widget build(BuildContext context) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey[500]!;
      child = Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      );
    } else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      );
    } else {
      backColor = Colors.green;
      child = const Icon(
        Icons.check,
        color: Colors.white,
      );
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle),
      ],
    );
  }
}
