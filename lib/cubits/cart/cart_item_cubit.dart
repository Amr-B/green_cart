import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem {
  final String name;
  final String image;
  final double unitPrice;
  final int count;

  CartItem({
    required this.name,
    required this.image,
    required this.unitPrice,
    required this.count,
  });

  double get totalPrice => unitPrice * count;
}

class CartState {
  final List<CartItem> items;

  CartState({required this.items});

  double get total => items.fold(0, (sum, item) => sum + item.totalPrice);
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(items: []));

  void addItem(CartItem newItem) {
    final existing = state.items.indexWhere((i) => i.name == newItem.name);
    if (existing != -1) {
      final updated = [...state.items];
      final current = updated[existing];
      updated[existing] = CartItem(
        name: current.name,
        image: current.image,
        unitPrice: current.unitPrice,
        count: current.count + newItem.count,
      );
      emit(CartState(items: updated));
    } else {
      emit(CartState(items: [...state.items, newItem]));
    }
  }

  void updateCount(String name, int newCount) {
    final updated = state.items.map((item) {
      if (item.name == name) {
        return CartItem(
          name: item.name,
          image: item.image,
          unitPrice: item.unitPrice,
          count: newCount,
        );
      }
      return item;
    }).toList();
    emit(CartState(items: updated));
  }
}
