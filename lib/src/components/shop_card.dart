// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:buy_sell_motorbike/src/common/constants.dart';
import 'package:buy_sell_motorbike/src/common/utils.dart';
import 'package:buy_sell_motorbike/src/model/response/showroom_response.dart';
import 'package:buy_sell_motorbike/src/pages/detail_showroom.dart';

class ShowroomCard extends StatelessWidget {
  const ShowroomCard({
    super.key,
    required this.showroom,
  });

  final Showroom showroom;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pushNavigatorOnPressed(
        context,
        (_) => DetailShowroom(ratingStar: 4.5, id: showroom.id ?? 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(118, 158, 158, 158).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Image.asset(
              ErrorConstants.DEFAULT_SHOWROOM,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  showroom.name ?? ErrorConstants.UPDATING,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  showroom.address ?? ErrorConstants.UPDATING,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey, // Adjust color as needed
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
