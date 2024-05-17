import 'package:flutter_application_notebooks/blocs/app_states.dart';
import 'package:flutter_application_notebooks/blocs/app_events.dart';
import 'package:flutter_application_notebooks/models/user_model.dart';
import 'package:flutter_application_notebooks/repos/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  late List<ProductModel> _allProducts; // Lista completa de usuarios

  ProductBloc(this._productRepository) : super(ProductLoadingState()) {
    on<LoadProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final products = await _productRepository.getProducts();
        _allProducts = List<ProductModel>.from(products); // Guardar la lista completa de usuarios
        emit(ProductLoadedState(products));
      } catch (e) {
        emit(ProductErrorState(e.toString()));
      }
    });

    on<ApplySearchFilterEvent>((event, emit) async {
      if (state is ProductLoadedState) {
        try {
          final currentState = state as ProductLoadedState;

          // Filtrar la lista completa de usuarios
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
