import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class AddTopic extends StatelessWidget {
  const AddTopic({super.key});

  addNewTopic(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Add Topic'),
      bottomNavigationBar: DButtonElevation(
        onClick: () => addNewTopic(context),
        height: 40,
        mainColor: Theme.of(context).primaryColor,
        child: const Text(
          'Add New Topic',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
