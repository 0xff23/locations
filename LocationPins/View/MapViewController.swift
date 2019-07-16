//
//  MapViewController.swift
//  LocationPins
//
//  Created by Kirill Garetov on 7/15/19.
//  Copyright © 2019 ios. All rights reserved.
//

import UIKit
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections

class ViewController: UIViewController {
  
  let viewModel = UserLocationsViewModel(with: "")
  var mapView = NavigationMapView()
  var directionsRoute: Route?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupMapView()
  }
  
  func setupMapView() {
    mapView = NavigationMapView(frame: view.bounds)
    mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    mapView.isZoomEnabled = true
    view.addSubview(mapView)
    mapView.delegate = self
    
    //Display user location
    mapView.showsUserLocation = true
    mapView.setUserTrackingMode(.follow, animated: true)
    
    // Add long press for custom markers
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
    mapView.addGestureRecognizer(longPress)
  }
  
  func addPin(map: MGLMapView, data: [UserLocation]) {
    for object in data {
      let pin = MGLPointAnnotation()
      pin.coordinate = CLLocationCoordinate2D(latitude: object.latitude, longitude: object.longitude)
      pin.title = object.desc
      
      pin.subtitle = "\(pin.coordinate.latitude), \(pin.coordinate.longitude)"
      
      map.addAnnotation(pin)
    }
  }
  
  //MARK: Navigation methods
  @objc func didLongPress(_ sender: UILongPressGestureRecognizer) {
    guard sender.state == .began else { return }
    // Converts point where user did a long press to map coordinates
    let point = sender.location(in: mapView)
    let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
    // Create a basic point annotation and add it to the map
    let annotation = MGLPointAnnotation()
    annotation.coordinate = coordinate
    annotation.title = "Start navigation"
    mapView.addAnnotation(annotation)
    // Calculate the route from the user's location to the set destination
    calculateRoute(from: (mapView.userLocation!.coordinate), to: annotation.coordinate) { (route, error) in
      if error != nil {
        print("Error calculating route")
      }
    }
  }
  
  func calculateRoute(from origin: CLLocationCoordinate2D,
                      to destination: CLLocationCoordinate2D,
                      completion: @escaping (Route?, Error?) -> ()) {
    let origin = Waypoint(coordinate: origin, coordinateAccuracy: -1, name: "Start")
    let destination = Waypoint(coordinate: destination, coordinateAccuracy: -1, name: "Finish")
    
    // Specify that the route is intended for automobiles avoiding traffic
    let options = NavigationRouteOptions(waypoints: [origin, destination], profileIdentifier: .automobileAvoidingTraffic)
    // Generate the route object and draw it on the map
    _ = Directions.shared.calculate(options) { [unowned self] (waypoints, routes, error) in
      self.directionsRoute = routes?.first
      // Draw the route on the map after creating it
      self.drawRoute(route: self.directionsRoute!)
    }
  }
  
  func drawRoute(route: Route) {
    guard route.coordinateCount > 0 else { return }
    // Convert the route’s coordinates into a polyline
    var routeCoordinates = route.coordinates!
    let polyline = MGLPolylineFeature(coordinates: &routeCoordinates, count: route.coordinateCount)
    
    // If there's already a route line on the map, reset its shape to the new route
    if let source = mapView.style?.source(withIdentifier: "route-source") as? MGLShapeSource {
      source.shape = polyline
    } else {
      let source = MGLShapeSource(identifier: "route-source", features: [polyline], options: nil)
      
      // Customize the route line color and width
      let lineStyle = MGLLineStyleLayer(identifier: "route-style", source: source)
      lineStyle.lineColor = NSExpression(forConstantValue: #colorLiteral(red: 0.1897518039, green: 0.3010634184, blue: 0.7994888425, alpha: 1))
      lineStyle.lineWidth = NSExpression(forConstantValue: 3)
      
      // Add the source and style layer of the route line to the map
      mapView.style?.addSource(source)
      mapView.style?.addLayer(lineStyle)
    }
  }
}

extension ViewController: MGLMapViewDelegate {
  
  func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
    return true
  }
  
  func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
    // Center to NYC
    mapView.setCenter(CLLocationCoordinate2D(latitude: 40.71427, longitude: -74.00597), zoomLevel: 12, animated: true)
    addPin(map: mapView, data: viewModel.userLocations())
  }
  
  func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
    return nil
  }
  
  func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
    let alert = UIAlertController(title: annotation.title!!, message: "", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
    if mapView.userLocation?.location != nil {
      alert.addAction(UIAlertAction(title: "GO", style: .default, handler: { (action) in
        mapView.deselectAnnotation(annotation, animated: false)
        let navigationViewController = NavigationViewController(for: self.directionsRoute!)
        self.present(navigationViewController, animated: true, completion: nil)
      }))
    }
    self.present(alert, animated: true, completion: nil)
    if mapView.userLocation?.location != nil {
      calculateRoute(from: (mapView.userLocation!.coordinate), to: annotation.coordinate) { (route, error) in
        if error != nil {
          print("Error calculating route")
        }
      }
    }
    
  }
}



