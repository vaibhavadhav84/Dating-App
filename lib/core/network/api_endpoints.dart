// lib/core/network/api_endpoints.dart

class ApiEndpoints {
  ApiEndpoints._();

  static const String users = '/';
  static String usersWithResults(int count) => '/?results=$count';
  static String usersByPage(int page, int results) =>
      '/?page=$page&results=$results';
}
