import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();
}
//Data loading event
class LoadProductEvent extends ProductEvent {
  @override
  List<Object> get props => [];
}
// Event for filter search
class ApplySearchFilterEvent extends ProductEvent {
  final String filter;

  const ApplySearchFilterEvent({required this.filter});

  @override
  List<Object> get props => [filter];
}
