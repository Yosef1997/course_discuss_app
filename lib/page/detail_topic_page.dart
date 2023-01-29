import 'dart:convert';

import 'package:course_discuss_app/config/app_format.dart';
import 'package:course_discuss_app/config/app_route.dart';
import 'package:course_discuss_app/model/topic.dart';
import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/api.dart';

class DetailTopicPage extends StatelessWidget {
  const DetailTopicPage({
    super.key,
    required this.topic,
  });
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    List<String> images = List<String>.from(jsonDecode(topic.images));
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  '${Api.imageUser}/${topic.user!.image}',
                  fit: BoxFit.cover,
                  width: 36,
                  height: 36,
                ),
              ),
            ),
            DView.spaceWidth(),
            Text(topic.user!.username)
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: DButtonElevation(
          onClick: () {
            context.push(AppRoute.comment, extra: topic);
          },
          height: 40,
          mainColor: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Comments',
                style: TextStyle(color: Colors.white),
              ),
              DView.spaceWidth(4),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      extendBody: true,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DView.textTitle(topic.title),
          DView.spaceHeight(4),
          Row(
            children: [
              const Icon(
                Icons.event,
                color: Colors.grey,
                size: 15,
              ),
              DView.spaceWidth(4),
              Text(
                AppFormat.fullDateTime(topic.createdAt),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          DView.spaceHeight(),
          Text(topic.description),
          DView.spaceHeight(),
          if (images.isNotEmpty)
            ...images.map((e) {
              return Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (contextDialog) {
                        return Column(
                          children: [
                            DView.spaceHeight(),
                            DButtonCircle(
                              diameter: 40,
                              onClick: () => Navigator.pop(contextDialog),
                              child: const Icon(Icons.clear),
                            ),
                            Expanded(
                                child: InteractiveViewer(
                              child: Image.network(
                                '${Api.imageTopic}/$e',
                                fit: BoxFit.contain,
                              ),
                            )),
                          ],
                        );
                      },
                    );
                  },
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        '${Api.imageTopic}/$e',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
        ],
      ),
    );
  }
}
