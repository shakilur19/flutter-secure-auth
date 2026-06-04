import 'api_client.dart';
import 'dio_client.dart';

class ApiClientProvider {
  ApiClientProvider._privateConstructor();

  static final ApiClientProvider _instance = ApiClientProvider._privateConstructor();

  factory ApiClientProvider() {
    return _instance;
  }

  late final DioClient _dioClient = DioClient();
  late final ApiClient _apiClient = ApiClient(_dioClient.getClient());

  DioClient get dioClient => _dioClient;

  ApiClient get apiClient => _apiClient;
}