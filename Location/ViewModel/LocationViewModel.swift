//
//  LocationViewModel.swift
//  Location
//
//  Created by Naol Hassen on 08/06/2022.
//

import SwiftUI
import MapKit


class LocationViewModel: ObservableObject{
    
    @Published var locations: [Location]{
        didSet{
            if locations.isEmpty{
                locations = Array(LocationsDataService.locations.dropFirst())
            }
        }
    }
    
    @Published var cardLocations: [Location]
    
    @Published var mapLocation: Location{
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    @Published var showLocationList: Bool = false
    
    @Published var sheetLocation: Location? = nil
    
    let mapSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.cardLocations = locations
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span:  mapSpan)
        }
    }
    
     func toggleLocationList(){
         withAnimation(.easeInOut){
             showLocationList.toggle()
         }
    }
    
    func showNextLocation(location: Location){
        withAnimation(.easeInOut){
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed(){
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation }) else {return}
        
        let nextIndex = currentIndex + 1
        
        guard locations.indices.contains(nextIndex) else{
            guard let firstLocation = locations.first else {return}
            showNextLocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
    func getTopFourLocation()-> [Location]{
        return Array(locations.prefix(4))
    }
   
}
