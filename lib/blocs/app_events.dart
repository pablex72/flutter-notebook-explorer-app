import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}
// the initial state, need each class for each state
//data loading state
class LoadUserEvent extends UserEvent {
  @override
  List<Object> get props => [];
}
