//
//  SpashView.swift
//  Event Watch App
//
//  Created by Duong Tuan on 01/06/2025.
//

import SwiftUI

struct SpashView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color.white
                .ignoresSafeArea(.all)
            Image(WatchAppIcon.logo.rawValue)
                .resizable()
                .frame(width: 40, height: 40)
                .padding()
        }
    }
}
