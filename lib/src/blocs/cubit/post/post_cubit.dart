import 'dart:math';

import 'package:dio/dio.dart';
import 'dart:developer' as developer;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:buy_sell_motorbike/logger.dart';
import 'package:buy_sell_motorbike/src/blocs/cubit/motorbike/motorbike_cubit.dart';
import 'package:buy_sell_motorbike/src/common/configurations.dart';
import 'package:buy_sell_motorbike/src/model/motorbikedtos.dart';
import 'package:buy_sell_motorbike/src/model/request/criteria_sample.dart';
import 'package:buy_sell_motorbike/src/model/request/motorbike_post_req.dart';
import 'package:buy_sell_motorbike/src/model/response/motor_brand_response.dart';
import 'package:buy_sell_motorbike/src/model/response/post_projection_response.dart';
import 'package:buy_sell_motorbike/src/model/response/post_response.dart';
import 'package:buy_sell_motorbike/src/model/response/post_response_by_id.dart';
import 'package:buy_sell_motorbike/src/model/response/response_motorbike.dart';
import 'package:buy_sell_motorbike/src/model/response/response_user.dart';
import 'package:buy_sell_motorbike/src/pages/user_page.dart';
import 'package:buy_sell_motorbike/src/resources/remote/motorbike_services.dart';
import 'package:buy_sell_motorbike/src/resources/remote/post_services.dart';
import 'package:buy_sell_motorbike/src/model/request/motorbikevo.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostState());
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<void> getPosts(
      String searchValue, List<String?> brandSearch, String province, int size) async {
    try {
      emit(state.copyWith(status: PostStatus.loading));
      final response = await PostServices().getPosts(searchValue, brandSearch, province, size);
      if (response != null) {
        emit(state.copyWith(status: PostStatus.success, posts: response));
      } else {
        throw Exception('Failed to load posts');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  onChangeSearchString(String searchString) {
    int size = state.size;
    if (searchString.isNotEmpty) {
      emit(state.copyWith(searchString: searchString));
      List<String?> brandSearch = state.listBrand;
      getPosts(searchString, brandSearch, "", size);
    } else {
      emit(state.copyWith(searchString: searchString));
      List<String?> brandSearch = state.listBrand;
      print('brandSearch: ${brandSearch}');
      getPosts("", brandSearch, "", size);
    }
  }

  onChangeBrandList(List<String?> brandList) {
    if (brandList.isNotEmpty) {
      print('brandList not empty: ${brandList}');
      String searchString = state.searchString;
      String location = state.location;
      emit(state.copyWith(listBrand: brandList));
      getPosts(searchString, brandList, location, 10);
      return;
    } else {
      print('brandList empty: ${brandList}');
      String searchString = state.searchString;
      String location = state.location;
      emit(state.copyWith(listBrand: brandList));
      getPosts(searchString, [], location, 10);
      return;
    }
  }

  onChangeLocation(String location) {
    String locationChecked = location.endsWith('Toàn quốc') ? '' : location;
    emit(state.copyWith(location: locationChecked));
    String searchString = state.searchString;
    List<String?> brandSearch = state.listBrand;
    print('locationChecked: ${locationChecked}');
    getPosts(searchString, brandSearch, locationChecked, 10);
  }

  onChangeSize(int size) {
    String searchString = state.searchString;
    emit(state.copyWith(size: size));
    List<String?> brandSearch = state.listBrand;
    String location = state.location;
    getPosts(searchString, brandSearch, location, size);
  }

  onChangeBrandID(int? brandID) {
    emit(state.copyWith(brandID: brandID));
    print('state brandid: ${state.brandID}');
  }

  onChangeShowroomID(int? showroomID) {
    emit(state.copyWith(showroomID: showroomID));
    print('state showroomID: ${state.showroomID}');
  }

  onChangeRegistrationYear(String? registrationYear) {
    emit(state.copyWith(yearReg: registrationYear));
    print('state registrationYear: ${state.yearReg}');
  }

  onChangeOdometer(String? odometer) {
    emit(state.copyWith(odo: odometer));
    print('state odometer: ${state.odo}');
  }

  onChangeLicensePlate(String? licensePlate) {
    emit(state.copyWith(licensePlate: licensePlate));
    print('state licensePlate: ${state.licensePlate}');
  }

  onChangeMotorName(String? name) {
    emit(state.copyWith(name: name));
    print('state name: ${state.name}');
  }

  onChangeEngineSize(String? engineSize) {
    double parsedEngineSize = double.parse(engineSize ?? '0');
    emit(state.copyWith(engineSize: parsedEngineSize));
    print('state engineSize: ${state.engineSize}');
  }

  onChangeMotorType(String? motorType) {
    emit(state.copyWith(motorType: motorType));
    print('state motorType: ${state.motorType}');
  }

  onChangePrice(String? priceString) {
    double priceDouble = double.parse(priceString ?? '0');
    emit(state.copyWith(price: priceDouble));
    print('state priceDouble: ${state.price}');
  }

  onChangeDescription(String? description) {
    emit(state.copyWith(description: description));
    print('state description: ${state.description}');
  }

  onAddImageList(List<String> images) {
    emit(state.copyWith(images: images));
    print('state images: ${state.images}');
  }

  resetState() {
    emit(state.copyWith(
      brandID: null,
      showroomID: null,
      yearReg: null,
      odo: null,
      licensePlate: null,
      name: null,
      engineSize: null,
      motorType: null,
      price: null,
      description: null,
      images: [],
    ));
  }

  PostStatus checkIfEnoughData() {
    int brandID = state.brandID;
    int showroomID = state.showroomID;
    String yearReg = state.yearReg;
    String type = state.motorType;
    if (brandID == 0 || showroomID == 0 || yearReg.isEmpty || type.isEmpty) {
      emit(state.copyWith(status: PostStatus.notEnoughInfo));
      return PostStatus.notEnoughInfo;
    } else
      return PostStatus.enoughInfo;
  }

  Future<PostStatus> createPost() async {
    try {
      emit(state.copyWith(status: PostStatus.loading));
      final customerID = await SharedInstances.secureRead('customerID');

      if (customerID == null) {
        emit(state.copyWith(status: PostStatus.notLoginYet));
        return PostStatus.notLoginYet;
      } else {
        final List<MotorbikeImageDtos> dtos = <MotorbikeImageDtos>[];
        for (var i = 0; i < state.images.length; i++) {
          dtos.add(MotorbikeImageDtos(
            isThumbnail: i == 0 ? true : false,
            name: 'Ảnh xe ${i + 1}',
            url: state.images[i].toString(),
          ));
        }
        final motorVO = MotorbikeVo(
          name: state.name,
          licensePlate: state.licensePlate,
          engineSize: state.engineSize,
          description: state.description,
          condition: 'Đã sử dụng',
          odo: double.parse(state.odo),
          yearOfRegistration: state.yearReg,
          motoType: state.motorType,
          motoBrandId: state.brandID,
          customerId: int.parse(customerID ?? '0'),
          showroomId: state.showroomID,
          motorbikeImageDtos: dtos,
        );
        final cri = SampleCriteria(
          askingPrice: state.price,
          customerId: int.parse(customerID ?? '0'),
          showroomId: state.showroomID,
        );
        final json = {
          "criteria": cri.toJson(),
          "motorbikeVo": motorVO.toJson(),
        };

        print('json request: ${json}');
        developer.log('json request: ${json}', name: 'post_cubit.dart');
        developer.log('cri.toJson(): ${cri.toJson()}', name: 'post_cubit.dart');
        developer.log('motorVO.toJson(): ${motorVO.toJson()}', name: 'post_cubit.dart');
        final response = await MotorbikeServices().createSellRequestMotorbike(cri, motorVO);
        if (response == MotorbikeStatus.success) {
          emit(state.copyWith(status: PostStatus.success, addMoreStatus: PostStatus.canAddMore));
          return PostStatus.success;
        } else {
          emit(state.copyWith(
              status: PostStatus.errorPostSell, addMoreStatus: PostStatus.canAddMore));

          return PostStatus.errorPostSell;
        }
      }
    } on DioError catch (e) {
      // Handle DioError
      Logger.log('DioError: ${e.message}');
      EasyLoading.showError('Gửi yêu cầu thất bại');
      emit(state.copyWith(status: PostStatus.errorPostSell));
      return PostStatus.errorPostSell;
    } catch (e) {
      // Handle other types of errors
      Logger.log('DioError: ${e}');
      EasyLoading.showError('Gửi yêu cầu thất bại');
      emit(state.copyWith(status: PostStatus.errorPostSell));
      return PostStatus.errorPostSell;
    }
  }

  Future<void> getPostProjectionByShowroomID(String id) async {
    try {
      emit(state.copyWith(status: PostStatus.loading));
      final response = await PostServices().getPostProjectionByShowroomID(id);
      if (response != null) {
        emit(state.copyWith(status: PostStatus.success, postProjections: response));
      } else {
        throw Exception('Failed to load posts');
      }
    } on DioError catch (e) {
      throw e;
    }
  }

  Future<void> getPostByID(int id) async {
    try {
      emit(state.copyWith(status: PostStatus.loading));
      final response = await PostServices().getPostByID(id);
      if (response != null) {
        emit(state.copyWith(status: PostStatus.success, postById: response));
      } else {
        throw Exception('Failed to load posts');
      }
    } on DioError catch (e) {
      throw e;
    }
  }
}
