//
//  MapViewController.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/23.
//

import CoreLocation
import MapKit
import SnapKit
import UIKit

final class MapViewController: UIViewController {
    // MARK: - View
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let barbuttonItem = UIBarButtonItem(
            title: "필터",
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButtonItem)
        )

        return barbuttonItem
    }()
    private let mapView = MKMapView()

    // MARK: - Data
    private var cinemaList: [Cinema] = []

    // MARK: - Manager
    let locationManager = CLLocationManager()
    let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAttributes()
        configureHierarchy()
        bind()
    }

    func bind() {
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

                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }

            } else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다")
            }
        }
    }

    func checkCurrentLocationAuthorization(
        status: CLAuthorizationStatus
    ) {
        switch status {
        case .notDetermined:
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted: print("restricted")
        case .denied:
            print("denied")
//            showLocationSettingAlert()
        case .authorizedAlways: print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            // didUpdateLocation 메서드 실행
            locationManager.startUpdatingLocation()
        case .authorized: print("authorized")
        @unknown default: print("default")
        }
    }


    func setRegionAndAnnotation(
        center: CLLocationCoordinate2D
    ) {
        // 지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(
            center: center,
            latitudinalMeters: 400,
            longitudinalMeters: 400
        )
        mapView.setRegion(
            region,
            animated: true
        )

        let customAnnotaion = CustomAnnotation(title: "테스트에~", coordinate: center)
        
        let annotation = MKPointAnnotation()
        annotation.title = "영캠이에요"
        annotation.coordinate = center

        mapView.addAnnotation(customAnnotaion)
    }

}

extension MapViewController: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        checkDeviceLocationAuthorization()
        print("승인 상태 변경됨")
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        print("들어옴")
        // 마지막 위치 정보를 가져온다.
        if let coordinate = locations.last?.coordinate {
            print("위치 있음")
            setRegionAndAnnotation(center: coordinate)
        }

        locationManager.stopUpdatingLocation()
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("못가져옴")
    }

}

extension MapViewController: MKMapViewDelegate {

    func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {return nil}

        var annotationView: MKAnnotationView?
        if let annotation = annotation as? CustomAnnotation {
            annotationView = setupCustomAnnotationView(
                for: annotation,
                on: mapView
            )
        }

        return annotationView
    }

    private func setupCustomAnnotationView(
        for annotation: CustomAnnotation,
        on mapView: MKMapView
    ) -> MKAnnotationView {
        let reuseIdentifier = NSStringFromClass(CustomAnnotation.self)
        let flagAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation)

        flagAnnotationView.canShowCallout = true

        // Provide the annotation view's image.
        let image = UIImage(systemName: "heart.fill")!
        flagAnnotationView.image = image

        // Provide the left image icon for the annotation.

        // Offset the flag annotation so that the flag pole rests on the map coordinate.
        let offset = CGPoint(x: image.size.width / 2, y: -(image.size.height / 2) )
        flagAnnotationView.centerOffset = offset

        return flagAnnotationView
    }

}

// ui
extension MapViewController {

    func configureAttributes() {
        locationManager.delegate = self
        mapView.delegate = self
        mapView.register(
            CustomAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: NSStringFromClass(CustomAnnotation.self)
        )
    }

    func configureHierarchy() {
        navigationItem.rightBarButtonItem = rightBarButtonItem
        view.addSubview(mapView)

        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

// event
extension MapViewController {

    @objc
    func didTapRightBarButtonItem(
        _ sender: UIBarButtonItem
    ) {
        presentActionSheet()
    }

}

// 화면전환
extension MapViewController {

    func presentActionSheet() {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )

        let cancel = UIAlertAction(
            title: "취소",
            style: .cancel
        )
        let megabox = UIAlertAction(
            title: "메가박스",
            style: .default
        )
        let lotteCinema = UIAlertAction(
            title: "롯데시네마",
            style: .default
        )
        let cgv = UIAlertAction(
            title: "CGV",
            style: .default
        )
        let all = UIAlertAction(
            title: "전체보기",
            style: .default
        )
        [cancel, megabox, lotteCinema, cgv, all].forEach { alert.addAction($0) }

        present(alert, animated: true)
    }

}
