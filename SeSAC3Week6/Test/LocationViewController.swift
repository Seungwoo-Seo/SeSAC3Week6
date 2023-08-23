//
//  LocationViewController.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/22.
//

import CoreLocation // 1. 위치 임포트
import MapKit
import SnapKit
import UIKit

class LocationViewController: UIViewController {

    // 2. 위치 매니저 생성: 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()

    let mapView = MKMapView()



    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(50)
        }

        // 3. 위치 프로토콜 연결
        locationManager.delegate = self

        // info.plist <<< 얼럿문구를 띄워주는 메소드
        locationManager.requestAlwaysAuthorization()

        // ViewController를 단독으로 사용할 땐 viewDidLoad에서 호출할 필요가 없다 디폴트로 알아서 한번 호출하기 때문
        // 다만, TabBarViewController 혹은 NavigationViewController 안에 ViewController를 넣어서 사용할 땐
        // 호출이 안된다.. 걍 버그인거 같은데 결론은 일단 두 번 불리더라도 호출을 한다.
        checkDeviceLocationAuthorization()

        let center = CLLocationCoordinate2D(latitude: 37.533661, longitude: 126.963374)
        setRegionAndAnnotation(center: center)
        setAnnotation()
    }

    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        // 지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.title = "영캠이에요"
        annotation.coordinate = center

        mapView.addAnnotation(annotation)
    }

    func setAnnotation() {
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 37.517746, longitude: 126.887131)

        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 37.517857, longitude: 126.886714)

        mapView.addAnnotations([annotation1, annotation2])
    }

    func checkDeviceLocationAuthorization() {
        // iOS 위치 서비스 활성화 체크
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                // 현재 사용자의 위치 권한 상태를 가지고 옴
                let authorization: CLAuthorizationStatus
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }

                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }

            } else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다")
            }
        }
    }

    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비르를 켜주세요", preferredStyle: .alert)

        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in

            // 설정에서 직접적으로 앱 설정 화면에 들어간적이 없다면
            // 한번도 설정 앱에 들어가지 않았거나, 막 다운받은 앱이라서
            // 설정 페이지로 넘어갈지, 설정 상세 페이지
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(goSetting)
        alert.addAction(cancel)

        present(alert, animated: true)
    }

    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {

//        @frozen >> 더이상 열거형에 절대 추가될 케이스가 없다고 확신한다.. >
        // 즉, 프로즌이면 언노운 디폴트 대응이 필요가 없다

        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 얼럿, infoplist
        case .restricted: print("restricted")
        case .denied:
            print("denied")
            showLocationSettingAlert()
        case .authorizedAlways: print("authorizedAlways")
        case .authorizedWhenInUse:
            // didUpdateLocation 메서드 실행
            locationManager.startUpdatingLocation()
        case .authorized: print("authorized")
            // 위치 권한 종류가 더 생길 가능성에 대비, 현재는 없어도 나중에 생길것을 미리 대비한다고 할 수 있다
            // 내가 만든 열거형은 상관 없어 왜냐면 스스로 관리할 수 있ㅇ니까
            // 근데 애플에서 제공해주는 이런 열거형은 내가 케이스가 늘어나는지 알 수 없기 때문에 미연에 대비를 하는 것
        @unknown default: print("default")
        }
    }

}

// 4. 프로토콜 선언
extension LocationViewController: CLLocationManagerDelegate {

    // 5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            setRegionAndAnnotation(center: coordinate)
        }

        // 한 번만 위치를 업데이트 하고 싶은 경우
        locationManager.stopUpdatingLocation()
    }

    // 6. 사용자의 위치를 가지고 오지 못한 경우
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {

    }

    // 사용자의 권한 상태가 바뀔 때를 알려줌
    // 거부했다가 설정에서 변경을 했거나, 혹은 notDetermined 상태에서 허용을 했거나
    // 허용해서 위치를 가지고 오는 도중에, 설정에서 거부를 하고 앱으로 다시 돌아올 때 등
    // iOS14 이상
    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        print(#function)
        checkDeviceLocationAuthorization()
    }

    // 사용자의 권한 상태가 바뀔 때를 알려줌
    // iOS14 미만
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {

    }

}

extension LocationViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

    }

    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {


    }

//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        <#code#>
//    }
}
