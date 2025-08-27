import 'package:dio/dio.dart';
import 'package:crm/common/helper/dio_client.dart';

abstract class BaseService {
  final Dio _dioClient = DioClient.createDio();

  Dio get dio => _dioClient;
}
