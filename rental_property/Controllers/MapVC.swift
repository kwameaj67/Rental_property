//
//  ViewController.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/5/23.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapVC: UIViewController {

    let manager = CLLocationManager()
    var circle = GMSCircle()
    var mapView = GMSMapView()
    var marker = GMSMarker()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        setupMapView()
        setupViews()
        setupContraints()
        
    }

    // MARK: Properties -
    lazy var searchView: SearchView = {
        let v = SearchView(frame: .zero)
        v.searchTextField.inputAccessoryView = createToolBar()
        return v
    }()

    func setupMapView(){
        // mapview
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView(frame: self.view.frame, camera: camera)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        
        do{
            if let url = Bundle.main.url(forResource: "map", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: url)
            }else {
                print("DEBUG: Error ")
            }
        }
        catch {
            print("DEBUG: Error loading map style")
        }
        
        view.addSubview(mapView)
        view.pinToEdges(to: mapView)
        
        // marker
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = ""
        marker.snippet = ""
        marker.map = mapView
        
        //circle
        circle.map = nil
        let point = mapView.center
        circle.position = mapView.projection.coordinate(for: point)
        circle.fillColor = UIColor.green.withAlphaComponent(0.5)
        circle.strokeColor = .blue
        circle.strokeWidth = 2
        circle.map = mapView
    }
    func setupViews(){
        view.addSubview(searchView)
        mapView.bringSubviewToFront(searchView)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchView.heightAnchor.constraint(equalToConstant: 58),
        ])
    }
}

// MARK: CLLocationManagerDelegate -
extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let coordinate = location.coordinate
        
        mapView.camera = .init(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0, bearing: 10, viewingAngle: 45)
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

// MARK: GMSMapViewDelegate -
extension MapVC : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        circle.map = nil
//
//        let point = mapView.center
//        circle.position = mapView.projection.coordinate(for: point)
//        circle.radius = 1000.0
//        circle.fillColor = .init(hex: "#39A2C4")
//        circle.strokeColor = .init(hex: "#39A2C4")
//        circle.strokeWidth = 2.0
//        circle.map = mapView
    }
}

// MARK: UIToolbar -
extension MapVC {
    func createToolBar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let space1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let space2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let labelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        labelButton.setTitle("Done", for: .normal)
        labelButton.setTitleColor(.black, for: .normal)
        labelButton.titleLabel?.font = custom(name: .medium, size: 18, style: .headline)
        labelButton.addTarget(self, action: #selector(onDone), for: .primaryActionTriggered)
        let doneBarItem = UIBarButtonItem(customView: labelButton)
        doneBarItem.tintColor = UIColor.black
        toolbar.setItems([space1,space2,doneBarItem], animated: true)
        return toolbar
    }
    
    @objc func onDone(){
        let textField = searchView.searchTextField
        if textField.isFirstResponder{
            textField.resignFirstResponder()
        }
    }
}
