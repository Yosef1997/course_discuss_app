import 'package:course_discuss_app/controller/c_my_topic.dart';
import 'package:course_discuss_app/controller/c_user.dart';
import 'package:course_discuss_app/model/topic.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/app_route.dart';

class MyTopicFragment extends StatelessWidget {
  const MyTopicFragment({super.key});

  deleteTopic(BuildContext context, Topic topic) {}

  @override
  Widget build(BuildContext context) {
    final user = context.read<CUser>().data;
    context.read<CMyTopic>().setTopics(user!.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: DView.textTitle('My Topic', size: 24),
        ),
        Expanded(
          child: Consumer<CMyTopic>(
            builder: (contextConsumer, _, child) {
              if (_.topics.isEmpty) return DView.empty();
              return ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: _.topics.length,
                itemBuilder: (context, index) {
                  Topic topic = _.topics[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 16,
                      child: Text('${index + 1}'),
                    ),
                    horizontalTitleGap: 0,
                    title: Text(
                      topic.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      topic.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'detail') {
                          context.push(AppRoute.detailTopic,
                              extra: topic..user = user);
                        }
                        if (value == 'update') {
                          context.push(AppRoute.updateTopic,
                              extra: topic..user = user);
                        }
                        if (value == 'delete') {
                          deleteTopic(context, topic);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'detail',
                          child: Text('Detail'),
                        ),
                        const PopupMenuItem(
                          value: 'update',
                          child: Text('Update'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
