import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_notebooks/models/user_model.dart';

@immutable
abstract class UserState extends Equatable {}
// the initial state, need each class for each state
//data loading state
class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState {
  UserLoadedState(this.users);
  final List<UserModel> users;

  @override
  List<Object> get props => [users];
}

class UserErrorState extends UserState {
  UserErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}