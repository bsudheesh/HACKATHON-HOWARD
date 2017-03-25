//
//  MapViewController.swift
//  Find my Tutor
//
//  Created by Sudheesh Bhattarai on 3/24/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit
import MapKit
import Parse
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let manager = CLLocationManager()
    var count: Int?
    
    
    
    //called everytime the user location is changed
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0] //all location are stored in this array, we get the recent location
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        
        
        if count == 0{
            print("Student? ", LoginViewController.currentUserDetail as String!)
            print("longitutude : ", myLocation.longitude)
            print("lattitude : ", myLocation.longitude)
            
            
            if(LoginViewController.currentUserDetail as String! == "Student"){
                count = count! + 1
                print("Inside this function")
                Student.postUserImage( withCompletion: { _ in
                    //s MBProgressHUD.showAdded(to: self.view, animated: true)
                    print("Completed")
                    DispatchQueue.main.async {
                        print("POSTED")
                        
                    }}
                )
            }
        }
        
        //set the region
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span) //location and the span
        
        //set the map
        mapView.setRegion(region, animated: true)
        
        //add the blue dot
        self.mapView.showsUserLocation = true
 
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error", error.localizedDescription)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        
        count = 0
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
