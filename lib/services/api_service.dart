class Constants {
  static const String baseUrl = 'http://your-backend.com/api';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String userEndpoint = '/users';
  static const String guardianEndpoint = '/guardians';
  static const String alertEndpoint = '/alerts';
}

class ApiService {
  // TODO: Implement HTTP client and API calls
  
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      // TODO: Replace with actual HTTP get
      print('GET $endpoint');
      return {};
    } catch (e) {
      print('API Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      // TODO: Replace with actual HTTP post
      print('POST $endpoint with $data');
      return {};
    } catch (e) {
      print('API Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      // TODO: Replace with actual HTTP put
      print('PUT $endpoint with $data');
      return {};
    } catch (e) {
      print('API Error: $e');
      rethrow;
    }
  }

  Future<bool> delete(String endpoint) async {
    try {
      // TODO: Replace with actual HTTP delete
      print('DELETE $endpoint');
      return true;
    } catch (e) {
      print('API Error: $e');
      rethrow;
    }
  }
}
