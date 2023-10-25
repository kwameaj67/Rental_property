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
        marker.isTappable = false
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
        animateOnMarkerDidTap()
        generateHapticTouch()
        
//      get marker marker data from userData
        guard let data = marker.userData as? [String: Any] else { return false}
        guard let id = data["id"], let name = data["name"]  else { return false }

        bottomView.location_id = id as! Int
        bottomView.titleLbl.text = name as? String


        // hide other markers
        guard let title = marker.title else { return false }
        for (index, marker) in allMarkers.enumerated(){
            guard let markerTitle = marker.title else { return false }
            if markerTitle.lowercased() != title.lowercased(){
                UIView.animate(withDuration: 0.3) {
                    self.allMarkers[index].map = nil
                }
            }
        }
        return true
    }
    
    func animateOnMarkerDidTap(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: .curveEaseInOut){
            self.searchView.transform  = CGAffineTransform(translationX: 0, y: -150)
            self.profileView.transform = CGAffineTransform(translationX: 0, y: 100)
            self.gpsView.transform = CGAffineTransform(translationX: 0, y: 100)
            
            self.backBtn.isHidden = false
            self.backBtn.alpha = 1
            self.backBtn.transform = .identity
            
            self.bottomView.isHidden = false
            self.bottomView.alpha = 1
            self.bottomView.transform = .identity
            
        } completion: { _ in
            self.searchView.isHidden = true
            self.profileView.isHidden = true
            self.gpsView.isHidden = true

            self.bottomView.alpha = 1
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
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
}

// MARK: BottomViewDelegate -
extension MapVC: BottomViewDelegate {
    func didTapViewDetails(id: Int) {
        generateHapticTouch()
        let vc = LocationDetailVC()
        vc.location_id = id
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
        
        delay(duration: 1.0) {
            self.handleBackBtn()
        }
    }
}
