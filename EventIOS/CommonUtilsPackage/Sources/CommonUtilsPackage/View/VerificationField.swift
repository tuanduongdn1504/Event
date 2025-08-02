//
//  VerificationField.swift
//  
//
//  Created by Duong Tuan on 31/07/2025.
//

import SwiftUI

/// Properties
public enum CodeType: Int, CaseIterable {
    case four = 4
    case six = 6
    
    var stringValue: String {
        "\(rawValue) Digit"
    }
}

public enum TypingState {
    case typing
    case valid
    case invalid
}

public enum TextFieldStyle: String, CaseIterable {
    case roundedBorder = "Rounded Border"
    case underlined = "Underlined"
}


public struct VerificationField: View {
    public var type: CodeType
    public var style: TextFieldStyle
    @Binding public var value: String
    /// We can use this to validate the typed code!
    public var onChange: (String) async -> TypingState
    
    /// View Properties
    @State private var state: TypingState = .typing
    @State private var invalidTrigger: Bool = false
    @FocusState private var isActive: Bool
    
    public init(type: CodeType, style: TextFieldStyle = .roundedBorder, value: Binding<String>, onChange: @escaping (String) async -> TypingState) {
        self.type = type
        self.style = style
        self._value = value /// binding initializer uses the projected value
        self.onChange = onChange
        /// `state` is a @State wrapper: you MUST NOT assign to it here.
    }
    
    public var body: some View {
        let bodyContent = HStack(spacing: style == .roundedBorder ? 6 : 10) {
            ForEach(0..<type.rawValue, id: \.self) { index in
                CharacterView(index)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: value)
        .animation(.easeInOut(duration:0.2), value: isActive)
        .compositingGroup()
        
        .background {
            TextField("", text: $value)
                .focused($isActive)
                .keyboardType(.numberPad)
                .mask(alignment: .trailing) {
                    Rectangle()
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                }
                .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
        }
        .contentShape(.rect)
        .onTapGesture {
            isActive = true
        }
        /// One significant aspect of the NumberPad text fields is that they lack a return (Close) button.
        .toolbar { /// Therefore, let's implement a close button for the keyboard
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    isActive = false
                }
                .tint(Color.primary)
                .frame(maxHeight: .infinity, alignment: .trailing)
            }
        }
        
        if #available(iOS 17.0, *) {
            bodyContent
                /// onChange with inittial property for iOS 17+
                .onChange(of: value) { oldValue, newValue in
                    /// Limiting Text Length
                    value = String(newValue.prefix(type.rawValue))
                    Task { @MainActor in
                        /// For Validation Check
                        state = await onChange(value)
                        if state == .invalid {
                            invalidTrigger.toggle()
                        }
                    }
                }
                /// Invalid Phase Animator for iOS 17+ when invalidTrigger toggles
                .phaseAnimator([0, 10, -10, 10, -5, 5, 0], trigger: invalidTrigger, content: { content, offset in
                    content
                        .offset(x: offset)
                }, animation: { _ in
                        .linear(duration: 0.06)
                })
        } else {
            bodyContent
                /// onChange with perform property for pre-iOS17
                .onAppear {
                    Task { @MainActor in
                        /// For Validation Check
                        state = await onChange(value)
                        if state == .invalid {
                            invalidTrigger.toggle()
                        }
                    }
                }
                .onChange(of: value, perform: { newValue in
                    /// Limiting Text Length
                    value = String(newValue.prefix(type.rawValue))
                    Task { @MainActor in
                        /// For Validation Check
                        state = await onChange(value)
                        if state == .invalid {
                            invalidTrigger.toggle()
                        }
                    }
                })
                /// Invalid Custom ShakeEffect for pre-iOS17 when invalidTrigger toggles
                .modifier(ShakeFallbackModifier(trigger: invalidTrigger))
        }
    }
    
    /// Alternative .phaseAnimator by the fallback shake effect for pre-iOS17
    struct ShakeFallbackModifier: ViewModifier {
        let trigger: Bool
        @State private var currentOffset: CGFloat = 0
        /// The pattern you want to emulate
        private let sequence: [CGFloat] = [0, 10, -10, 10, -5, 5, 0]
        private let stepDuration: TimeInterval = 0.06

        func body(content: Content) -> some View {
            content
                .offset(x: currentOffset)
                .onChange(of: trigger) { newValue in
                    guard newValue else { return }
                    /// Sequentially apply offsets
                    Task {
                        for value in sequence {
                            withAnimation(.linear(duration: stepDuration)) {
                                currentOffset = value
                            }
                            /// wait stepDuration before next step
                            try? await Task.sleep(nanoseconds: UInt64(stepDuration * 1_000_000_000))
                        }
//                        for (idx, value) in sequence.enumerated() {
//                            let delay = stepDuration * Double(idx)
//                            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//                                withAnimation(.linear(duration: stepDuration)) {
//                                    currentOffset = value
//                                }
//                            }
//                        }
                        /// ensure final reset to zero (already in sequence, but safe)
                        let total = stepDuration * Double(sequence.count)
                        DispatchQueue.main.asyncAfter(deadline: .now() + total) {
                            withAnimation(.linear(duration: stepDuration)) {
                                currentOffset = 0
                            }
                        }
                    }
                }
        }
    }
    
    /// Individual Character View
    @ViewBuilder
    func CharacterView(_ index: Int) -> some View {
        Group {
            if style == .roundedBorder {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor(index), lineWidth: 1.2)
            } else {
                Rectangle()
                    .fill(borderColor(index))
                    .frame(height: 1)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .frame(width: style == .roundedBorder ? 50 : 40, height: 50)
        .overlay {
            /// Character
            let stringValue = string(index)
            
            if stringValue != "" {
                if #available(iOS 17.0, *) {
                    Text(stringValue)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .transition(.blurReplace)
                } else {
                    Text(stringValue)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .transition(.opacity)
                }
            }
        }
    }
    
    func string(_ index: Int) -> String {
        if value.count > index {
            let startIndex = value.startIndex
            let stringIndex = value.index(startIndex, offsetBy: index)
            
            return String(value[stringIndex])
        }
        
        return ""
    }
    
    func borderColor(_ index:Int) -> Color {
        switch state {
        /// Let's Highlight active field when the keyboard is active
        case .typing: value.count == index && isActive ? Color.primary : .gray
        case .valid: .green
        case.invalid: .red
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
            @State private var code: String = ""

            var body: some View {
                VerificationField(type: .six, style: .roundedBorder, value: $code, onChange: { result async -> TypingState in
                    if result.count < 6 {
                        return .typing
                    } else if result == "123456" {
                        return .valid
                    } else {
                        return .invalid
                    }
                })
            }
        }

    return PreviewWrapper()
}
