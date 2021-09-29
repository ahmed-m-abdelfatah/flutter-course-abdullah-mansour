import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import '../../layout/cubit/social_cubit.dart';
import '../../models/user_model.dart';
import '../../shared/_adaptive/adaptive_circular_progress_indicator.dart';
import '../../shared/_adaptive/operating_system.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);
  final TextEditingController postText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel? userModel = SocialCubit.get(context).currentUser;
        File? postImage = SocialCubit.get(context).postImage;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'New post',
            actions: [
              defaultTextButton(
                onPressedFunction: () {
                  SocialCubit.get(context).createNewPost(
                    dateTime: DateTime.now().toLocal().toString(),
                    text: postText.text,
                  );
                },
                text: 'Post',
              )
            ],
          ),
          body: Conditional.single(
            context: context,
            conditionBuilder: (context) => userModel != null,
            widgetBuilder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is CreatePostLoading) LinearProgressIndicator(),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(userModel!.image),
                      ),
                      const SizedBox(width: 15.0),
                      Text(
                        userModel.name,
                        style: TextStyle(height: 1.4),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: postText,
                      decoration: InputDecoration(
                        hintText: 'What\'s on your mind?',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  if (postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 150.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(postImage),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                        Transform.translate(
                          offset: Offset(0, -20.0),
                          child: IconButton(
                            onPressed: () {
                              SocialCubit.get(context).removePostImage();
                            },
                            icon: CircleAvatar(
                              radius: 20.0,
                              child: Icon(
                                Icons.close,
                                size: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          icon: Icon(IconBroken.Image),
                          label: Text('Add Photo'),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          child: Text('# tags'),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            fallbackBuilder: (context) => Center(
              child: AdaptiveCircularProgressIndicator(
                os: OperatingSystem.getOs(),
              ),
            ),
          ),
        );
      },
    );
  }
}
