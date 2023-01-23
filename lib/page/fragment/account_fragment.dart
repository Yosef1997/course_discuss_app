import 'package:course_discuss_app/config/api.dart';
import 'package:course_discuss_app/controller/c_account.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/c_user.dart';

class AccountFragment extends StatelessWidget {
  const AccountFragment({super.key});

  @override
  Widget build(BuildContext context) {
    var cUser = context.read<CUser>();
    var cAccount = context.read<CAccount>();
    if (cUser.data == null) return DView.empty();
    cAccount.setStat(cUser.data!.id);
    double widthBoxImage = MediaQuery.of(context).size.width * .5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DView.spaceHeight(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DView.textTitle('Account', size: 24),
        ),
        DView.spaceHeight(30),
        SizedBox(
          width: widthBoxImage,
          height: widthBoxImage,
          child: Stack(children: [
            Container(
              width: widthBoxImage,
              height: widthBoxImage,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 4,
                  color: Theme.of(context).primaryColor,
                ),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 6,
                    offset: Offset(2, 3),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(90),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: Image.network(
                    '${Api.imageUser}/${cUser.data!.image}',
                    fit: BoxFit.cover,
                    width: widthBoxImage - 20,
                    height: widthBoxImage - 20,
                  ),
                ),
              ),
            )
          ]),
        ),
        DView.spaceHeight(12),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DView.textTitle(cUser.data!.username, color: Colors.white),
            ),
            DView.spaceWidth(),
            ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  size: 14,
                ),
                label: const Text('Image'))
          ],
        )
      ],
    );
  }
}
