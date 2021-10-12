import 'package:dio/dio.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps/app/data/navite_code/brackground_location.dart';
import 'package:google_maps/app/data/providers/local/authentication_client.dart';
import 'package:google_maps/app/data/providers/local/geolocator_wrapper.dart';
import 'package:google_maps/app/data/providers/remote/authentication_api.dart';
import 'package:google_maps/app/data/providers/remote/category_api.dart';
import 'package:google_maps/app/data/providers/remote/detail_api.dart';
import 'package:google_maps/app/data/providers/remote/order_api.dart';
import 'package:google_maps/app/data/providers/remote/product_api.dart';
import 'package:google_maps/app/data/providers/remote/reverse_geocode_api.dart';
import 'package:google_maps/app/data/providers/remote/routes_api.dart';
import 'package:google_maps/app/data/providers/remote/search_api.dart';
import 'package:google_maps/app/data/providers/remote/sign_up_api.dart';
import 'package:google_maps/app/data/repositories_impl/authentication_repository_impl.dart';
import 'package:google_maps/app/data/repositories_impl/brackground_location_repository_impl.dart';
import 'package:google_maps/app/data/repositories_impl/category_repository_impl.dart';
import 'package:google_maps/app/data/repositories_impl/detail_repository_impl.dart';
import 'package:google_maps/app/data/repositories_impl/order_repository_impl.dart';
import 'package:google_maps/app/data/repositories_impl/product_repository_impl.dart';
import 'package:google_maps/app/data/repositories_impl/reverse_geocode_repository_impl.dart';
import 'package:google_maps/app/data/repositories_impl/routes_repository_impl.dart';
import 'package:google_maps/app/data/repositories_impl/search_repository_impl.dart';
import 'package:google_maps/app/data/repositories_impl/sign_up_repository_impl.dart';
import 'package:google_maps/app/domain/repositories/authentication_repository.dart';
import 'package:google_maps/app/domain/repositories/category_repository.dart';
import 'package:google_maps/app/domain/repositories/detail_repository.dart';
import 'package:google_maps/app/domain/repositories/order_repository.dart';
import 'package:google_maps/app/domain/repositories/product_repository.dart';
import 'package:google_maps/app/domain/repositories/reverse_geocode_repository.dart';
import 'package:google_maps/app/domain/repositories/routes_repository.dart';
import 'package:google_maps/app/domain/repositories/search_repository.dart';
import 'package:google_maps/app/domain/repositories/sign_up_repository.dart';
import 'domain/repositories/brackground_location_repository.dart';

void injectDependencies() {
  final dio = Dio();
  final authenticationClient = AuthenticationClient(
    const FlutterSecureStorage(),
  );
  Get.i.lazyPut<GeolocatorWrapper>(
    () => GeolocatorWrapper(),
  );

  Get.i.lazyPut<ReverseGeocodeRepository>(
    () => ReverseGeocodeRepositoryImpl(
      ReverseGeocodeAPI(dio),
    ),
  );

  Get.i.lazyPut<RoutesRepository>(
    () => RoutesRepositoryImpl(
      RoutesAPI(dio),
    ),
  );

  Get.i.lazyPut<SearchRepository>(
    () => SearchRepositoryImpl(
      SearchAPI(dio),
    ),
  );

  Get.i.lazyPut<BackgroundLocationRepository>(
    () => BackgroundLocationRepositoryImpl(
      BackgroundLocation(),
    ),
  );

  Get.i.lazyPut<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      authenticationClient,
      AuthenticationAPI(dio, authenticationClient),
    ),
  );

  Get.i.lazyPut<SignUpRepository>(
    () => SignUpRepositoryImpl(
      authenticationClient,
      SignUpAPI(dio),
    ),
  );

  Get.i.lazyPut<CategoryRepository>(
    () => CategoryRepositoryImpl(
      CategoryAPI(dio, authenticationClient),
    ),
  );

  Get.i.lazyPut<ProductRepository>(
    () => ProductRepositoryImp(
      ProductAPI(dio, authenticationClient),
    ),
  );

  Get.i.lazyPut<OrderRepository>(
    () => OrderRepositoryImpl(
      OrderAPI(dio, authenticationClient),
    ),
  );

  Get.i.lazyPut<DetailRepository>(
    () => DetailRepositoryImpl(
      DetailAPI(dio, authenticationClient),
    ),
  );
}
