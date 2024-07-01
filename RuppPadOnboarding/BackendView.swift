//
//  BackendView.swift
//  RuppPadOnboarding
//
//  Created by Felix Leitenberger on 26.10.23.
//

import SwiftUI
import SwiftData

struct BackendView: View {
    @Environment(\.dismiss) var dismiss
    @Query(sort: \User.time, order: .reverse) var users: [User]

    @State private var showSetPasswordAlert = false
    @State private var textFieldPassword = ""
    @State private var lockSymbol = "lock.open"


    var body: some View {
        NavigationStack {
            List(users) { user in
                UserView(user: user)
            }
            .navigationTitle("Historie")
            .toolbar {
                Button ("Passwort für Backend setzen", systemImage: lockSymbol)
                {
                    showSetPasswordAlert = true
                }

                Button("Schließen", systemImage: "xmark.circle.fill") {
                    dismiss()
                }
            }

            .alert(Text("Passwort einrichten"), isPresented: $showSetPasswordAlert) {
                TextField("Passwort eingeben", text: $textFieldPassword)
                Button("Passwort setzen", role: .destructive) {
                    setPassword(password: textFieldPassword)
                    setLockSymbol()
                }
                Button("Abbrechen", role: .cancel) {

                }

            } message: {
                Text("Setze ein Passwort für diesen Screen. Das Passwort kann nicht zurückgesetzt werden.")
            }
        }
        .onAppear {
            setLockSymbol()
        }
    }

    func setPassword(password: String) {
        UserDefaults.standard.setValue(password, forKey: "password")
        textFieldPassword = ""
    }

    func getPassword() -> String? {
        if let password = UserDefaults.standard.string(forKey: "password") {
            if !password.isEmpty {
                return password
            } else {
                return nil
            }
        } else {
            return nil
        }
    }

    func setLockSymbol() {
        withAnimation {
            if getPassword() != nil {
                lockSymbol = "lock"
            } else {
                lockSymbol = "lock.open"
            }
        }
    }
}

#Preview {
    BackendView()
}
