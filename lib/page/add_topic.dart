import 'package:d_button/d_button.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/c_add_topic.dart';

class AddTopic extends StatelessWidget {
  const AddTopic({super.key});

  addNewTopic(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerDescription = TextEditingController();
    return Scaffold(
      appBar: DView.appBarLeft('Add Topic'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: DButtonElevation(
          onClick: () => addNewTopic(context),
          height: 40,
          mainColor: Theme.of(context).primaryColor,
          child: const Text(
            'Add New Topic',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        children: [
          DView.spaceHeight(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: DInput(
              controller: controllerDescription,
              title: 'Description',
              minLine: 1,
              maxLine: 5,
            ),
          ),
          DView.spaceHeight(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<CAddTopic>().pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery'),
                ),
                DView.spaceWidth(),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<CAddTopic>().pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Camera'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
