import 'package:flutter/material.dart';
import 'package:kakao_map_sdk/kakao_map_sdk.dart'; // 외부 패키지 추가

void main() {
  runApp(KakaoMapPage());
}
class Location { // 위치 검색에 사용될 모델 클래스 추가
  final String name;
  final LatLng position;
  Location(this.name, this.position);
}
class KakaoMapPage extends StatefulWidget {
  const KakaoMapPage({super.key});

  @override
  State<KakaoMapPage> createState() => _KakaoMapPageState();
}

class _KakaoMapPageState extends State<KakaoMapPage> {
  // 샘플 위치 데이터
  final List<Location> locations = [
    Location('서울 시청', const LatLng(37.566535, 126.977969)),
    Location('부산 시청', const LatLng(35.179554, 129.075642)),
    Location('카카오 스페이스', const LatLng(33.450701, 126.570667)),
  ];
  // 현재 선택된 위치
  late Location _selectedLocation;
  @override
  void initState() {
    super.initState();
    _selectedLocation = locations[0]; // 초기 위치 설정
  }
  late KakaoMapController controller; // controller 클래스 객체 생성
  // 위치데이터를 가지고 마커 오버레이를 지도에 등록합니다.
  Future<void> initializeOverlay() async {
    // 마커 이미지 변수에 저장(아래)
    var poiStyle = PoiStyle(icon: KImage.fromAsset("assets/image/location.png", 40, 60));
    for (var loc in locations) { // 지도레이어에 마커 추가하기
      await controller.labelLayer.addPoi(loc.position, style: poiStyle);
    }
    await controller.labelLayer.showAllPoi(); // 지도레이어에 마커 보이기
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('카카오맵 예제')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<Location>(
                decoration: const InputDecoration(
                  labelText: '위치 선택',
                  border: OutlineInputBorder(),
                ),
                value: _selectedLocation,
                isExpanded: true,
                onChanged: (Location? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedLocation = newValue;
                    });
                  }
                },
                items: locations.map<DropdownMenuItem<Location>>((Location location) {
                  return DropdownMenuItem<Location>(
                    value: location,
                    child: Text(location.name),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: KakaoMap(
                // key를 사용하여 KakaoMap 위젯을 다시 그리도록 합니다.
                // 이렇게 하면 option의 position 변경 시 새로운 지도를 로드합니다.
                key: ValueKey(_selectedLocation.position),
                option: KakaoMapOption(
                  position: _selectedLocation.position, // 선택된 위치로 지도 중심 설정
                  zoomLevel: 16,
                  mapType: MapType.normal,
                ),
                onMapReady: (KakaoMapController controller) {
                  print("${_selectedLocation.name} 지도가 정상적으로 불러와졌습니다.");
                  this.controller = controller; // 컨트롤러 초기화
                  initializeOverlay(); // 지도가 로딩된 후 오버레이 함수 실행
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
