//
//  Onboarding.swift
//  RestaurantApp
//
//  Created by l on 12/11/23.
//

import SwiftUI

struct OnboardingView: View {
    @State private var isLoggedIn = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    let kIsLoggedIn = "isLogin"
    let kFirstName = "first name key"
    let kLastName = "last name key"
    let kEmail = "email key"
    
    @State private var showingPopover = false
    @State private var showingPopoverTips = "error message"
//    @State private var dynamicText: String = "Hello, World!"

    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                HeaderView()
                
                HeroView()
                
                // registration form
                VStack {
                    Text("First Name *")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField(firstName, text: $firstName)
                    Text("Last Name *")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField(lastName, text: $lastName)
                    Text("E-mail Address *")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField(email, text: $email)
                }
                .foregroundColor(.accentGreen)
                .frame(maxWidth: 350)
                .textFieldStyle(.roundedBorder)
                .padding(.top)
                
                // registration button that validates form entries 
                Button(action: {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        // Additional check for a valid email
                        if isValidEmail(email) {
                            // Store data in UserDefaults
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            print("Stored first name:", UserDefaults.standard.string(forKey: kFirstName) ?? "nil")
                            print("Stored last name:", UserDefaults.standard.string(forKey: kLastName) ?? "nil")
                            print("Stored e-mail address:", UserDefaults.standard.string(forKey: kEmail) ?? "nil")
                            
                            isLoggedIn = true
                        } else {
                            // Handle invalid email
                            print("Invalid email address")
                            showingPopoverTips = "Invalid email address"
                            showingPopover = true
                        }
                    } else {
                        // Handle empty fields
                        print("Please fill in all fields")
                        showingPopoverTips = "Please fill in all fields"
                        showingPopover = true

                    }
                }, label: {
                    Text("Register")
                        .foregroundColor(.accentBlack)
                })
                .padding(.top)
                .tint(.accentYellow)
                .buttonStyle(.borderedProminent)
                // add an alert if any fields aren't handled correctly
                .popover(isPresented: $showingPopover) {
                    Text(showingPopoverTips)
                        .font(.headline)
                        .padding()
                }
                Spacer()
            }
        }
        .onAppear {
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                isLoggedIn = true
                if isLoggedIn {
                    print("user isLogin")
                }
            }
        }
    }
    
    // Function to check if the email is valid
    private func isValidEmail(_ email: String) -> Bool {
        // Regular expression for a basic email format
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        // NSPredicate to evaluate the email format
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: email)
    }
}

#Preview {
    OnboardingView()
}
