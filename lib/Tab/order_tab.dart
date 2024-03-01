// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../Table_screen/Table1/tool/order_tile.dart';
// import '../controllers/ordertile_controllers.dart';

// class OrderTab extends StatelessWidget {
//   final orderTileControllers = Get.put(OrderTileControllers());

//   OrderTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Flexible(
//         child: GridView.builder(
//           itemCount: orderTileControllers.otdertile.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
//   final OrderTileControllers orderTileControllers = Get.find();
//   final int index;
//   OrderTabCatd({super.key, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return OrderTile(
//       itemName: orderTileControllers.otdertile[index].itemName,
//       itemPrice: orderTileControllers.otdertile[index].itemPrice,
//       itemPhoto: orderTileControllers.otdertile[index].itemPhoto,
//       MunuID: orderTileControllers.otdertile[index].MunuID,
//     );
//   }
// }
