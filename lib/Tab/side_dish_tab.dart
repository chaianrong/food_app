// import 'package:flutter/material.dart';
// import 'package:food_app/controllers/side_dish_controllers.dart';
// import 'package:get/get.dart';

// import '../Table_screen/Table1/tool/side_dish_tile.dart';

// class SideDishTab extends StatelessWidget {
//   final sideDishControllers = Get.put(SideDishControllers());
//   SideDishTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Flexible(
//         child: GridView.builder(
//           itemCount: sideDishControllers.sidedistile.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, childAspectRatio: 1 / 1.7),
//           itemBuilder: (context, index) {
//             return SideDishTabCatd(index: index);
//           },
//         ),
//       ),
//     );
//   }
// }

// class SideDishTabCatd extends StatelessWidget {
//   final SideDishControllers sideDishControllers = Get.find();
//   final int index;
//   SideDishTabCatd({super.key, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return SideDishTile(
//       itemName: sideDishControllers.sidedistile[index].itemName,
//       itemPrice: sideDishControllers.sidedistile[index].itemPrice,
//       itemPhoto: sideDishControllers.sidedistile[index].itemPhoto,
//       MunuID: sideDishControllers.sidedistile[index].MunuID,
//     );
//   }
// }
