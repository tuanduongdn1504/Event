//
//  RegisterView.swift
//  EventIOS
//
//  Created by Duong Tuan on 03/07/2025.
//

import SwiftUI
import PhotosUI

// MARK: Register View
struct RegisterView: View {
    // MARK: User Details
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var userName: String = ""
    @State private var userBio: String = ""
    @State private var userBioLink: String = ""
    @State private var userProfilePicData: Data?
    // MARK: View Properties
    @Environment(\.dismiss) var dismiss
    @State private var showImagePicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    var body: some View {
        VStack(spacing: 10){
            Text("Lets Register\nAccount")
                .font(.largeTitle.bold())
                .hAlign(.leading)

            Text("Hello user")
                .font(.title3)
                .hAlign(.leading)

            // MARK: For Smaller Size Optimization
            ViewThatFits {
                ScrollView(.vertical, showsIndicators: false) {
                    HelperView()
                }

                HelperView()
            }
            // MARK: Register Button
            HStack{
                Text("Already have an account?")
                    .foregroundColor(.gray)

                Button("Login Now"){
                    dismiss()
                }
                    .foregroundColor(.black)
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) {
            // MARK: Extracting UIImage From PhotoItem
            if let photoItem{
                Task{
                    do{
                        guard let imageData = try await photoItem.loadTransferable(type: Data.self) else{return}
                        // MARK: UI Must Be Update on Main Thread
                        await MainActor.run(body: {
                            userProfilePicData = imageData
                        })
                    }catch{}
                }
            }
        }
    }

    @ViewBuilder
    func HelperView()->some View{
        VStack(spacing: 12, content: {
            ZStack{
                if let userProfilePicData,let image = UIImage(data: userProfilePicData){
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                }else{
                    Image("NullProfile")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                }
            }
            .frame(width: 85, height: 85)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .contentShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                showImagePicker.toggle()
            }
            .padding(.top,25)

            TextField("Username", text: $userName)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))

            TextField("Email", text: $emailID)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))

            SecureField("Password", text: $password)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))

            TextField("About You", text: $userBio, axis: .vertical)
                .frame(minHeight: 100,alignment: .top)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))

            TextField("Email", text: $userBioLink)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))

            Button{

            } label: {
                // MARK: Login Button
                Text("Sign in")
                    .foregroundColor(.white)
                    .hAlign(.center)
                    .fillView(.black)
            }
            .padding(.top,10)
        })
    }
}


#Preview {
    RegisterView()
}
