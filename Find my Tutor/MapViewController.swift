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
    
    var tutorLocation : [(PFObject)]!
    var location: [String]!
    var locationIndex: Int!
    

    @IBOutlet weak var mapView: MKMapView!
    let manager = CLLocationManager()
    var count: Int?
    static var longitude : String?
    static var latitude : String?
    
    func getData(){
        // construct PFQuery
        locationIndex = 0
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
               
                self.tutorLocation = posts
                print("The data till now is : ", posts)
                for element in self.tutorLocation{
                    if element["occupation"] as! String! == "Tutor"{
                        
                        
                        print("The user info is : ", element)
                        var author: String!
                        var longititude: String!
                        var latitude: String!
                        
                        var fullName : String!
                        fullName = element["firstName"] as! String
                        fullName.append(" ")
                        fullName.append(element["lastName"] as! String)
                        
                        author = element["author"] as! String
                        
                        
                        
                        longititude = element["longitude"] as? String
                        latitude = element["latitude"] as? String
                        
                        if longititude != nil && latitude != nil {
                            self.getMarkers(latitude: latitude, longitude: longititude, author: fullName)
                        }
                        
                        
                        
//                        
//                        var locationDict = Dictionary<String, String>()
//                        
//                        
//                       
//                        
//                        if (element["location"] as! Dictionary<String,String>).isEmpty {
//                            locationDict = element["location"] as! Dictionary<String, String>
//                            
//                            
//                            print("The locationDict for the user is : ", locationDict)
//                            if(locationDict.count != 0){
//                                longititude = locationDict["latitude"] as! String
//                                latitude = locationDict["longitutude"] as! String
//                                
//
//                                
//                            }
//                            
//                        }

                        
                        
                        
                    }
                }
                
                // do something with the data fetched
            } else {
                print("Error! : ", error?.localizedDescription)
                // handle error
            }
            
        }
    }
    
    //called everytime the user location is changed
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0] //all location are stored in this array, we get the recent location
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        MapViewController.longitude = "\(myLocation.longitude)"
        MapViewController.latitude = "\(myLocation.latitude)"
        
        
        
        if count == 0{
            print("Student? ", LoginViewController.currentUserDetail as String!)
    
            
            
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
            else if(LoginViewController.currentUserDetail as String! == "Tutor"){
                count = count! + 1
                print("Inside this function")
                
                let query = PFQuery(className: "Post")
                query.order(byDescending: "createdAt")
                query.includeKey("author")
                
                // fetch data asynchronously
                query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
                    if let posts = posts {
                        print("User posts are : ", posts)
                    }
                }
//                var locationDict = Dictionary<String, String>()
//                locationDict["latitude"] = MapViewController.latitude!
//                locationDict["longitute"] = MapViewController.longitude!
//                ShareViewController.history["location"] = locationDict
                
                ShareViewController.latitude = MapViewController.latitude!
                ShareViewController.longitude = MapViewController.longitude!
                
              Tutor.postUserImage( withCompletion: { _ in
                   
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
    
    
    func getMarkers(latitude: String, longitude: String, author: String) -> Void {
        
        var lat: Double!
        var lon: Double!
        
         var annotation = MKPointAnnotation()
        var numberFormatter = NumberFormatter()
        var number = numberFormatter.number(from: latitude)
        
                
        lat = number?.doubleValue
        
        number = numberFormatter.number(from: longitude)
        
        lon = number?.doubleValue
        
        print("Latitude is : ", lat, "longitude is : ", lon)
        
        var location = CLLocationCoordinate2DMake(lon, lat)
        
        var span = MKCoordinateSpanMake(0.01, 0.01)
                
                
                
        var region = MKCoordinateRegion(center: location, span: span)
                
//        var correctAuthor: String!
//        var slicingIndex: Int!
//        slicingIndex = 0
//        correctAuthor = ""
//        for element in author.characters{
//            
//            if slicingIndex >= 6{
//                
//                correctAuthor = correctAuthor + String(element)
//               
//            }
//            slicingIndex = slicingIndex + 1
//        }
        
         mapView.setRegion(region, animated: true)
        
         annotation.coordinate = location
        
      
        
                
         annotation.title = author
        
        mapView.addAnnotation(annotation)

                
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        
        print("Inside the student thing")
        
        count = 0
        if LoginViewController.currentUserDetail as String! == "Tutor"{
            manager.desiredAccuracy = kCLLocationAccuracyBest //get best accuracy
            manager.requestWhenInUseAuthorization() //asking user's location in background
            manager.startUpdatingLocation() //called when location is changed

        }
        else{
            getData()
            //getMarkers()
        }
        
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
