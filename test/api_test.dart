import 'package:flutter_test/flutter_test.dart';

import 'package:map_live/api_service.dart';

void main() {
  ApiService apiService = ApiService(); // 객체를 생성 후 메서드를 사용가능하다.
  test('Api test', () async {
    await apiService.fetchAllData();
  });
}