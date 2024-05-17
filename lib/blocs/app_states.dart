import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_notebooks/models/product_model.dart';

@immutable
abstract class ProductState extends Equatable {}

//Data loading state
class ProductLoadingState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadedState extends ProductState {
  ProductLoadedState(this.products);
  final List<ProductModel> products;

  @override
  List<Object> get props => [products];
}

class ProductErrorState extends ProductState {
  ProductErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}