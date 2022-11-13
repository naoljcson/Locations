//
//  LocationDetailView.swift
//  Location
//
//  Created by Naol Hassen on 08/06/2022.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    @EnvironmentObject private var vm: LocationViewModel
    let location: Location
    var body: some View {
        ScrollView{
            VStack{
                imageSection
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                VStack(alignment: .leading, spacing: 16){
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location:LocationsDataService.locations.first!)
            .environmentObject(LocationViewModel())
    }
}

extension LocationDetailView{
    private var imageSection: some View{
        TabView{
            ForEach(location.imageNames, id: \.self){ imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width:UIScreen.main.bounds.width)
                    .clipped()
                
            }
        }
        .frame(height:500)
        .tabViewStyle(PageTabViewStyle())
        
    }
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View{
        VStack(alignment: .leading, spacing: 8){
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let url = URL(string:location.link){
                Link("Read more on wikipedia", destination: url)
                    .foregroundColor(.blue)
                    .font(.headline)
            }
            
        }
    }
    
    
    private var mapLayer: some View{
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: location.coordinates,
                                                           span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems: [location]){
            MapAnnotation(coordinate: $0.coordinates){
                LocationAnnotationView()
                    .shadow(radius: 10)
            }
        }
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(30)
            .allowsHitTesting(false)
    }
    
    private var backButton: some View{
        Button{
            vm.sheetLocation = nil
        }label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
}
