import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/social_cubit.dart';
import '../../models/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel? userModel = SocialCubit.get(context).currentUser;

        TextEditingController nameController = TextEditingController();
        TextEditingController phoneController = TextEditingController();
        TextEditingController bioController = TextEditingController();

        nameController.text = userModel!.name;
        phoneController.text = userModel.phone;
        bioController.text = userModel.bio;

        File? profileImage = SocialCubit.get(context).profileImage;
        File? coverImage = SocialCubit.get(context).coverImage;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit profile',
            actions: [
              defaultTextButton(
                onPressedFunction: () {
                  SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                text: 'update',
              ),
              const SizedBox(width: 15.0),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is UpdateUserLoading) LinearProgressIndicator(),
                    Container(
                      height: 190,
                      child: Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 150.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: coverImage == null
                                              ? NetworkImage(
                                                  '${userModel.cover}',
                                                )
                                              : FileImage(coverImage)
                                                  as ImageProvider<Object>,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                  ],
                                ),
                                Transform.translate(
                                  offset: Offset(0, -20.0),
                                  child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: -20,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        radius: 70.0,
                                        child: CircleAvatar(
                                          radius: 60.0,
                                          backgroundImage: profileImage == null
                                              ? NetworkImage(
                                                  '${userModel.image}',
                                                )
                                              : FileImage(profileImage)
                                                  as ImageProvider<Object>?,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                    ],
                                  ),
                                  Transform.translate(
                                    offset: Offset(5.0, -15.0),
                                    child: IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .getProfileImage();
                                      },
                                      icon: CircleAvatar(
                                        radius: 20.0,
                                        child: Icon(
                                          IconBroken.Camera,
                                          size: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (val) {
                        if (val.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User,
                    ),
                    const SizedBox(height: 10),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (val) {
                        if (val.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: IconBroken.Call,
                    ),
                    const SizedBox(height: 10),
                    defaultFormField(
                      controller: bioController,
                      type: TextInputType.name,
                      validate: (val) {
                        if (val.isEmpty) {
                          return 'Bio must not be empty';
                        }
                        return null;
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
