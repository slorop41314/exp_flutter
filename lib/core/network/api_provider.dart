import 'package:dio/dio.dart';

abstract class ApiProvider {
  Future<Response> getAllGames();
}

class ApiProviderImpl implements ApiProvider {
  final String _apiURL = "https://api.rawg.io/api";
  final String _apiKey = "207d4d3b55c14bd585269c1e32d1ea98";

  final Dio _dio = Dio();

  String _createUrl(String path) {
    return "${this._apiURL}/$path?key=${this._apiKey}";
  }

  @override
  Future<Response> getAllGames() async {
    final String finalUrl = _createUrl("games");
    return _dio.get(finalUrl);
  }
}
