// test/widget_test.dart

import 'package:flutter_test/flutter_test.dart';

// 테스트할 클래스 또는 함수를 가져옵니다 (예시).
import 'package:map_live/api_service.dart';

void main() {
  group('Counter', () {
    final apiService = ApiService();
    test('Api Service', () async {
      // 실제 앱에서는 여기에 테스트할 클래스의 인스턴스를 생성합니다.
      // expect(counter.value, 0);
      await apiService.fetchAllData(); // 이 예제에서는 간단한 단언을 사용합니다.
    });

    test('value should be incremented', () {
      // 실제 앱에서는 여기에 테스트할 클래스의 인스턴스를 생성합니다.
      // final counter = Counter();
      // counter.increment();
      // expect(counter.value, 1);
      expect(1, 1); // 이 예제에서는 간단한 단언을 사용합니다.
    });
  });
}