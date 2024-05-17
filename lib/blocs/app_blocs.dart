import 'package:flutter_application_notebooks/blocs/app_states.dart';
import 'package:flutter_application_notebooks/blocs/app_events.dart';
import 'package:flutter_application_notebooks/models/product_model.dart';
import 'package:flutter_application_notebooks/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  late List<ProductModel> _allProducts; // Full List of products

  ProductBloc(this._productRepository) : super(ProductLoadingState()) {
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final products = await _productRepository.getProducts();
        _allProducts = List<ProductModel>.from(products);
        emit(ProductLoadedState(products));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });

    on<ApplySearchFilterEvent>((event, emit) async {
      if (state is ProductLoadedState) {
        try {
          // Filter the list of products
          final filteredProducts = _allProducts
              .where((product) => product.description
                  .toLowerCase()
                  .contains(event.filter.toLowerCase()))
              .toList();

          emit(ProductLoadedState(filteredProducts));
        } catch (e) {
          emit(ProductErrorState(e.toString()));
        }
      }
    });
  }
}
