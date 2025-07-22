//
//  BaseView.swift
//
//
//  Created by Duong Tuan on 20/07/2025.
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
            if viewModel.isLoading {
                ZStack {
                    Color.white.opacity(0.3)
                    
                    ProgressView()
                        .padding()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.primaryColor))
                        .cornerRadius(15)
                        .shadow(radius: 10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .edgesIgnoringSafeArea(.all)
            }
            
            if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
                errorAlert(errorMessage: errorMessage)
            }
        }
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .disabled(viewModel.isLoading)
//        .background(.white)
    }
}

extension BaseView {
    @ViewBuilder
    func errorAlert(errorMessage: String) -> some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .toIcon()
                        .foregroundStyle(.white)
                        .padding(.vertical, Spacing.xxSmall.rawValue)
                        .padding(.trailing, Spacing.xSmall.rawValue)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                viewModel.errorMessage = nil
                            }
                        }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.grey600)
                
                Image(WatchAppIcon.failed.rawValue)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.primaryColor)
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
