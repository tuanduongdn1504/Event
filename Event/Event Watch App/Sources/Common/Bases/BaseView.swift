//
//  BaseView.swift
//  Event Watch App
//
//  Created by Duong Tuan on 01/06/2025.
//

import SwiftUI

struct BaseView<Content: View, ViewModel: BaseViewModel>: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
    
    let content: Content
    let onBackAction: (() -> Void)? = nil
    
    init(viewModel: ViewModel,
         @ViewBuilder content: () -> Content) {
        self.viewModel = viewModel
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content            
            if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
                errorAlert(errorMessage: errorMessage)
            }
        }
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .disabled(viewModel.isLoading)
    }
}

extension BaseView {
    @ViewBuilder
    func errorAlert(errorMessage: String) -> some View {
        VStack {
            VStack {
                Image(WatchAppIcon.failed.rawValue)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.primary)
                    .frame(width: 40)
                
                Text(errorMessage)
                    .font(.avenirNext(size: 12, type: .regular))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, Spacing.small.rawValue)
            }
            .background(.black.opacity(0.3))
            .cornerRadius(8)
            .padding(.horizontal, Spacing.xSmall.rawValue)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.7))
    }
}
