import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:proyect_footloose/constantes.dart';
//import 'package:proyect_footloose/controllers/filter_container_controller.dart';
import 'package:proyect_footloose/models/product.dart';
import 'package:proyect_footloose/services/products_service.dart';
import 'package:proyect_footloose/utils/shoping_cart.dart';
import 'package:proyect_footloose/views/filters.dart';
import 'package:proyect_footloose/views/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../utils/cart_notification.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {

  late Future<List<Product>> _futureProducts;
  final _updateProducts = RxBool(false);
  bool _shouldUpdateProducts = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    SharedPreferences.getInstance().then((prefs) {
      // Obtener los filtros guardados
      bool? filter = prefs.getBool('is_filter');

      if (filter == true) {// Actualizar el estado de _isFilterApplied
        _updateProducts.value = false;
        _updateProducts.value = true;
      }
      // Lógica para cargar los productos con filtros
      // Si no hay filtros guardados, cargar productos sin filtros
      // Actualizar _futureProducts y _shouldUpdateProducts según sea necesario
      setState(() {
        _futureProducts = ProductService.fetchProducts();
        _shouldUpdateProducts = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          header(context, _updateProducts),
          Divider(),
          Obx(() {
            // Usar Obx para escuchar cambios en _updateProducts y reconstruir el widget
            return listProducts(context, _futureProducts, _updateProducts.value);
          })
        ],
      )
    );

  }
}

Widget header(BuildContext context, RxBool _updateProducts) {
  return Container(
    color: Colors.purple,
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.qr_code, color: Colors.white),
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SimpleBarcodeScannerPage(),
                )).then((res) async {
                if (res is String) {

                  res = res.padLeft(13, '0');
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('is_qr', true);
                  prefs.setString('qr', res);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(res),
                    backgroundColor: Colors.black,
                  ));

                  _updateProducts.value = false;
                  _updateProducts.value = true;// Llama a la función _loadProducts() después de que se aplican los filtros
                }
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.filter_list, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FiltersView(),
              ),
            ).then((value) {
              if (value == true) {
                _updateProducts.value = false;
                _updateProducts.value = true;// Llama a la función _loadProducts() después de que se aplican los filtros
              }
            });
          },
        ),
      ],
    ),
  );
}

Widget listProducts(BuildContext context, Future<List<Product>> _futureProducts, bool shouldUpdate){
  return Flexible(
    child: FutureBuilder<List<Product>>(

      future: shouldUpdate ? ProductService.fetchProducts() : _futureProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un indicador de progreso mientras se cargan los productos
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Muestra un mensaje de error si ocurre un error al cargar los productos
          return Text('Error: ${snapshot.error}');
        } else {
          // Muestra la lista de productos cuando se cargan exitosamente
          List<Product> products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(URL_SERVER + product.url_img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(product.name),
                subtitle: Text('Price: ${product.price} - Stock: ${product.stock}'),
                trailing: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    print(product.id);
                    CartService.addProductToCart('${product.id}');
                  },
                ),
                onTap: () {
                  // Navegar a la pantalla de detalle del producto cuando se hace clic en el ListTile
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductView(product: product),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    ),
  );
}
