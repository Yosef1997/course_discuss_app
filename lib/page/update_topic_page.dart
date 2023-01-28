import 'package:course_discuss_app/controller/c_my_topic.dart';
import 'package:course_discuss_app/model/topic.dart';
import 'package:course_discuss_app/source/topic_source.dart';
import 'package:d_button/d_button.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UpdateTopicPage extends StatefulWidget {
  const UpdateTopicPage({
    super.key,
    required this.topic,
  });
  final Topic topic;

  @override
  State<UpdateTopicPage> createState() => _UpdateTopicPageState();
}

class _UpdateTopicPageState extends State<UpdateTopicPage> {
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();

  updateTopic() {
    TopicSource.update(
            widget.topic.id, controllerTitle.text, controllerDescription.text)
        .then(
      (success) {
        if (success) {
          context.read<CMyTopic>().setTopics(widget.topic.idUser);
          DInfo.snackBarSuccess(context, 'Update Success');
          context.pop();
        } else {
          DInfo.snackBarError(context, 'Update Failed');
        }
      },
    );
  }

  @override
  void initState() {
    controllerTitle.text = widget.topic.title;
    controllerDescription.text = widget.topic.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Update Topic'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: DButtonElevation(
            onClick: () => updateTopic(),
            height: 40,
            mainColor: Theme.of(context).primaryColor,
            child: const Text(
              'Update topic',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DInput(
            controller: controllerTitle,
            title: 'Title',
          ),
          DView.spaceHeight(),
          DInput(
            controller: controllerDescription,
            title: 'Description',
            minLine: 1,
            maxLine: 5,
          ),
          DView.spaceHeight(),
        ],
      ),
    );
  }
}
