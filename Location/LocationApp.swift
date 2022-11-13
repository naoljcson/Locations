//
//  LocationApp.swift
//  Location
//
//  Created by Naol Hassen on 08/06/2022.
//

import SwiftUI

@main
struct LocationApp: App {
    @State private var vm = LocationViewModel()
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}

