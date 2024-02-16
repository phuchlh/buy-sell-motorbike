import 'package:dio/dio.dart';
import '../../common/dio_client.dart';
import '../../model/response/motor_brand_response.dart';
import '../../model/response/post_response.dart';

const BRANDS = '/moto-brands';

class MotorBrandServices {
  Future<List<MotorBrand>> getBrands() async {
    try {
      final response = await DioClient.get(BRANDS);
      if (response != null) {
        return (response.data as List)
            .map((e) => MotorBrand.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load brands');
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
