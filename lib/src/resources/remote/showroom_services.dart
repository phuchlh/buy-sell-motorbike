import 'package:dio/dio.dart';
import '../../common/dio_client.dart';
import '../../model/response/showroom_response.dart';

String SHOWROOM = '/showrooms';

class ShowroomServices {
  Future<List<Showroom>?> getShowrooms() async {
    try {
      final response = await DioClient.get(SHOWROOM);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => Showroom.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load showrooms');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<Showroom> getShowroomById(String id) async {
    try {
      final response = await DioClient.get('/showrooms/$id');
      if (response.statusCode == 200) {
        return Showroom.fromJson(response.data);
      } else {
        throw Exception('Failed to load showroom');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<List<Showroom>?> getShowroomsPaging(
      String searchValue, String location) async {
    try {
      final response = await DioClient.post('$SHOWROOM/paging',
          {"criteria": {}, "searchValue": searchValue, "province": location});
      if (response.statusCode == 200) {
        return (response.data["content"] as List)
            .map((e) => Showroom.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load showrooms');
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
