import 'package:it_roots_task/core/constants/cache_constants.dart';
import 'package:it_roots_task/core/helpers/cache_helper.dart';

class ApiUtils {
  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': CacheHelper.getStringData(key: CacheConstants.token) ==
              null
          ? ""
          : 'Bearer ${CacheHelper.getStringData(key: CacheConstants.token)}',
    };
  }

  Map<String, String> get headersForm {
    return {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': CacheHelper.getStringData(key: CacheConstants.token) ==
              null
          ? ""
          : 'Bearer ${CacheHelper.getStringData(key: CacheConstants.token)}',
    };
  }
}
