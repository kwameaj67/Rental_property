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

    let netowrkManager = NetworkManager.shared
    let manager = CLLocationManager()
    var coordinate = CLLocationCoordinate2D()
    var circle = GMSCircle()
    var mapView = GMSMapView()
    var marker = GMSMarker()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        fetchLocations()
        setupMapView()
        setupViews()
        setupContraints()
    }

    // MARK: Properties -
    lazy var searchView: SearchView = {
        let v = SearchView(frame: .zero)
        v.delegate = self
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
    
    lazy var markerLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textColor = .black
        lbl.font = custom(name: .medium, size: 16, style: .caption1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    lazy var infoView = InfoView(frame: .zero)
        

    func setupMapView(){
        // mapview
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView(frame: self.view.frame, camera: camera)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = false
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
        let image = UIImage(named: "map-pin")?.withRenderingMode(.alwaysOriginal)
        marker.icon = sizeImage(image!, scaledToSize: .init(width: 40, height: 40))
        marker.tracksViewChanges = true
        marker.map = mapView
             
    }
    // MARK: API's -
    func fetchLocations() {
        //fetch locations and show markers
        netowrkManager.fetchLocation { results, error in
            if let err = error {
                print("DEBUG: \(err.localizedDescription)")
            }
            guard let data = results else { return }
            var dict = [String: Int]()
            
            DispatchQueue.main.async(execute: {
                data.forEach { item in
                    let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: item.coordinates.latitude, longitude: item.coordinates.longitude))
                    marker.title = item.name
                    marker.tracksViewChanges = false
                    marker.icon = sizeImage((UIImage(named: "circle")?.withRenderingMode(.alwaysOriginal))!, scaledToSize: .init(width: 50, height: 50))
                    marker.isFlat = true
                    dict["id"] = item.id
                    marker.userData = dict
                    marker.map = self.mapView
                }
            })
        }
    }
    
    func setupViews(){
        view.addSubview(searchView)
        mapView.bringSubviewToFront(searchView)
        view.addSubview(profileView)
        view.addSubview(gpsView)
        mapView.addSubview(infoView)
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
            
            infoView.heightAnchor.constraint(equalToConstant: 60),
            infoView.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
}

