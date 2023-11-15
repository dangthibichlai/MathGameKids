// ///
// /// nút trong danh muc
// ///
// Widget _sanPhamDanhMucBtn(BuildContext context, Image image, String label,
//     int money, HomeController controller) {
//   return SizedBox(
//       height: 280,
//       width: Dimensions.SQUARE_CATEGORY_SIZE,
//       child: GestureDetector(
//         onTap: () {
//           controller.onProductClick();
//         },
//         child: Column(
//           children: [
//             Container(
//                 alignment: Alignment.topLeft,
//                 child: ClipRRect(
//                     // borderRadius: BorderRadius.circular(20),
//                     child: image)),
//             const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
//             Container(
//               alignment: Alignment.topLeft,
//               child: Text(
//                 label,
//                 style: const TextStyle(
//                     color: Color(0xFF27272A),
//                     fontSize: Dimensions.FONT_SIZE_LARGE),
//               ),
//             ),
//             const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
//             Container(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 PriceConverter.convertPrice(context, money.toDouble()),
//                 style: const TextStyle(
//                   color: Color(0xFF27272A),
//                   fontSize: Dimensions.FONT_SIZE_LARGE,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ));
// }

// Widget _sanPhamMoi(BuildContext context, HomeController controller) {
//   return CategoryWidget(
//     hasMore: true,
//     label: 'Sản phẩm mới',
//     content: Column(children: [
//       Row(children: [
//         _sanPhamDanhMucBtn(
//           context,
//           Image.asset(
//             Images.sp3,
//             width: Dimensions.SQUARE_CATEGORY_SIZE,
//             height: Dimensions.SQUARE_CATEGORY_SIZE,
//           ),
//           'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
//           138000,
//           controller,
//         ),
//         const Spacer(),
//         _sanPhamDanhMucBtn(
//           context,
//           Image.asset(
//             Images.sp4,
//             width: Dimensions.SQUARE_CATEGORY_SIZE,
//             height: Dimensions.SQUARE_CATEGORY_SIZE,
//           ),
//           'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
//           138000,
//           controller,
//         ),
//       ]),
//       const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT * 2),
//       Row(children: [
//         _sanPhamDanhMucBtn(
//           context,
//           Image.asset(
//             Images.sp3,
//             width: Dimensions.SQUARE_CATEGORY_SIZE,
//             height: Dimensions.SQUARE_CATEGORY_SIZE,
//           ),
//           'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
//           138000,
//           controller,
//         ),
//         const Spacer(),
//         _sanPhamDanhMucBtn(
//           context,
//           Image.asset(
//             Images.sp4,
//             width: Dimensions.SQUARE_CATEGORY_SIZE,
//             height: Dimensions.SQUARE_CATEGORY_SIZE,
//           ),
//           'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
//           138000,
//           controller,
//         ),
//       ])
//     ]),
//   );
// }

// Widget _sanPhamThinhHanh(BuildContext context, HomeController controller) {
//   return CategoryWidget(
//     hasMore: true,
//     label: 'Sản phẩm thịnh hành',
//     content: Column(children: [
//       Row(children: [
//         _sanPhamDanhMucBtn(
//           context,
//           Image.asset(
//             Images.sp3,
//             width: Dimensions.SQUARE_CATEGORY_SIZE,
//             height: Dimensions.SQUARE_CATEGORY_SIZE,
//           ),
//           'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
//           138000,
//           controller,
//         ),
//         const Spacer(),
//         _sanPhamDanhMucBtn(
//           context,
//           Image.asset(
//             Images.sp4,
//             width: Dimensions.SQUARE_CATEGORY_SIZE,
//             height: Dimensions.SQUARE_CATEGORY_SIZE,
//           ),
//           'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
//           138000,
//           controller,
//         ),
//       ]),
//       const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT * 2),
//       Row(children: [
//         _sanPhamDanhMucBtn(
//           context,
//           Image.asset(
//             Images.sp3,
//             width: Dimensions.SQUARE_CATEGORY_SIZE,
//             height: Dimensions.SQUARE_CATEGORY_SIZE,
//           ),
//           'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
//           138000,
//           controller,
//         ),
//         const Spacer(),
//         _sanPhamDanhMucBtn(
//           context,
//           Image.asset(
//             Images.sp4,
//             width: Dimensions.SQUARE_CATEGORY_SIZE,
//             height: Dimensions.SQUARE_CATEGORY_SIZE,
//           ),
//           'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
//           138000,
//           controller,
//         ),
//       ])
//     ]),
//   );
// }



