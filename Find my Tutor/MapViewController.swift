//
//  MapViewController.swift
//  Find my Tutor
//
//  Created by Sudheesh Bhattarai on 3/24/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let manager = CLLocationManager()
    
    
    //called everytime the user location is changed
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0] //all location are stored in this array, we get the recent location
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        //set the region
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span) //location and the span
        //set the map
        mapView.setRegion(region, animated: true)
        
        //add the blue dot
        self.mapView.showsUserLocation = true
 
        
        /*
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in
            if error != nil{
                print("Error", error?.localizedDescription)
                return
            }
            else if (placemarks?.count)! > 0{
                let currentLocation = placemarks?[0]
            }
            
            
        })
    */
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error", error.localizedDescription)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        
        
        manager.desiredAccuracy = kCLLocationAccuracyBest //get best accuracy
        manager.requestWhenInUseAuthorization() //asking user's location in background
        manager.startUpdatingLocation() //called when location is changed
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
