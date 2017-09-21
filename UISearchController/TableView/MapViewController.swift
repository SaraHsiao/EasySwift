//
//  MapViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/18.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var area:AreaMO!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 在 mapView 上面 show 出 尺規、指南針、交通訊息、使用者位置、大廈
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsTraffic = true
        mapView.showsUserLocation = true
        mapView.showsBuildings = true
        
        // CLGeocoder是利用地址找出經緯位置，再將經緯位子植入 placemark，placemark 是地標的意思
        // coordinate 是一個 2D 的座標
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(area.address!) { (placemarks, error) in
            guard let placemarks = placemarks else {
                print(error ?? "未知錯誤")
                return
            }
            
            let place = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = self.area.address
            annotation.subtitle = self.area.name
            
            if let location = place?.location {
                annotation.coordinate = location.coordinate
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        }
    }
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // 判斷使用者的當前位子
        if annotation is MKUserLocation {
            return nil
        }
        
        // 為了節省性能，必須重覆使用同一個標示視圖框，這個視圖框叫做 MKAnnotationView
        let id = "MyID"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id)
        
        // 如果沒有這個視圖框的時候，就初始化一個吧
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            annotationView?.canShowCallout = true
        }
        
        // 將 area 的 image 添加到視圖框的左邊
        let leftIncoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        leftIncoView.image = UIImage(data: area.image as! Data)
        annotationView?.leftCalloutAccessoryView = leftIncoView
        
        return annotationView
    }
}
