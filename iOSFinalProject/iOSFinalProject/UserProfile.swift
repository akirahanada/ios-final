//
//  UserProfile.swift
//  iOSFinalProject
//
//  Created by Akira Hanada on 2025/09/10.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    @Binding var selectedTab: Int
    
    let firstName = UserDefaults.standard.string(forKey: kFirstName)
    let lastName = UserDefaults.standard.string(forKey: kLastName)
    let email = UserDefaults.standard.string(forKey: kEmail)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header with back button and avatar
                HStack {
                    Button(action: {
                        selectedTab = 0  // Switch to Menu tab (Home screen)
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.littleLemonGreen)
                    }
                    
                    Spacer()
                    
                    Text("Personal information")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "person.circle")
                        .font(.title)
                        .foregroundColor(.littleLemonGreen)
                }
                .padding()
                    
                    // Profile Image Section
                    VStack(spacing: 15) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(.littleLemonOrange)
                        
                        HStack(spacing: 15) {
                            Button("Change") {
                                // Change photo action
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.littleLemonGreen)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                            .font(.system(size: 14, weight: .medium))
                            
                            Button("Remove") {
                                // Remove photo action
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.littleLemonGray)
                            .foregroundColor(.littleLemonDark)
                            .cornerRadius(6)
                            .font(.system(size: 14, weight: .medium))
                        }
                    }
                    
                    // Form Fields
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("First name")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                            Text(firstName ?? "")
                                .font(.system(size: 16))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.littleLemonGray)
                                .cornerRadius(8)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Last name")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                            Text(lastName ?? "")
                                .font(.system(size: 16))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.littleLemonGray)
                                .cornerRadius(8)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Email")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                            Text(email ?? "")
                                .font(.system(size: 16))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.littleLemonGray)
                                .cornerRadius(8)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Phone number")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                            Text("(312) 555-0123")
                                .font(.system(size: 16))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.littleLemonGray)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Email Notifications Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Email notifications")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "checkmark.square.fill")
                                    .foregroundColor(.littleLemonGreen)
                                    .font(.system(size: 16))
                                Text("Order statuses")
                                    .font(.system(size: 16))
                            }
                            
                            HStack {
                                Image(systemName: "checkmark.square.fill")
                                    .foregroundColor(.littleLemonGreen)
                                    .font(.system(size: 16))
                                Text("Password changes")
                                    .font(.system(size: 16))
                            }
                            
                            HStack {
                                Image(systemName: "checkmark.square.fill")
                                    .foregroundColor(.littleLemonGreen)
                                    .font(.system(size: 16))
                                Text("Special offers")
                                    .font(.system(size: 16))
                            }
                            
                            HStack {
                                Image(systemName: "checkmark.square.fill")
                                    .foregroundColor(.littleLemonGreen)
                                    .font(.system(size: 16))
                                Text("Newsletter")
                                    .font(.system(size: 16))
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Buttons Section
                    VStack(spacing: 12) {
                        Button("Log out") {
                            UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                            presentation.wrappedValue.dismiss()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.littleLemonYellow)
                        .foregroundColor(.littleLemonDark)
                        .cornerRadius(8)
                        .font(.system(size: 16, weight: .semibold))
                        
                        HStack(spacing: 12) {
                            Button("Discard changes") {
                                // Discard action
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.littleLemonGray)
                            .foregroundColor(.littleLemonDark)
                            .cornerRadius(8)
                            .font(.system(size: 16, weight: .medium))
                            
                            Button("Save changes") {
                                // Save action
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.littleLemonGreen)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .font(.system(size: 16, weight: .medium))
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 20)
                }
            }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile(selectedTab: .constant(1))
    }
}
