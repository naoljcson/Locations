//
//  LocationAnnotationView.swift
//  Location
//
//  Created by Naol Hassen on 08/06/2022.
//

import SwiftUI

struct LocationAnnotationView: View {
    let accentColor = Color("AccentColor")
    var body: some View {
        VStack(spacing: 0.0){
            Image(systemName: "map.circle.fill")
                 .resizable()
                 .scaledToFit()
                 .frame(width: 30, height: 30)
                 .foregroundColor(.white)
                 .font(.headline)
                 .padding(6)
                 .background(accentColor)
                 .cornerRadius(36)
             
             Image(systemName: "triangle.fill")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 10, height: 10)
                  .foregroundColor(accentColor)
                  .rotationEffect(Angle(degrees: 180))
                  .padding(.bottom, 40)
                  .offset(y:-3)
                  
        }
    }
}

struct LocationAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationAnnotationView()
    }
}
