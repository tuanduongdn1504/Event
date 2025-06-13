//
//  PrimaryButton.swift
//  Event Watch App
//
//  Created by Duong Tuan on 02/06/2025.
//

import SwiftUI

enum ButtonState {
    case `default`, success
}

struct PrimaryButton: View {
    var title: String? = nil
    var successTitle: String? = nil
    var icon: String? = nil
    var state: ButtonState? = .default
    var isEnable: Bool? = true
    var action: () -> Void
    
    var background: Color {
        switch state {
        case .success:
            return .successDefaut
        default:
            return .primaryColor
        }
    }
    
    var titleDisplay: String {
        switch state {
        case .success:
            return successTitle ?? ""
        default:
            return title ?? ""
        }
    }
    
    var body: some View {
        HStack {
            if let icon = icon, state == .success {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            Text(titleDisplay)
                .font(.avenirNext(size: 12, type: .medium))
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, minHeight: 32)
        .background(isEnable == true ? background : .grey600)
        .clipShape(.rect(cornerRadius: 6))
        .padding(.horizontal, 12)
        .onTapGesture {
            (isEnable == true) || (state == .default) ? action() : nil
        }
    }
}

#Preview {
    PrimaryButton(title: "Submit",
                  successTitle: "Submitted",
                  icon: "checkmark.circle",
                  state: .success,
                  action: {})
}
