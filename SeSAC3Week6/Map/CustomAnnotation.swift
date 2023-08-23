//
//  CustomAnnotation.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/23.
//

import Foundation
import MapKit

final class CustomAnnotation: NSObject, MKAnnotation {

    var title: String?
    @objc dynamic var coordinate: CLLocationCoordinate2D


    init(
        title: String,
        coordinate: CLLocationCoordinate2D
    ) {
        self.title = title
        self.coordinate = coordinate
    }
}

final class CustomAnnotationView: MKAnnotationView {
    static let identifier = "CustomAnnotationView"

    override init(
        annotation: MKAnnotation?,
        reuseIdentifier: String?
    ) {
        super.init(
            annotation: annotation,
            reuseIdentifier: reuseIdentifier
        )

        backgroundColor = .blue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
