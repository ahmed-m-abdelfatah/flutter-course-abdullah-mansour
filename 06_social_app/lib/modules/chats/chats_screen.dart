import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import '../../app_router.dart';
import '../../layout/cubit/social_cubit.dart';
import '../../models/user_model.dart';
import '../../shared/_adaptive/adaptive_circular_progress_indicator.dart';
import '../../shared/_adaptive/operating_system.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                SocialCubit.get(context).allUsers.length > 0,
            widgetBuilder: (context) => _buildChatList(
              SocialCubit.get(context).allUsers,
            ),
            fallbackBuilder: (context) => Center(
              child: AdaptiveCircularProgressIndicator(
                  os: OperatingSystem.getOs()),
            ),
          );
        },
      ),
    );
  }

  ListView _buildChatList(
    List<UserModel> allUsers,
  ) {
    return ListView.separated(
      key: PageStorageKey('_buildChatList'),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => _buildChatItem(context, allUsers[index]),
      separatorBuilder: (context, index) => Divider(),
      itemCount: allUsers.length,
    );
  }

  Widget _buildChatItem(BuildContext context, UserModel chatUser) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.chatDetailsScreen,
          arguments: chatUser,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                chatUser.image,
              ),
            ),
            const SizedBox(width: 15.0),
            Text(
              chatUser.name,
              style: TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
