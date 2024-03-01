// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../Table_screen/Table1/tool/drink_tile.dart';
// import '../controllers/drink_controllers .dart';

// class DrinkTab extends StatelessWidget {
//   final drinkControllers = Get.put(DrinkControllers());

//   DrinkTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Flexible(
//         child: GridView.builder(
//           itemCount: drinkControllers.drinktile.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, childAspectRatio: 1 / 1.7),
//           itemBuilder: (context, index) {
//             return DrinkTabCatd(index: index);
//           },
//         ),
//       ),
//     );
//   }
// }

// class DrinkTabCatd extends StatelessWidget {
//   final DrinkControllers drinkControllers = Get.find();
//   final int index;
//   DrinkTabCatd({super.key, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return DrinkTile(
//       itemName: drinkControllers.drinktile[index].itemName,
//       itemPrice: drinkControllers.drinktile[index].itemPrice,
//       itemPhoto: drinkControllers.drinktile[index].itemPhoto,
//       MunuID: drinkControllers.drinktile[index].MunuID,
//     );
//   }
// }
