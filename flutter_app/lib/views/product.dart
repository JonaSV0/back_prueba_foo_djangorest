import 'package:flutter/material.dart';
import 'package:proyect_footloose/models/product.dart';

class ProductView extends StatefulWidget {
  final Product product;

  const ProductView({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${widget.product.name}'),
            Text('Code: ${widget.product.code}'),
            Text('Price: ${widget.product.price}'),
            Text('Stock: ${widget.product.stock}'),
            // Agrega más detalles del producto según sea necesario
          ],
        ),
      ),
    );
  }
}
