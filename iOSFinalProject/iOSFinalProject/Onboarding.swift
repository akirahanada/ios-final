//
//  Onboarding.swift
//  iOSFinalProject
//
//  Created by Akira Hanada on 2025/09/10.
//

import SwiftUI

// Global keys for UserDefaults
let kFirstName = "first_name_key"
let kLastName = "last_name_key"
let kEmail = "email_key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                // Header with Logo
                HStack {
                    Spacer()
                    Image("little-lemon-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                    Spacer()
                }
                .padding()
                .background(Color.white)
                
                // Hero Section
                VStack(alignment: .leading, spacing: 15) {
                    HStack(alignment: .top, spacing: 15) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Little Lemon")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.littleLemonYellow)
                            
                            Text("Chicago")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                .font(.body)
                                .foregroundColor(.white)
                                .lineLimit(4)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image("hero-food-image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .cornerRadius(16)
                    }
                }
                .padding()
                .background(Color.littleLemonGreen)
                
                // Form Section
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Name")
                                .font(.body)
                                .foregroundColor(.gray)
                            Text("*")
                                .font(.body)
                                .foregroundColor(.red)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("tilly", text: $firstName)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Email")
                                .font(.body)
                                .foregroundColor(.gray)
                            Text("*")
                                .font(.body)
                                .foregroundColor(.red)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("tillydoe@example.com", text: $email)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .onSubmit {
                                registerUser()
                            }
                    }
                    
                    // Register Button (appears when both fields are filled)
                    if !firstName.isEmpty && !email.isEmpty {
                        Button("Register") {
                            registerUser()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.littleLemonYellow)
                        .foregroundColor(.littleLemonDark)
                        .cornerRadius(8)
                        .fontWeight(.bold)
                        .transition(.opacity)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color.white)
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private func registerUser() {
        if !firstName.isEmpty && !email.isEmpty {
            UserDefaults.standard.set(firstName, forKey: kFirstName)
            UserDefaults.standard.set("", forKey: kLastName) // Set empty last name since we only collect first name
            UserDefaults.standard.set(email, forKey: kEmail)
            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
            isLoggedIn = true
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
