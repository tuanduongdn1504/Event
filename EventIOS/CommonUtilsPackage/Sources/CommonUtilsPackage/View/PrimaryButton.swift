//
//  PrimaryButton.swift
//
//
//  Created by Duong Tuan on 20/07/2025.
//

import SwiftUI

public enum ButtonState {
    case `default`, success
}

public struct PrimaryButton: View {
    public var title: String?
    public var successTitle: String?
    public var icon: String?
    public var state: ButtonState?
    public var isEnable: Bool?
    public var action: () -> Void
    
    public init(title: String? = nil,
                successTitle: String? = nil,
                icon: String? = nil,
                state: ButtonState? = .default,
                isEnable: Bool? = true,
                action: @escaping () -> Void
    ) {
        self.title = title
        self.successTitle = successTitle
        self.icon = icon
        self.state = state
        self.isEnable = isEnable
        self.action = action
    }
    
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
    
    public var body: some View {
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