// ////categories
// ///
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:template/utils/color_resources.dart';
// import 'package:template/utils/device_utils.dart';
// import 'package:template/utils/dimensions.dart';
// import 'package:template/view/screen/categories/categories_controller.dart';
// import 'package:template/view/screen/categories/component/category_item.dart';

// class CategoriesPage extends GetView<CategoriesController> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CategoriesController>(
//         init: CategoriesController(),
//         builder: (CategoriesController value) {
//           return Scaffold(
//             backgroundColor: ColorResources.WHITE,
//             appBar: AppBar(
//               elevation: 1,
//               iconTheme: const IconThemeData(color: ColorResources.BLACK),
//               title: const Text(
//                 "Danh mục",
//                 style: TextStyle(color: ColorResources.BLACK),
//               ),
//               backgroundColor: ColorResources.WHITE,
//             ),
//             body: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: DeviceUtils.getScaledSize(context, 0.254),
//                   height: double.infinity,
//                   margin: const EdgeInsets.only(top: 3),
//                   decoration: const BoxDecoration(
//                     color: Color(0xffF5F5FA),
//                   ),
//                   child: ListView.builder(
//                       physics: const BouncingScrollPhysics(),
//                       padding: EdgeInsets.zero,
//                       itemCount: controller.categoriesName.length,
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                             onTap: () {
//                               controller.changeSelectedIndex(index);
//                             },
//                             child: CategoryItem(
//                               title: controller.categoriesName[index],
//                               icon: const Icon(
//                                 Icons.person,
//                                 color: ColorResources.WHITE,
//                               ),
//                               isSelected:
//                                   controller.categorySelectedIndex == index,
//                             ));
//                       }),
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.symmetric(
//                           horizontal:
//                               DeviceUtils.getScaledHeight(context, 0.02)),
//                       margin: EdgeInsets.symmetric(
//                           horizontal: DeviceUtils.getScaledSize(context, 0.04),
//                           vertical: DeviceUtils.getScaledSize(context, 0.05)),
//                       decoration: BoxDecoration(
//                         color: ColorResources.WHITE,
//                         borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 2,
//                             color: Colors.grey.withOpacity(0.3),
//                             spreadRadius: 2, // Shadow position
//                           ),
//                         ],
//                       ),
//                       child: Column(children: [
//                         SizedBox(
//                             height: DeviceUtils.getScaledSize(context, 0.025)),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Chi tiết",
//                               style: Dimensions.fontSizeStyle20()
//                                   .copyWith(color: ColorResources.PRIMARY),
//                             ),
//                             GestureDetector(
//                               onTap: () => controller.onBtnDetailClick(),
//                               child: const Icon(Icons.arrow_forward_ios,
//                                   color: ColorResources.PRIMARY),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                             height: DeviceUtils.getScaledSize(context, 0.04)),
//                         ...List.generate(
//                           controller.myCategories.length,
//                           (index) => Column(
//                             children: [
//                               Container(
//                                 height: DeviceUtils.getScaledSize(context, 0.4),
//                                 width: DeviceUtils.getScaledSize(context, 0.4),
//                                 alignment: Alignment.center,
//                                 decoration: const BoxDecoration(
//                                   color: Colors.amberAccent,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
//                                   image: DecorationImage(
//                                       image: AssetImage(
//                                           "assets/images/Untitled.png"),
//                                       fit: BoxFit.fill),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: DeviceUtils.getScaledSize(
//                                         context, 0.03)),
//                                 child: Text(controller.categoriesName[
//                                         controller.categorySelectedIndex] +
//                                     controller.myCategories[index]['name']
//                                         .toString()),
//                               ),
//                             ],
//                           ),
//                         ).toList()
//                       ]),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }

