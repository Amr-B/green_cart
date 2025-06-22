import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsState {
  final int count;
  final double totalPrice;

  ProductDetailsState({
    required this.count,
    required this.totalPrice,
  });

  ProductDetailsState copyWith({int? count, double? totalPrice}) {
    return ProductDetailsState(
      count: count ?? this.count,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final double unitPrice;

  ProductDetailsCubit(this.unitPrice)
      : super(ProductDetailsState(count: 1, totalPrice: unitPrice));

  void increment() {
    final newCount = state.count + 1;
    emit(state.copyWith(
      count: newCount,
      totalPrice: newCount * unitPrice,
    ));
  }

  void decrement() {
    if (state.count > 1) {
      final newCount = state.count - 1;
      emit(state.copyWith(
        count: newCount,
        totalPrice: newCount * unitPrice,
      ));
    }
  }
}
