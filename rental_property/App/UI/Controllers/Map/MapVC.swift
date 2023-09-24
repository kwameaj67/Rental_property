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
    var locations = [PropertyLocation]()
    var allMarkers = [GMSMarker]()
    
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
  
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(pointSize: 20,weight: .semibold)), for: .normal)
        btn.tintColor = .black
        btn.isHidden = true
        btn.alpha = 0
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 50/2
        btn.addTarget(self, action: #selector(handleBackBtn), for: .primaryActionTriggered)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var bottomView: BottomView = {
        let v = BottomView(frame: .zero)
        v.isHidden = true
        v.alpha = 0
        v.delegate = self
        v.controller = self
        v.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height/2)
        return v
    }()

    
    // MARK: Selectors -
    @objc func handleBackBtn(){
        generateHapticTouch()
        UIView.animate(withDuration: 0.3) {
            self.searchView.alpha = 1
            self.profileView.alpha = 1
            self.gpsView.alpha = 1
            self.backBtn.alpha = 0
            self.bottomView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height/2)
            
        } completion: { _ in
            self.searchView.isHidden = false
            self.profileView.isHidden = false
            self.gpsView.isHidden = false
            self.backBtn.isHidden = true
            self.bottomView.isHidden = true
            self.bottomView.alpha = 0
        }
        fetchLocations()  // reset all markers on mapview
    }
    
    // MARK: API's -
    func fetchLocations() {
        //fetch locations and show markers
        netowrkManager.fetchLocation { results, error in
            if let err = error {
                print("DEBUG: \(err.localizedDescription)")
            }
            guard let data = results else { return }
            var dict = [String: Any]()
            self.locations = data
            
            DispatchQueue.main.async(execute: {
                self.locations.forEach { item in
                    let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: item.coordinates.latitude, longitude: item.coordinates.longitude))
                    marker.title = item.name
                    marker.tracksViewChanges = false
                    marker.icon = sizeImage((UIImage(named: "circle")?.withRenderingMode(.alwaysOriginal))!, scaledToSize: .init(width: 38, height: 38))
                    marker.isFlat = true
                    dict["id"] = item.id
                    dict["name"] = item.name
                    dict["lat"] = item.coordinates.latitude
                    dict["lng"] = item.coordinates.longitude
                    marker.userData = dict
                    marker.map = self.mapView
                    
                    self.allMarkers.append(marker) // store all markers
                }
            })
        }
    }
    
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
    
    func setupViews(){
        [searchView, profileView, gpsView, backBtn, bottomView].forEach { item in
            view.addSubview(item)
        }
        mapView.bringSubviewToFront(searchView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backBtn.widthAnchor.constraint(equalToConstant: 50),
            backBtn.heightAnchor.constraint(equalToConstant: 50),
            
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
            
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.21)
        ])
    }
}

