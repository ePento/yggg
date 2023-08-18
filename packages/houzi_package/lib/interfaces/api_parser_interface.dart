import 'package:dio/dio.dart';
import 'package:houzi_package/models/api_response.dart';
import 'package:houzi_package/models/article.dart';
import 'package:houzi_package/models/property_meta_data.dart';
import 'package:houzi_package/models/realtor_model.dart';
import 'package:houzi_package/models/saved_search.dart';
import 'package:houzi_package/models/user.dart';

abstract class ApiParserInterface {
  Article parseArticle(Map<String, dynamic> json);
  Term parseMetaDataMap(Map<String, dynamic> json);
  Agent parseAgentInfo(Map<String, dynamic> json);
  Agency parseAgencyInfo(Map<String, dynamic> json);
  SavedSearch parseSavedSearch(Map<String, dynamic> json);
  User parseUserInfo(Map<String, dynamic> json);
  ApiResponse<String> parseNonceResponse(Response response);
}