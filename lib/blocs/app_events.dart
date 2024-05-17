import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();
}
// the initial state, need each class for each state
//data loading state
class LoadProductEvent extends ProductEvent {
  @override
  List<Object> get props => [];
}



/////////////////////
///// Evento para aplicar un filtro de búsqueda
class ApplySearchFilterEvent extends ProductEvent {
  final String filter;

  ApplySearchFilterEvent({required this.filter});

  @override
  List<Object> get props => [filter];
}
////////////////////////////////

/////////////////////////////////////////////////////////
// abstract class SearchEvent{}

// class SearchWord extends SearchEvent{
//   final String word;

//   SearchWord({required this.word});
// // ignore: empty_constructor_bodies
// }
///////////////////////////////////////////////////////////////