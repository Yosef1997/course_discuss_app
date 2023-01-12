import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DView.textTitle(title),
          DView.spaceHeight(),
          DView.error(description),
        ],
      ),
    );
  }
}
