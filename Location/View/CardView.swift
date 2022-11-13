//
//  CardView.swift
//  Location
//
//  Created by Naol Hassen on 09/06/2022.
//

import SwiftUI

struct CardView: View {
    let location: Location
    @State private var translation: CGSize = .zero
    @State var show = false
    
    
    
    private var onRemove: (_ location: Location) -> Void
    
    // 2
    private var thresholdPercentage: CGFloat = 0.5 // when the user has draged 50% the width of the screen in either direction
    
    // 3
    init(location: Location, onRemove: @escaping (_ location: Location) -> Void) {
        self.location = location
        self.onRemove = onRemove
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                if let imageName = location.imageNames.first{
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.75) // 3
                        .clipped()
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(location.name)
                        .font(.title)
                        .foregroundColor(.primary)
                    Text(location.cityName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .bold()
                }
                .padding(.horizontal)
            }
            // Add padding, corner radius and shadow with blur radius
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .animation(.interactiveSpring(), value: show)
            .offset(x: self.translation.width, y: 0) // 2
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                // 3
                DragGesture()
                // 4
                    .onChanged { value in
                        self.translation = value.translation
                    }.onEnded { value in
                        
                        // 6
                        // determine snap distance > 0.5 aka half the width of the screen
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                            self.onRemove(self.location)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(location: LocationsDataService.locations.first!,   onRemove: { _ in
            // do nothing
    })
            .frame(height: 400)
            .padding()
    }
}


extension CardView{
    
    
    // 4
    /// What percentage of our own width have we swipped
    /// - Parameters:
    ///   - geometry: The geometry
    ///   - gesture: The current gesture translation value
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
}
