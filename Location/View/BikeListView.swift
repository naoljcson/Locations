//
//  BikeListView.swift
//  Location
//
//  Created by Naol Hassen on 10/10/2022.
//

import SwiftUI

struct BikeListView: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            VStack(alignment: .center, spacing: 30){
                HStack(spacing: 10){
                    Text("Choose Your Bike")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 100,height: 0)
                        )
                }
                .padding()
                
                Rectangle()
                
                Spacer()
            }
            .background(
                Rectangle()
                    .fill(Gradient(colors: [.black,.blue]))
                
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical)
        } else {
            // Fallback on earlier versions
        }
    }
}

struct BikeListView_Previews: PreviewProvider {
    static var previews: some View {
        BikeListView()
    }
}
