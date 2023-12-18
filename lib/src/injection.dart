import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'src/data/local/dao/store_dao.dart';
// import 'src/data/remote/api_service/api_service.dart';
// import 'src/data/remote/firebase/firebase_service.dart';

final getIt = GetIt.instance;

// @InjectableInit()
// void setup() async => await getIt.init();

@module
abstract class InjectionModule {
  @lazySingleton
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  // @lazySingleton
  // @preResolve
  // Future<CoffeeDatabase> get database =>
  //     $FloorCoffeeDatabase.databaseBuilder('coffee_database.db').build();

  // @lazySingleton
  // UserDao get userDao => getIt<CoffeeDatabase>().userDao;

  // @lazySingleton
  // StoreDao get storeDao => getIt<CoffeeDatabase>().storeDao;

  // @lazySingleton
  // Dio get dio => Dio(BaseOptions(contentType: "application/json"));

  // @lazySingleton
  // ApiService get apiService => ApiService(getIt<Dio>());

  // @lazySingleton
  // FirebaseService get firebaseService => FirebaseService(getIt<Dio>());
}
