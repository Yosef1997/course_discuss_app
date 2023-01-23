import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class MyTopicFragment extends StatelessWidget {
  const MyTopicFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DView.textTitle('My Topic Fragment'),
    );
  }
}
