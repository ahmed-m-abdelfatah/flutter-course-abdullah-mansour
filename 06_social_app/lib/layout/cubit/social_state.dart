part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {}

// getCurrentUserData
class GetCurrentUserLoading extends SocialState {}

class GetCurrentUserSuccess extends SocialState {}

class GetCurrentUserError extends SocialState {
  final String error;
  GetCurrentUserError(this.error);
}

// bottom nav bar items
class ChangeBottomNav extends SocialState {}

class NewPost extends SocialState {}

// image picker (profile / cover / post)
class ProfileImageSuccess extends SocialState {}

class ProfileImageError extends SocialState {}

class CoverImageSuccess extends SocialState {}

class CoverImageError extends SocialState {}

class PostImageSuccess extends SocialState {}

class PostImageError extends SocialState {}

class PostImageRemove extends SocialState {}

// upload (profile / cover / post) image
class UploadProfileImageSuccess extends SocialState {}

class UploadProfileImageError extends SocialState {}

class UploadCoverImageSuccess extends SocialState {}

class UploadCoverImageError extends SocialState {}

class UploadPostImageSuccess extends SocialState {}

class UploadPostImageError extends SocialState {}

// update user data
class UpdateUserLoading extends SocialState {}

class UpdateUserError extends SocialState {}

//  create new post
class CreatePostLoading extends SocialState {}

class CreatePostSuccess extends SocialState {}

class CreatePostError extends SocialState {}

// getPostsData
class GetPostsLoading extends SocialState {}

class GetPostsSuccess extends SocialState {}

class GetPostsError extends SocialState {
  final String error;
  GetPostsError(this.error);
}

// likePost
class LikePostsSuccess extends SocialState {}

class LikePostsError extends SocialState {
  final String error;
  LikePostsError(this.error);
}

// getAllUsers
class GetAllUsersLoading extends SocialState {}

class GetAllUsersSuccess extends SocialState {}

class GetAllUsersError extends SocialState {
  final String error;
  GetAllUsersError(this.error);
}

// chat
class SendMessageSuccess extends SocialState {}

class SendMessageError extends SocialState {}

class GetMessageSuccess extends SocialState {}
