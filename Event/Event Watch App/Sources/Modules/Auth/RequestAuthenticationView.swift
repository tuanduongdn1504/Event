//
//  RequestAuthenticationView.swift
//  Event Watch App
//
//  Created by Duong Tuan on 02/06/2025.
//

import SwiftUI

struct RequestAuthenticationView: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    var body: some View {
        BaseView(viewModel: mainViewModel) {
            VStack {
                Text("Login Event app to continue!")
                    .font(.avenirNext(size: 14, type: .medium))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
                
                PrimaryButton(title: "Login") {
                    mainViewModel.requestAuthorization()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .background(.white)
        .onAppear {
            mainViewModel.requestAuthorization()
        }
    }
}
