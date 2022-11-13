//
//  LocationCardStackView.swift
//  Location
//
//  Created by Naol Hassen on 09/06/2022.
//

import SwiftUI

struct LocationCardStackView: View {
    
    @EnvironmentObject private var vm :LocationViewModel

    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    ZStack {
                        ForEach(0..<vm.locations.count, id: \.self) { index in
                            if let location = vm.locations[index] {
                                CardView(location: location, onRemove: { removedLocation in
                                    vm.locations.removeAll { $0.id == removedLocation.id }
                                })
                                .frame(width: self.getCardWidth(geometry, id: index), height: 400)
                                .offset(x: 0, y: self.getCardOffset(geometry, id: index))
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct LocationCardStackView_Previews: PreviewProvider {
    static var previews: some View {
        LocationCardStackView()
            .environmentObject(LocationViewModel())
    }
}

extension LocationCardStackView{
    /// Return the CardViews width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(vm.locations.count - 1 - id) * 10
        return geometry.size.width - offset
    }

    /// Return the CardViews frame offset for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(vm.locations.count - 1 - id) * 10
    }
    
}
