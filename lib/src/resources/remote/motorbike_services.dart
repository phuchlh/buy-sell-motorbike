// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/motorbike/motorbike_cubit.dart';
import 'package:buy_sell_motorbike/src/common/dio_client.dart';
import 'package:buy_sell_motorbike/src/model/motorbikedtos.dart';
import 'package:buy_sell_motorbike/src/model/request/criteria_sample.dart';
import 'package:buy_sell_motorbike/src/model/request/motorbike_post_req.dart';
import 'package:buy_sell_motorbike/src/model/request/motorbikevo.dart';
import 'package:buy_sell_motorbike/src/model/response/response_motorbike.dart';

String MOTOR = "/motorbikes";

// để tạm bên này
String SELL_REQ = "/sell-requests";

class MotorbikeServices {
  Future<List<Motorbike>?> getMotorbikes() async {
    try {
      final response = await DioClient.get(MOTOR);
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => Motorbike.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load motorbikes');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<MotorbikeStatus> createSellRequestMotorbike(
      SampleCriteria sampleCri, MotorbikeVo motorVO) async {
    try {
      final response = await DioClient.post(
        SELL_REQ,
        {
          "criteria": sampleCri.toJson(),
          "motorbikeVo": motorVO.toJson(),
        },
      );
      if (response.statusCode == 200) {
        print('create success');
        return MotorbikeStatus.success;
      } else {
        throw Exception('Failed to create');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<List<Motorbike>?> getMotorbikeByShowroomID(int id) async {
    try {
      final response = await DioClient.get(MOTOR + "?sid=$id");
      if (response.statusCode == 200) {
        return (response.data as List).map((e) => Motorbike.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load motorbikes');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<Motorbike> getMotorbikeByID(int id) async {
    try {
      final response = await DioClient.get(MOTOR + "/$id");
      if (response.statusCode == 200) {
        return Motorbike.fromJson(response.data);
      } else {
        throw Exception('Failed to load motorbikes');
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
