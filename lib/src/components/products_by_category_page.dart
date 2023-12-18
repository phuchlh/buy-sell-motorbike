// import 'package:flutter/material.dart';
// import 'package:buy_sell_motorbike/src/common/constants.dart';
// import 'package:buy_sell_motorbike/src/common/utils.dart';
// import 'package:buy_sell_motorbike/src/components/product_card.dart';
// import 'package:buy_sell_motorbike/src/components/product_details.dart';
// import 'package:buy_sell_motorbike/src/components/widget_location_selector.dart';

// class ProductsByCategoryPage extends StatelessWidget {
//   const ProductsByCategoryPage({super.key, required this.categoryQuery});

//   final String categoryQuery;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: _appbar(context),
//         body: SizedBox(
//           width: double.infinity,
//           child: GridView.count(crossAxisCount: 3, childAspectRatio: (200 / 270), children: [
//             ProductCard(
//                 productName: 'Tên sản phẩm',
//                 productPrice: 10000000,
//                 productImgUrl:
//                     'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2020/10/15/845285/30_Ninja-300-Abs.jpg',
//                 productLocation: 'Q3, HCM',
//                 productDetailsNavigationCallback: pushNavigatorOnPressed(context, (_) => const ProductDetails())),
//             ProductCard(
//                 productName: 'Tên sản phẩm',
//                 productPrice: 10000000,
//                 productImgUrl:
//                     'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2020/10/15/845285/30_Ninja-300-Abs.jpg',
//                 productLocation: 'Q3, HCM',
//                 productDetailsNavigationCallback: pushNavigatorOnPressed(context, (_) => const ProductDetails())),
//             ProductCard(
//                 productName: 'Tên sản phẩm',
//                 productPrice: 10000000,
//                 productImgUrl:
//                     'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2020/10/15/845285/30_Ninja-300-Abs.jpg',
//                 productLocation: 'Q3, HCM',
//                 productDetailsNavigationCallback: pushNavigatorOnPressed(context, (_) => const ProductDetails())),
//             ProductCard(
//                 productName: 'Tên sản phẩm',
//                 productPrice: 10000000,
//                 productImgUrl:
//                     'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2020/10/15/845285/30_Ninja-300-Abs.jpg',
//                 productLocation: 'Q3, HCM',
//                 productDetailsNavigationCallback: () => {}),
//             ProductCard(
//                 productName: 'Tên sản phẩm',
//                 productPrice: 10000000,
//                 productImgUrl:
//                     'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2020/10/15/845285/30_Ninja-300-Abs.jpg',
//                 productLocation: 'Q3, HCM',
//                 productDetailsNavigationCallback: () => {})
//           ]),
//         ));
//   }

//   dynamic _appbar(BuildContext context) => PreferredSize(
//       preferredSize: const Size.fromHeight(125),
//       child: AppBar(
//         actionsIconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: DesignConstants.primaryColor,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications_outlined),
//             onPressed: () {},
//           ),
//           const LocationSelector(),
//         ],
//         title: Text(
//           'Danh mục: ${categoryQuery}',
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(10),
//           child: Container(padding: const EdgeInsets.all(10), child: _searchInput()),
//         ),
//       ));

//   Widget? _searchInput() => TextField(
//         cursorColor: Colors.black,
//         style: const TextStyle(
//           color: Colors.black,
//         ),
//         decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//             focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
//             focusColor: Colors.black,
//             floatingLabelBehavior: FloatingLabelBehavior.never,
//             prefixIcon: const Icon(Icons.search),
//             prefixIconColor: MaterialStateColor.resolveWith(
//                 (states) => states.contains(MaterialState.focused) ? Colors.black : Colors.grey.shade400),
//             labelText: 'Tìm kiếm sản phẩm'),
//       );
// }
