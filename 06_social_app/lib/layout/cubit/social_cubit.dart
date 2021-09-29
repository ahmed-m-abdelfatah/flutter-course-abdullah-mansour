import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../app_router.dart';
import '../../models/message_model.dart';
import '../../models/post_model.dart';
import '../../models/user_model.dart';
import '../../modules/chats/chats_screen.dart';
import '../../modules/feeds/feeds_screen.dart';
import '../../modules/new_post/new_post_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/network/local/cache_data.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/icon_broken.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  // make object of the cubit
  static SocialCubit get(context) => BlocProvider.of(context);

  // getCurrentUserData
  UserModel? currentUser;
  void getCurrentUserData() {
    emit(GetCurrentUserLoading());

    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheData.uId)
        .get()
        .then((value) {
      currentUser = UserModel.fromMap(value.data());
      emit(GetCurrentUserSuccess());
    }).catchError((error) {
      print('getCurrentUserData -- ${error.toString()}');
      emit(GetCurrentUserError(error.toString()));
    });
  }

  // bottom nav bar items
  int currentIndex = 0;

  List<String> appBarTitles = [
    'Home',
    'Chats',
    'New Post',
    // 'Users',
    'Settings',
  ];

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    // UsersScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'Chats'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
    // BottomNavigationBarItem(icon: Icon(IconBroken.Location), label: 'Users'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Setting), label: 'Settings'),
  ];

  void changeBottomNavigationBarItems(int index) {
    if (index == 1) {
      getAllUsers();
    }

    if (index == 2) {
      emit(NewPost());
    } else {
      currentIndex = index;
      emit(ChangeBottomNav());
    }
  }

  // image picker (profile / cover / post)
  final ImagePicker _picker = ImagePicker();

  File? profileImage;
  Future<void> getProfileImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      this.profileImage = File(pickedImage.path);
      emit(ProfileImageSuccess());
    } else {
      emit(ProfileImageError());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      this.coverImage = File(pickedImage.path);
      emit(CoverImageSuccess());
    } else {
      emit(CoverImageError());
    }
  }

  File? postImage;
  Future<void> getPostImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      this.postImage = File(pickedImage.path);
      emit(PostImageSuccess());
    } else {
      emit(PostImageError());
    }
  }

  void removePostImage() {
    this.postImage = null;
    emit(PostImageRemove());
  }

  // upload (profile / cover / post) image
  String profileImageUrl = '';
  Future<void> uploadProfileImage() async {
    try {
      var value = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(this.profileImage!.path).pathSegments.last}')
          .putFile(this.profileImage!);

      var profileImageUrl = await value.ref.getDownloadURL();
      this.profileImageUrl = profileImageUrl;

      emit(UploadProfileImageSuccess());
    } catch (e) {
      print('uploadProfileImage -- ${e.toString()}');
      emit(UploadProfileImageError());
    }
  }

  String coverImageUrl = '';
  Future<void> uploadCoverImage() async {
    try {
      var value = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(this.coverImage!.path).pathSegments.last}')
          .putFile(this.coverImage!);

      var coverImageUrl = await value.ref.getDownloadURL();
      this.coverImageUrl = coverImageUrl;

      emit(UploadCoverImageSuccess());
    } catch (e) {
      print('uploadCoverImage -- ${e.toString()}');
      emit(UploadCoverImageError());
    }
  }

  String postImageUrl = '';
  Future<void> uploadPostImage() async {
    try {
      var value = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('posts/${Uri.file(this.postImage!.path).pathSegments.last}')
          .putFile(this.postImage!);

      var postImageUrl = await value.ref.getDownloadURL();
      this.postImageUrl = postImageUrl;

      emit(UploadPostImageSuccess());
    } catch (e) {
      print('uploadPostImage -- ${e.toString()}');
      emit(UploadPostImageError());
    }
  }

  // update user data
  updateUser({
    required String name,
    required String phone,
    required String bio,
  }) async {
    emit(UpdateUserLoading());

    if (coverImage != null && profileImage != null) {
      await uploadProfileImage();
      await uploadCoverImage();
    } else if (profileImage != null) {
      await uploadProfileImage();
    } else if (coverImage != null) {
      await uploadCoverImage();
    }

    _updateUserData(
      name: name,
      phone: phone,
      bio: bio,
    );
  }

  void _updateUserData({
    required String name,
    required String phone,
    required String bio,
  }) {
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image:
          profileImage == null ? this.currentUser!.image : this.profileImageUrl,
      cover: coverImage == null ? this.currentUser!.cover : this.coverImageUrl,
      email: this.currentUser!.email,
      emailVerified: this.currentUser!.emailVerified,
      uId: this.currentUser!.uId,
    );

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users.doc(this.currentUser!.uId).update(userModel.toMap()).then((_) {
      getCurrentUserData();
    }).catchError((e) {
      print('_updateUserData -- ${e.toString()}');
      emit(UpdateUserError());
    });
  }

  //  create new post
  void createNewPost({
    required String dateTime,
    required String text,
  }) async {
    emit(CreatePostLoading());

    if (this.postImage != null) {
      await uploadPostImage();
    }

    _createNewPostData(
      dateTime: dateTime,
      text: text,
    );
  }

  void _createNewPostData({
    required String dateTime,
    required String text,
  }) {
    PostModel newPost = PostModel(
      name: this.currentUser!.name,
      uId: this.currentUser!.uId,
      image: this.currentUser!.image,
      dateTime: dateTime,
      text: text,
      postImage: this.postImageUrl,
    );

    CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    posts.add(newPost.toMap()).then((_) {
      emit(CreatePostSuccess());
    }).catchError((e) {
      print('_createNewPostData -- ${e.toString()}');
      emit(CreatePostError());
    });
  }

  // getPostsData
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> postsLikes = [];

  void getPostsData() {
    emit(GetPostsLoading());

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          postsLikes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromMap(element.data()));
        }).catchError((error) {});
      });
      emit(GetPostsSuccess());
    }).catchError((error) {
      emit(GetPostsError(error.toString()));
    });
  }

  // likePost
  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(currentUser!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(LikePostsSuccess());
    }).catchError((error) {
      emit(LikePostsError(error.toString()));
    });
  }

  // TODOCOMMENTS_COUNTER

  // getAllUsers
  List<UserModel> allUsers = [];

  void getAllUsers() {
    emit(GetAllUsersLoading());

    if (allUsers.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          print(element.data()['uId']);
          if (element.data()['uId'] != currentUser!.uId) {
            allUsers.add(UserModel.fromMap(element.data()));
          }
          emit(GetAllUsersSuccess());
        });
      }).catchError((error) {
        emit(GetAllUsersError(error.toString()));
      });
    }
  }

  // signOut
  Future<void> signOutAndClraeCache(BuildContext context) async {
    await CacheHelper.clearCacheData();
    await FirebaseAuth.instance.signOut();

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.loginScreen,
      (route) => false,
    );
  }

  // chat
  sendMessage({
    required String recevierId,
    required String messageDate,
    required String messagetext,
  }) {
    MessageModel message = MessageModel(
      sinderId: currentUser!.uId,
      recevierId: recevierId,
      messageDate: messageDate,
      messagetext: messagetext,
    );

    // add chat message to sinderId
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uId)
        .collection('chats')
        .doc(recevierId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageError());
    });

    // add chat message to recevierId
    FirebaseFirestore.instance
        .collection('users')
        .doc(recevierId)
        .collection('chats')
        .doc(currentUser!.uId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageError());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({
    required String recevierId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uId)
        .collection('chats')
        .doc(recevierId)
        .collection('messages')
        .orderBy('messageDate')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromMap(element.data()));
      });

      emit(GetMessageSuccess());
    });
  }
}
