//
//  _5_NetflixProApp.swift
//  35.NetflixPro
//
//  Created by Data on 08.06.24.
//

import SwiftUI

@main
struct _5_NetflixProApp: App {
    
    let viewModel = ViewModel()
    @StateObject private var favoritesManager = FavoritesManager()
    init() {
        UITabBar.appearance().barTintColor = UIColor(named: "TabViewBack")
        UITabBar.appearance().backgroundColor = UIColor(named: "TabViewBack")
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "TabViewBack")
        UISegmentedControl.appearance().tintColor = UIColor(named: "accentColor")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(favoritesManager)
        }
    }
}
