import 'package:gsocial/data/models/user_model.dart';

abstract class SettingsStates {}
class InitialSettingsState extends SettingsStates {}
class GetUserDataLoadingSettingsState extends SettingsStates {}
class GetUserDataErrorSettingsState extends SettingsStates {
  final String error;

  GetUserDataErrorSettingsState(this.error);
}
class GetUserDataSuccessSettingsState extends SettingsStates {
  final SocialUserModel model;

  GetUserDataSuccessSettingsState(this.model);
}
class SignOutSettingsState extends SettingsStates {}
class PickedImageSuccessState extends SettingsStates {}
class PickedImageErrorState extends SettingsStates {}
class PickPostImageSuccessState extends SettingsStates {}
class PickPostImageErrorState extends SettingsStates {}
class CreatePostErrorState extends SettingsStates {}
class CreatePostLoadingState extends SettingsStates {}
class CreatePostSuccessState extends SettingsStates {}
class GetPostErrorState extends SettingsStates {}
class GetPostLoadingState extends SettingsStates {}
class GetPostSuccessState extends SettingsStates {}
class PostLikeSuccessState extends SettingsStates {}
class PostLikeErrorState extends SettingsStates {}
class CommentOnPostSuccessState extends SettingsStates {}
class CommentOnPostErrorState extends SettingsStates {}
class GetUsersErrorState extends SettingsStates {}
class GetUsersLoadingState extends SettingsStates {}
class GetUsersSuccessState extends SettingsStates {}

class SendMessageSuccessState extends SettingsStates {}
class SendMessageErrorState extends SettingsStates {}

class GetMessageSuccessState extends SettingsStates {}
class GetMessageErrorState extends SettingsStates {}