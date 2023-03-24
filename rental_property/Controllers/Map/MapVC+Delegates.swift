//
//  MapVC+Delegates.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/6/23.
//

import UIKit
import GoogleMaps




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
   
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        UIView.animate(withDuration: 0.5) {

        } completion: { _ in
            self.marker.tracksViewChanges = false
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let data = marker.userData as! PropertyLocation
        //print("You tapped at \(data)")
        let vc = LocationDetailVC()
        vc.location_id = data.id
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
        return true
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

// MARK: DidTapGPSDelegate -
extension MapVC: DidTapGPSDelegate {
    func didTapGPS() {
        print("DEBUG: hanlding didTapGPS...")
        let position = GMSCameraPosition(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0, bearing: 0, viewingAngle: 10)
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        mapView.animate(to: position)
    }
}


// MARK: DidTapFilterButtonDelegate -
extension MapVC: DidTapFilterButtonDelegate {
    func didTapFilterButton() {
        print("DEBUG: hanlding didTapFilterButton...")
        let vc = FilterVC()
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
}
