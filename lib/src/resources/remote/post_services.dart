import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'dart:developer' as developer;
import 'package:buy_sell_motorbike/src/common/dio_client.dart';
import 'package:buy_sell_motorbike/src/model/response/post_projection_response.dart';
import 'package:buy_sell_motorbike/src/model/response/post_response.dart';
import 'package:buy_sell_motorbike/src/model/response/post_response_by_id.dart';

String POST = "/posts";
String ACTIVE_STATUS = 'ACTIVE';

class PostServices {
  Future<List<Post>?> getPosts(
      String searchString, List<String?> brandSearch, String province, int size) async {
    try {
      String paging = "/paging";
      final response = await DioClient.post(POST + paging, {
        "criteria": {},
        "brandName": brandSearch,
        "searchValue": searchString,
        "province": province,
        "size": size
      });
      if (response.statusCode == 200) {
        return response.data["content"].map<Post>((e) => Post.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<List<PostProjection>?> getPostProjectionByShowroomID(String id) async {
    try {
      final response = await DioClient.get('$POST/projection/$id?status=$ACTIVE_STATUS');
      if (response.statusCode == 200) {
        return response.data.map<PostProjection>((e) => PostProjection.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<PostById> getPostByID(int id) async {
    try {
      final response = await DioClient.get('$POST/$id');
      if (response.statusCode == 200) {
        return PostById.fromJson(response.data);
      } else {
        throw Exception('Failed to load posts');
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
