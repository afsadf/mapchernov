//
//  MapVC.swift
//  map for chernov
//
//  Created by WSR on 28.01.2021.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let location = CLLocationManager()
    
    struct Points {
        var lat = 0.0
        var lon = 0.0
        var name = ""
    }
    var pointsArray = [Points]()
    
        func pointsPositisionalCollege(){
            let arrayLat = [55.818176, 55.844996, 55.860595, 55.860337]
            let arrayLon = [3.496261, 37.520960, 37.492089, 37.517689]
            let arrayName = ["ЦИКТ","ЦПиРБ","ЦЫВТ","ЦЕЭК"]
            for number in 0..<arrayLat.count {
                
                pointsArray.append(Points(lat: arrayLat[number], lon: arrayLon[number], name: arrayName[number]))
            }
            
            func pointPosition() {
                for number in 0..<pointsArray.count {
                    let point = MKPointAnnotation()
                    point.title = pointsArray[number].name
                    point.coordinate = CLLocationCoordinate2D(latitude: pointsArray[number].lat, longitude: pointsArray[number].lon)
                    mapView.addAnnotation(point)
                    
                }
            }
            
        }
        
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        location.delegate = self
        mapView.delegate = self
        location.stopUpdatingLocation()
        
        
        mapView.showsUserLocation = true
        mapView.userLocation.title = "im here"
        mapView.userLocation.subtitle = "you found me"
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) ->MKAnnotationView? {
        
        if annotation.coordinate.latitude != mapView.userLocation.coordinate.latitude && annotation.coordinate.longitude !=
            mapView.userLocation.coordinate.longitude{
            let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "marker")
            marker.canShowCallout = true
            let infoButton = UIButton(type: .detailDisclosure)
            infoButton.addTarget(self, action: #selector(infoAction), for: .touchUpInside)
            marker.calloutOffset = CGPoint(x: -5, y: 5)
            return marker
        }
        return nil
    }
    
    @objc func infoAction() {
        print("Info")
        
        
    }
    
    func mapToCoordinate(coordinate:CLLocationCoordinate2D)  {
        let region = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]) {
        if let location = location.last?.coordinate {
            mapToCoordinate(coordinate: location)
        }
    }
    
}




