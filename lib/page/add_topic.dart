import 'dart:convert';

import 'package:course_discuss_app/controller/c_home.dart';
import 'package:course_discuss_app/controller/c_my_topic.dart';
import 'package:course_discuss_app/source/topic_source.dart';
import 'package:d_button/d_button.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/c_add_topic.dart';
import '../controller/c_user.dart';

class AddTopic extends StatelessWidget {
  AddTopic({super.key});

  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();

  addNewTopic(BuildContext context) {
    TopicSource.create(
      controllerTitle.text,
      controllerDescription.text,
      jsonEncode(context.read<CAddTopic>().imageNames),
      jsonEncode(context.read<CAddTopic>().imageBase64codes),
      context.read<CUser>().data!.id,
    ).then((success) {
      if (success) {
        DInfo.snackBarSuccess(context, 'Success Add new Topic');
        context.read<CHome>().indexMenu = 2;
        context.read<CMyTopic>().setTopics(context.read<CUser>().data!.id);
        context.pop();
      } else {
        DInfo.snackBarError(context, 'Add Topic Failed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              controller: controllerTitle,
              title: 'title',
              minLine: 1,
              maxLine: 5,
            ),
          ),
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
          ),
          Consumer<CAddTopic>(
            builder: (contextConsumer, _, child) {
              if (_.imageNames.isEmpty) return DView.nothing();
              return SizedBox(
                height: 150,
                child: ListView.builder(
                    itemCount: _.imageNames.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          index == 0 ? 16 : 8,
                          8,
                          index == _.imageNames.length - 1 ? 16 : 8,
                          8,
                        ),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4)),
                            child: Stack(children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.memory(
                                    _.imageBytes[index],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: DButtonElevation(
                                  onClick: () {
                                    _.removeImage(index);
                                  },
                                  width: 40,
                                  height: 40,
                                  mainColor: Colors.red[100]!,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red[900],
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ),
                      );
                    }),
              );
            },
          )
        ],
      ),
    );
  }
}
