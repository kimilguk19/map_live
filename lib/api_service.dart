import 'dart:convert';
import 'package:http/http.dart' as http;

// API 응답과 매칭될 클래스
class ApiData {
  final int userId;
  final int id;
  final String title;
  final String body;

  ApiData({
    required this.userId, required this.id,
    required this.title,
    required this.body,
  });

  // JSON에서 ApiData 객체로 변환하는 팩토리 생성자
  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

// API 서비스를 담당하는 클래스
class ApiService {
  // API의 기본 URL
  final String _baseUrl = 'https://apis.data.go.kr/5690000/sjElectricWheelchairFastCharger/sj_00000860?serviceKey=PLJPmKeBFGOkoxgAoLJgT962Uh0QPWijxPNQ%2Bl%2B4o24r9R%2BqbclT0Fc9xSamDrGiMYAF4CrpJLaDOsKZ%2FDoN%2Bw%3D%3D&pageIndex=1&pageUnit=20&dataTy=json&searchCondition=fclty_Nm';

  // 모든 데이터를 리스트 형태로 가져오는 메소드 (우리수업에서는 $_baseUrl만 사용하기 때문에 수정)
  Future<List<ApiData>> fetchAllData() async {
    final response = await http.get(Uri.parse('$_baseUrl')); // /posts 제거

    if (response.statusCode == 200) {
      // JSON 배열을 파싱합니다.
      List<dynamic> body = jsonDecode(response.body);
      // 각 JSON 객체를 ApiData 객체로 변환합니다.
      List<ApiData> data = body
          .map((dynamic item) => ApiData.fromJson(item))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load all data');
    }
  }
}