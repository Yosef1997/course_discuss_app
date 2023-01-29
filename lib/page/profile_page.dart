import 'package:course_discuss_app/config/app_route.dart';
import 'package:course_discuss_app/controller/c_profile.dart';
import 'package:course_discuss_app/controller/c_user.dart';
import 'package:course_discuss_app/model/user.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/api.dart';
import '../config/app_format.dart';
import '../model/topic.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    var cUser = context.read<CUser>();
    var cProfile = context.read<CProfile>();
    cProfile.setTopics(user.id);
    cProfile.checkIsFollowing(cUser.data!.id, user.id);
    cProfile.setStat(cUser.data!.id);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.3,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.5,
                  child: Image.network(
                    '${Api.imageUser}/${user.image}',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 40,
                  child: FloatingActionButton(
                    heroTag: 'back-navigation',
                    mini: true,
                    onPressed: () => context.pop(),
                    child: const Icon(Icons.navigate_before),
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 0,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.3),
                            borderRadius: BorderRadius.circular(4)),
                        child: DView.textTitle(
                          user.username,
                          color: Colors.white,
                        ),
                      ),
                      DView.spaceHeight(8),
                      Consumer<CProfile>(
                        builder: (contextConsumer, _, child) {
                          return Material(
                            elevation: 8,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: itemStat('Topic', _.stat['topic']),
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    height: 30,
                                    width: .5,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        context.push(AppRoute.follower,
                                            extra: user);
                                      },
                                      child: itemStat(
                                          'Follower', _.stat['follower']),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    height: 30,
                                    width: .5,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        context.push(AppRoute.following,
                                            extra: user);
                                      },
                                      child: itemStat(
                                          'Following', _.stat['following']),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          DView.spaceHeight(),
          if (cUser.data!.id != user.id)
            Consumer<CProfile>(
              builder: (contextConsumer, _, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        cProfile.setFollow(context, cUser.data!.id, user.id);
                      },
                      child: Text(_.isFollowing ? 'UnFollow' : 'Follow'),
                    ),
                  ),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: DView.textTitle('Topic'),
          ),
          Expanded(
            child: Consumer<CProfile>(
              builder: (contextConsumer, _, child) {
                if (_.topics.isEmpty) return DView.empty();
                return ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: _.topics.length,
                  itemBuilder: (context, index) {
                    Topic topic = _.topics[index];
                    return ListTile(
                      onTap: () {
                        context.push(AppRoute.detailTopic,
                            extra: topic..user = user);
                      },
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
                      trailing: const Icon(Icons.navigate_next),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget itemStat(String title, num value) {
    return Column(
      children: [
        Text(title),
        DView.spaceHeight(4),
        DView.textTitle(
          AppFormat.infoNumber(value.toDouble()),
        )
      ],
    );
  }
}
