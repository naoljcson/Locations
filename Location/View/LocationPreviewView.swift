//
//  LocationPreviewView.swift
//  Location
//
//  Created by Naol Hassen on 08/06/2022.
//

import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject private var vm: LocationViewModel
    let currentLoaction: Location
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0.0) {
            VStack(alignment: .leading, spacing: 16.0){
                imageSection
                titleSection
            }
            
            VStack(spacing: 8.0){
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y:50)
            
        )
        .cornerRadius(10)
    }
        
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPreviewView(currentLoaction: LocationsDataService.locations.first!)
    }
}


extension LocationPreviewView{
    private var imageSection: some View{
        ZStack() {
            if let imageName = currentLoaction.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
            
        }.padding(6)
            .background(.white)
            .cornerRadius(10)
    }
    
    private var titleSection: some View{
        VStack(alignment: .leading, spacing: 4.0){
            Text(currentLoaction.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(currentLoaction.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var learnMoreButton: some View{
        Button{
            vm.sheetLocation = currentLoaction
        }label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View{
        Button{
            vm.nextButtonPressed()
        }label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
