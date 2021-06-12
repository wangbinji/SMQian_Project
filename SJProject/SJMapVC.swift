//
//  SJMapVC.swift
//  SJProject
//
//  Created by 王斌绩 on 2021/4/22.
//

import UIKit
import MapKit

class SJMapVC: UIViewController {
    func someFunctionThatTakesAClosure(closure: () -> Void) {
        print("Hello World")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        func backward(firstvalue s1: String, lastvalue s2: String) -> Bool {
            return s1 > s2
        }
        
        var reversedNames = names.sorted(by: backward(firstvalue:lastvalue:))
        
        var reversedNames1 = names.sorted(by: {
            (s1: String, s2: String) -> Bool in
            return s1 > s2
        })
        
        print(reversedNames)
        print(reversedNames1)
        
        
        someFunctionThatTakesAClosure {
            print("Hello World111")
        }
        
        
        
        
        
        
        
        

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "歷史地圖"
        let view = MKMapView.init(frame: self.view.frame)
        view.showsUserLocation = true
        view.mapType = .standard
        view.delegate = self
        self.view.addSubview(view)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        
        let center = CLLocationCoordinate2D(latitude: 35.3749183837557, longitude: 110.41241993139649)
        view.setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
        
        view.addAnnotation(CityAnnotation())
        
        view.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(CityAnnotation.self))
        
//        let point01 = CLLocationCoordinate2DMake(41.000512, -109.050116);
//
//        CLLocationCoordinate2D  points[4];
            
          let point01 = CLLocationCoordinate2DMake(35.37901238710147, 110.4125504894104);
          let point02 = CLLocationCoordinate2DMake(35.379187339881355, 110.41602663229371);
          let point03 = CLLocationCoordinate2DMake(35.37656300835087, 110.41598371694947);
          let point04 = CLLocationCoordinate2DMake(35.3736936415372, 110.41594080160523);
        
        let point05 = CLLocationCoordinate2DMake(35.370474230495105, 110.41628412435914);
        let point06 = CLLocationCoordinate2DMake(35.368619511484795, 110.41452459524537);
        let point07 = CLLocationCoordinate2DMake(35.370474230495034, 110.41229299734498);
        
        let point08 = CLLocationCoordinate2DMake(35.37050922478368, 110.40825895498658);
        let point09 = CLLocationCoordinate2DMake(35.37537328327283, 110.4087310237732);
        let point010 = CLLocationCoordinate2DMake(35.374358503904304, 110.41207842062379);
        
        let points = [ point01, point02, point03, point04, point05, point06, point07, point08, point09, point010 ]
        let poly = MKPolygon.init(coordinates: points, count: 10)
        poly.title = "Colorado";
        view.addOverlay(poly)
        
        
        
        
        
        
        
            
//          MKPolygon* poly = [MKPolygon polygonWithCoordinates:points count:4];
       
//          [map addOverlay:poly];
    }

}


extension SJMapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView?
        annotationView?.annotation = CityAnnotation()
        annotationView?.canShowCallout = true
        annotationView?.image = #imageLiteral(resourceName: "flag")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("Hello World")
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolygonRenderer.init(polygon: overlay as! MKPolygon)
//        render.fillColor = UIColor.red
        render.strokeColor = UIColor.purple
        render.lineWidth = 4
        return render
        
    }
}
