import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/Cart_cubit/cart_cubit.dart';
import 'package:flutter_application_1/features/cart/data/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemCard extends StatelessWidget {
  final CartProduct product;

  const CartItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            // صورة المنتج
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imageCover,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),

            // اسم + سعر + rating
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Price: ${product.price} EGP'),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text('${product.rating}'),
                    ],
                  ),
                ],
              ),
            ),

            // زرار الحذف + الكمية
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context.read<CartCubit>().deleteFromCart(product.id);
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        // لو عندك endpoint للكمية
                      },
                    ),
                    Text('${product.quantity}'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        context.read<CartCubit>().addToCart(product.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}