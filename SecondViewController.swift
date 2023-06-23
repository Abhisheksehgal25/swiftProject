//
//  SecondViewController.swift
//  CollageApp
//
//  Created by Abhishek Sehgal on 10/05/23.
//

import UIKit
import Firebase
import MapKit

class SecondViewController: UIViewController, MKMapViewDelegate , CLLocationManagerDelegate {
    
    var data = ""
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userID: UILabel!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        userID.text = "[ \(data) ]"
     
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Do any additional setup after loading the view.
    }
    
    
    // location fields
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: 30.516304, longitude: 76.659767 )
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Chitkara University"
        self.mapView.addAnnotation(annotation)
    }
    
//    @IBAction func logoutClicked(_ sender: Any) {
//        do{
//            try Auth.auth().signOut()
//            self.performSegue(withIdentifier: String, sender: nil)
//        }
//        catch{
//            print("error")
//        }
//    }
    

}
