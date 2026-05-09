import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/Cart_cubit/cart_cubit.dart';
import 'package:flutter_application_1/cubits/Cart_cubit/cart_state.dart' show CartState, CartLoading, CartError, CartLoaded;
import 'package:flutter_application_1/features/cart/widgets/card_items.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatefulWidget {
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
    @override
  void initState() {
    super.initState();
    // ✅ لما الصفحة تفتح جيب الكارت من الـ API
    context.read<CartCubit>().getCart();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CartError) {
            return Center(child: Text(state.message));
          }
          if (state is CartLoaded) {
            final products = state.products;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final p = products[index];
                      return CartItemCard(product: p);
                    },
                  ),
                ),
                // Subtotal
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal (${products.length} items)'),
                      Text('EGP ${context.read<CartCubit>().totalPrice}'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Checkout'),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}