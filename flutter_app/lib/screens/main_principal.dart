import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyect_footloose/views/perfil.dart';
import 'package:proyect_footloose/views/products.dart';
import 'package:proyect_footloose/views/shopping_cart.dart';
import '../utils/cart_notification.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final selectedIndex = RxInt(0);

    final screens = [
      const ProductsView(),
      const ShoppingCartView(),
      const PerfilView(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Obx(
              () => IndexedStack(
            index: selectedIndex.value,
            children: screens,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex.value,
        onTap: (value) {
          selectedIndex.value = value;
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.pest_control_rodent_outlined),
            activeIcon: const Icon(Icons.pest_control_rodent_rounded),
            label: 'Productos',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Obx(() => Text('${cartController.itemCount.value}')),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            activeIcon: const Icon(Icons.shopping_cart),
            label: 'Carrito',
            backgroundColor: colors.error,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.archive_outlined),
            activeIcon: const Icon(Icons.archive),
            label: 'Vendidos',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: 'Perfil',
            backgroundColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}