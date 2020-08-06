//
//  SignInView.swift
//  FireStore Todo
//
//  Created by phucld on 8/6/20.
//  Copyright © 2020 phucledien. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var coordinator: SignInWithAppleCoordinator?
    
    var body: some View {
        VStack {
            Text("Please sign in here")
            SignInWithAppleButton()
                .frame(width: 280, height: 44)
                .onTapGesture {
                    let coordinator = SignInWithAppleCoordinator()
                    self.coordinator = coordinator
                    coordinator.startSignInWithAppleFlow {
                        print("You successfully signed in")
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
