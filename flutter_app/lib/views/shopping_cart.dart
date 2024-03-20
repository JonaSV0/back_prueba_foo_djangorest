
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyect_footloose/constantes.dart';
import 'package:proyect_footloose/services/products_service.dart';

import '../controllers/shoping_total_controller.dart';
import '../models/product.dart';
import '../services/venta_service.dart';
import '../utils/shoping_cart.dart';

class ShoppingCartView extends StatefulWidget {
  const ShoppingCartView({Key? key}) : super(key: key);

  @override
  State<ShoppingCartView> createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends State<ShoppingCartView> with WidgetsBindingObserver {
  late Future<List<Map<String, dynamic>>> _cartFuture;

  final ShoppingAmountController _filterSetAmountTotal = Get.put(ShoppingAmountController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _loadCartData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _loadCartData();
      });
    }
  }

  Future<void> _loadCartData() async {
    setState(() {
      _cartFuture = CartService.getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headerShopping(context),
          cuerpo(context),
        ],
      ),
    );
  }

  Widget headerShopping(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.refresh, color: Colors.green, size: 30.0),
              label: Text(
                "Refresh",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                _loadCartData();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.monetization_on, color: Colors.red, size: 30.0),
              label: Text(
                "Pagar",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                String? cliente = await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController controller = TextEditingController();
                    return AlertDialog(
                      title: Text('Ingresar nombre del cliente'),
                      content: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Nombre del cliente',
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, controller.text);
                          },
                          child: Text('Aceptar'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, null);
                          },
                          child: Text('Cancelar'),
                        ),
                      ],
                    );
                  },
                );

                if (cliente != null) {
                  Map<String, dynamic> result = await VentaService().generarVentaCart(cliente);

                  // Verifica si la venta se generó con éxito
                  if (result['success']) {
                    _loadCartData();
                    // Si la venta se generó con éxito, muestra un mensaje
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result['message']),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    // Si hubo un error al generar la venta, muestra un mensaje de error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result['message']),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget cuerpo(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _cartFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final cartItems = snapshot.data!;
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemWidget(item: item, loadDataCallback: () { _loadCartData(); },);
              },
            );
          }
        },
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback loadDataCallback;
  const CartItemWidget({Key? key, required this.item, required this.loadDataCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: FutureBuilder<Product>(
        future: ProductService.fetchProduct(item['id']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Cargando...');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final product = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Image.network(URL_SERVER + product.url_img), // Aquí puedes colocar la imagen del producto
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name),
                          Text('Precio: ${product.price}'),
                          Text('Cantidad: ${item['quantity']}'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await CartService.addProductToCart(item['id']);;
                              loadDataCallback();
                              // Actualizar la vista después de agregar una unidad
                            },
                            child: Icon(Icons.add),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await CartService.removeProductFromCart(item['id']);
                              loadDataCallback();
                              // Actualizar la vista después de quitar una unidad
                            },
                            child: Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

