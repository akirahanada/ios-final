//
//  ContentView.swift
//  iOSFinalProject
//
//  Created by Akira Hanada on 2025/09/10.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
    
    var body: some View {
        Group {
            if isLoggedIn {
                Home()
            } else {
                Onboarding()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)) { _ in
            isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
