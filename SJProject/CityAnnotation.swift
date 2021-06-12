//
//  CityAnnotation.swift
//  SJProject
//
//  Created by 王斌绩 on 2021/4/22.
//

import UIKit
import MapKit

class CityAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 35.3749183837557, longitude: 110.41241993139649)
    var title: String? = "司马迁祠";
    var subtitle: String? = "风追司马"
    
    
}
