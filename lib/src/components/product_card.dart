// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:buy_sell_motorbike/src/components/product_details.dart';
import 'package:buy_sell_motorbike/src/model/response/post_response.dart';

import '../common/constants.dart';

class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.product, required this.productDetailsNavigationCallback});

  final Post product;
  final void Function() productDetailsNavigationCallback;

  final _priceFormat = NumberFormat("###,###.###", "vi_VN");

  _formattedPrice() {
    return _priceFormat.format(product.price);
  }

  @override
  Widget build(BuildContext context) {
    bool _isUsed =
        (product.motorbikeCondition == ('Cũ') || product.motorbikeCondition == ('Đã sử dụng'))
            ? true
            : false;
    const _usedColor = Color(0xfffff1e5);
    const _textUsedColor = Color(0xffff8252);
    const _newColor = Color(0xffebfdff);
    const _textNewColor = Color(0xff00bddb);
    String _formatOdo = NumberFormat('#,##0', 'en_US').format(product.motorbikeOdo);
    String formattedDateTime = DateFormat('dd/MM/yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(int.parse(product.createdDate!)));

    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetails(
                        id: product.id!,
                      )));
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          width: 100,
          height: 300,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(product.motorbikeThumbnail ?? ErrorConstants.ERROR_PHOTO),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(product.logoBrand ?? ErrorConstants.UPDATING),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              product.motorbikeName ?? ErrorConstants.UPDATING,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                              color: _isUsed ? _usedColor : _newColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            product.motorbikeCondition ?? ErrorConstants.UPDATING,
                            style: TextStyle(color: _isUsed ? _textUsedColor : _textNewColor),
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.grey[300],
                              ),
                              child: Text(product.yearOfRegistration.toString()),
                            ),
                            SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.grey[300],
                              ),
                              child: Text('$_formatOdo km'),
                            )
                            // Text(
                            //   ' - ${product.motorbikeModel ?? ErrorConstants.UPDATING}',
                            //   style: const TextStyle(color: DesignConstants.primaryColor),
                            // ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(),
                        Text(
                          '${_formattedPrice()} đ',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Text(formattedDateTime, style: const TextStyle(color: Colors.grey)),
                      Text(' - ', style: const TextStyle(color: Colors.grey)),
                      Text(product.location ?? "Updating",
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
