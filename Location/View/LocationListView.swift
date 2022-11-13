//
//  LocationListView.swift
//  Location
//
//  Created by Naol Hassen on 08/06/2022.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject private var vm: LocationViewModel
    var body: some View {
        List{
            ForEach(vm.locations){ location in
                Button{
                    vm.showNextLocation(location: location)
                }label: {
                    locationListRowView(location: location)
                }
                .padding(.vertical,4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .environmentObject(LocationViewModel())
    }
}

extension LocationListView{
    private func locationListRowView(location: Location)-> some View{
        HStack{
            if let imageName = location.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        }
    }
}
