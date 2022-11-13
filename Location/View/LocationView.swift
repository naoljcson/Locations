//
//  LocationView.swift
//  Location
//
//  Created by Naol Hassen on 08/06/2022.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @EnvironmentObject private var vm : LocationViewModel
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            VStack {
                header
                    .padding()
                Spacer()
                locaationPreview
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil){ location in
            LocationDetailView(location: location)
//            LocationCardStackView()
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(LocationViewModel())
    }
}


extension LocationView{
    private var header: some View{
        VStack {
            Button(action: vm.toggleLocationList){
                Text(vm.mapLocation.name+", "+vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .frame(height:55)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading){
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                    }
            }
            if vm.showLocationList{
                LocationListView()
            }
            
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .padding()
    }
    
    
    private var mapLayer: some View{
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates){
                LocationAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var locaationPreview: some View{
        ZStack{
            ForEach(vm.locations){ location in
                if vm.mapLocation == location{
                    LocationPreviewView(currentLoaction: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                        .padding()
                }
            }
        }
    }
}
