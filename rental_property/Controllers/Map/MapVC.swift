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
    var coordinate = CLLocationCoordinate2D()
    var circle = GMSCircle()
    var mapView = GMSMapView()
    var marker = GMSMarker()
    let data = Marker.data
    
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
    
    lazy var profileView: ProfileView = {
        let v = ProfileView(frame: .zero)
        return v
    }()

    lazy var gpsView: GPSView = {
        let v = GPSView(frame: .zero)
        v.delegate = self
        return v
    }()
    let markerLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textColor = .black
        lbl.font = custom(name: .medium, size: 16, style: .caption1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    func setupMapView(){
        // mapview
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView(frame: self.view.frame, camera: camera)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = false
        
        // custom map style
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
        marker.tracksInfoWindowChanges = true
        marker.map = mapView
        
        //show markers
        let infoView = InfoView(frame: .zero)
        mapView.addSubview(infoView)
        infoView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        infoView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        data.map { item in
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: item.lat, longitude: item.lng))
            marker.title = item.name
            infoView.titleLbl.text = item.name
            
            print("DEBUG:Labels \(infoView.titleLbl.text)")
            marker.iconView = infoView
            marker.map = mapView
        }
    }
    
    func setupViews(){
        view.addSubview(searchView)
        mapView.bringSubviewToFront(searchView)
        view.addSubview(profileView)
        view.addSubview(gpsView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchView.heightAnchor.constraint(equalToConstant: 58),
            
            profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileView.heightAnchor.constraint(equalToConstant: 58),
            profileView.widthAnchor.constraint(equalToConstant: 58),
            
            gpsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            gpsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            gpsView.heightAnchor.constraint(equalToConstant: 58),
            gpsView.widthAnchor.constraint(equalToConstant: 58),
        ])
    }
}

// MARK: CLLocationManagerDelegate -
extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        coordinate = location.coordinate
        mapView.camera = .init(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0, bearing: 0, viewingAngle: 10)
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

// MARK: GMSMapViewDelegate-
extension MapVC : GMSMapViewDelegate {
   
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

// MARK: DidTapGPSDelegate - 
extension MapVC: DidTapGPSDelegate {
    func didTapGPS() {
        print("DEBUG: hanlding didTapGPS...")
        let position = GMSCameraPosition(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0, bearing: 0, viewingAngle: 10)
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        mapView.animate(to: position)
    }
}
