// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../Table_screen/Table1/tool/coffee_tile.dart';
// import '../controllers/coffee_controllers.dart';

// class CoffeeTab extends StatelessWidget {
//   final coffeeControllers = Get.put(CoffeeControllers());

//   CoffeeTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Flexible(
//         child: GridView.builder(
//           itemCount: coffeeControllers.coffeetile.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, childAspectRatio: 1 / 1.7),
//           itemBuilder: (context, index) {
//             return OrderTabCatd(index: index);
//           },
//         ),
//       ),
//     );
//   }
// }

// class OrderTabCatd extends StatelessWidget {
//   final CoffeeControllers coffeeControllers = Get.find();
//   final int index;
//   OrderTabCatd({super.key, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return CoffeeTile(
//       itemName: coffeeControllers.coffeetile[index].itemName,
//       itemPrice: coffeeControllers.coffeetile[index].itemPrice,
//       itemPhoto: coffeeControllers.coffeetile[index].itemPhoto,
//       MunuID: coffeeControllers.coffeetile[index].MunuID,
//     );
//   }
// }
