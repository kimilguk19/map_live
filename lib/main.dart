import 'package:flutter/material.dart';
import 'package:kakao_map_sdk/kakao_map_sdk.dart'; // 외부 패키지 추가

void main() {
  runApp(KakaoMapPage());
}

class KakaoMapPage extends StatefulWidget {
  const KakaoMapPage({super.key});

  @override
  State<KakaoMapPage> createState() => _KakaoMapPageState();
}

class _KakaoMapPageState extends State<KakaoMapPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('카카오맵 예제')),
        body: KakaoMap(
          option: const KakaoMapOption(
            position: LatLng(37.566535, 126.977969), // 서울 시청을 중심으로 지도 표시
            zoomLevel: 16,
            mapType: MapType.normal,
          ),
          onMapReady: (KakaoMapController controller) {
            print("카카오 지도가 정상적으로 불러와졌습니다.");
          },
        ),
      ),
    );
  }
}
