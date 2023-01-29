import 'package:course_discuss_app/config/app_color.dart';
import 'package:course_discuss_app/config/app_format.dart';
import 'package:course_discuss_app/config/app_route.dart';
import 'package:course_discuss_app/model/topic.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/api.dart';

class ItemTopic extends StatelessWidget {
  const ItemTopic({
    super.key,
    required this.topic,
    required this.images,
  });
  final Topic topic;
  final List images;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.push(AppRoute.profile, extra: topic.user);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    '${Api.imageUser}/${topic.user!.image}',
                    fit: BoxFit.cover,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              DView.spaceWidth(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'by ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          children: [
                            TextSpan(
                              text: topic.user!.username,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                          ]),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(4)),
                padding: const EdgeInsets.all(4),
                child: DView.textAction(
                  () {
                    context.push(AppRoute.detailTopic, extra: topic);
                  },
                  text: 'Detail',
                  size: 14,
                  color: Theme.of(context).primaryColor,
                  iconRight: Icons.navigate_next,
                  iconRightSize: 17,
                  iconRightColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          DView.spaceHeight(8),
          Text(topic.description),
          DView.spaceHeight(8),
          if (images.isNotEmpty)
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          '${Api.imageTopic}/${images[0]}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  if (images.length > 1)
                    Container(
                      width: 60,
                      height: double.infinity,
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[300],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '+${images.length - 1}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          Text(AppFormat.publish(topic.createdAt)),
        ],
      ),
    );
  }
}
