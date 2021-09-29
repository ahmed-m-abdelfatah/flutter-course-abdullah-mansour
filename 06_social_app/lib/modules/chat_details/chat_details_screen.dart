import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

import '../../layout/cubit/social_cubit.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';
import '../../shared/_adaptive/adaptive_circular_progress_indicator.dart';
import '../../shared/_adaptive/operating_system.dart';
import '../../shared/styles/icon_broken.dart';
import '../../shared/styles/my_main_styles.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel chatUser;
  final TextEditingController messageController = TextEditingController();

  ChatDetailsScreen({
    Key? key,
    required this.chatUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(recevierId: chatUser.uId);

      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(IconBroken.Arrow___Left_2),
              ),
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(chatUser.image),
                  ),
                  const SizedBox(width: 15.0),
                  Text(chatUser.name)
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          SocialCubit.get(context).messages.length > 0,
                      widgetBuilder: (context) => ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          MessageModel message =
                              SocialCubit.get(context).messages[index];

                          if (SocialCubit.get(context).currentUser!.uId ==
                              message.sinderId) {
                            return _buildSenderMessage(message);
                          }

                          return _buildRecevierMessage(message);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15.0),
                        itemCount: SocialCubit.get(context).messages.length,
                      ),
                      fallbackBuilder: (context) => Center(
                          child: AdaptiveCircularProgressIndicator(
                              os: OperatingSystem.getOs())),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    height: 45.0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 15.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onFieldSubmitted: (value) =>
                                  _sendMessage(context),
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message here ...',
                                hintStyle: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          ),
                          Container(
                            height: 45.0,
                            color: MyMainColors.myBlue,
                            child: MaterialButton(
                              onPressed: () {
                                _sendMessage(context);
                              },
                              minWidth: 1.0,
                              child: Icon(
                                IconBroken.Send,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  void _sendMessage(BuildContext context) {
    SocialCubit.get(context).sendMessage(
      recevierId: chatUser.uId,
      messageDate: DateTime.now().toString(),
      messagetext: messageController.text,
    );

    messageController.text = '';
    FocusScope.of(context).unfocus();
  }

  Align _buildSenderMessage(MessageModel message) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: MyMainColors.myBlue.withOpacity(0.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(message.messagetext),
      ),
    );
  }

  Align _buildRecevierMessage(MessageModel message) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(message.messagetext),
      ),
    );
  }
}
