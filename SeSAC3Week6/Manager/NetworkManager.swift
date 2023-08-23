//
//  NetworkManager.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/24.
//

import Alamofire
import Foundation

final class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetchData(
        completion: @escaping ([Cinema]) -> ()
    ) {
        let url = "http://openapi.seoul.go.kr:8088/\(APIKey.cinema)/json/LOCALDATA_031302/0/900"
        AF
            .request(url, method: .get)
            .validate()
            .responseDecodable(
                of: CinemaContainerContainer.self
            ) { response in
                switch response.result {
                case .success(let container):
                    let cinemaList = container.cinemaContainer.cinemaList
                    completion(cinemaList)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }

    func fetchKakaoAPIResponse(
        x: Double,
        y: Double,
        completion: @escaping (Double, Double) -> ()
    ) {
        let url = "https://dapi.kakao.com/v2/local/geo/transcoord.json?x=\(x)&y=\(y)&input_coord=TM&output_coord=WGS84"

        let headers: HTTPHeaders = ["Authorization": APIKey.kakao]

        print(url)
        AF
            .request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(
                of: CoordinateContainer.self
            ) { response in
                switch response.result {
                case .success(let container):
                    guard let coordinate = container.coordinateList.first else {return}
                    completion(coordinate.x, coordinate.y)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }

    func fetchFlow() {
        let group = DispatchGroup()

        group.enter()
        fetchData { cinemaList in
            for cinema in cinemaList {
                // TODO: API에 요청을 900개를 보낸다?ㅋㅋㅋ....흠
                // 1. 서드파티를 찾는다
                // 2. 계산법을 찾는다
                // 3. 요청 한번에 900개를 보낼 수 있는 api를 찾는다?
//                self.fetchKakaoAPIResponse(
//                    x: cinema.xDouble,
//                    y: cinema.yDouble
//                ) { x, y in
//
//                }
            }
        }
    }

}
