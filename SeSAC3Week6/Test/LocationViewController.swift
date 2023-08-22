//
//  LocationViewController.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/22.
//

import CoreLocation // 1. 위치 임포트
import UIKit

class LocationViewController: UIViewController {

    // 2. 위치 매니저 생성: 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 3. 위치 프로토콜 연결
        locationManager.delegate = self

        // info.plist <<< 얼럿문구를 띄워주는 메소드
        locationManager.requestAlwaysAuthorization()

        checkDeviceLocationAuthorization()
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

                self.checkCurrentLocationAuthorization(status: authorization)

            } else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다")
            }
        }
    }

    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted: print("restricted")
        case .denied: print("denied")
        case .authorizedAlways: print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .authorized: print("authorized")
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
        print("===", locations)
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