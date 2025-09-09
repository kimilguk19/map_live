import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart'; // Location 클래스를 사용하기 위해 임포트
import 'package:kakao_map_sdk/kakao_map_sdk.dart'; // LatLng 사용을 위해 임포트

// API 응답과 매칭될 클래스
class ApiData {
  String? fcltyNm;
  String? roadNmAddr;
  String? addr;
  num? la;
  num? lo;
  String? instlPlaceDc;
  String? wkdayOperBgngTm;
  String? wkdayOperEndTm;
  String? satOperBgngTm;
  String? satOperEndTm;
  String? hldyOperBgngTm;
  String? hldyOperEndTm;
  int? smtmUsePsbltyCo;
  String? airInjctrFrnshYn;
  String? moblphonElctcPosblYn;
  String? mngInstNm;
  String? telno;
  String? crtrYmd;

  ApiData(
    this.fcltyNm,
    this.roadNmAddr,
    this.addr,
    this.la,
    this.lo,
    this.instlPlaceDc,
    this.wkdayOperBgngTm,
    this.wkdayOperEndTm,
    this.satOperBgngTm,
    this.satOperEndTm,
    this.hldyOperBgngTm,
    this.hldyOperEndTm,
    this.smtmUsePsbltyCo,
    this.airInjctrFrnshYn,
    this.moblphonElctcPosblYn,
    this.mngInstNm,
    this.telno,
    this.crtrYmd,
  );

  // JSON에서 ApiData 객체로 변환하는 팩토리 생성자
  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      json['fcltyNm'],
      json['roadNmAddr'],
      json['addr'],
      json['la'],
      json['lo'],
      json['instlPlaceDc'],
      json['wkdayOperBgngTm'],
      json['wkdayOperEndTm'],
      json['satOperBgngTm'],
      json['satOperEndTm'],
      json['hldyOperBgngTm'],
      json['hldyOperEndTm'],
      json['smtmUsePsbltyCo'],
      json['airInjctrFrnshYn'],
      json['moblphonElctcPosblYn'],
      json['mngInstNm'],
      json['telno'],
      json['crtrYmd'],
    );
  }
}

// API 서비스를 담당하는 클래스
class ApiService {
  // API의 기본 URL
  final String _baseUrl =
      'https://apis.data.go.kr/5690000/sjElectricWheelchairFastCharger/sj_00000860?serviceKey=PLJPmKeBFGOkoxgAoLJgT962Uh0QPWijxPNQ%2Bl%2B4o24r9R%2BqbclT0Fc9xSamDrGiMYAF4CrpJLaDOsKZ%2FDoN%2Bw%3D%3D&pageIndex=1&pageUnit=20&dataTy=json&searchCondition=fclty_Nm';

  // 모든 데이터를 리스트 형태로 가져오는 메소드 (우리수업에서는 $_baseUrl만 사용하기 때문에 수정)
  Future<List<Location>> fetchAllData() async {
    final response = await http.get(Uri.parse('$_baseUrl')); // /posts 제거

    if (response.statusCode == 200) {
      // JSON 배열을 파싱합니다.
      dynamic body = jsonDecode(response.body); // JSON(문자열) 문자열을 json객체로 변환
      print(body); // 우리는 body의 items이 필요하다.
      List<dynamic> result = body['body']['items'];
      // 각 JSON 객체를 ApiData 객체로 변환합니다.
      List<ApiData> data = result
          .map((dynamic item) => ApiData.fromJson(item))
          .toList();
      List<Location> locations = data.map((ApiData apiData) {
        return Location(apiData.fcltyNm!, LatLng(apiData.la!.toDouble(), apiData.lo!.toDouble()));
      }).toList();
      for (var loc in locations) { // 디버그 결과 확인
        print(loc.name + loc.position.toString());
      }
      return locations;
    } else {
      throw Exception('Failed to load all data');
    }
  }
}
