//
//  SignInWithAppleButton.swift
//  FireStore Todo
//
//  Created by phucld on 8/6/20.
//  Copyright © 2020 phucledien. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleButton: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
}
