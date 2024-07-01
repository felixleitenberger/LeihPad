//
//  IntroView.swift
//  RuppPadOnboarding
//
//  Created by Felix Leitenberger on 20.11.23.
//

import SwiftUI

struct IntroView: View {
    @State private var showMainForm = false
    @State private var showBackend = false
    @State private var showPasswordPrompt = false

    @State private var passwordTextField = ""

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    LottiePlusView(name: "iPad", loopMode: .loop, contentMode: .scaleAspectFit)
                        .frame(maxWidth: 300)

                    VStack(alignment:.leading) {
                        Text("Zusammen.lernen")
                            .font(.title).bold()
                            .foregroundColor(Color(red: 236/255, green: 0, blue: 140/255))
                        Text("Gleich kann's losgehen. \nLass uns nur ein paar Dinge durchgehen. \nEs dauert nicht lang.")
                            .font(.subheadline)
                            .padding(.bottom)

                        Button("Weiter") {
                            withAnimation(.spring(.bouncy)) {
                                showMainForm = true
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }

                HStack {
                    LogoView()
                    Spacer()
                    Button {
                        if getPassword() != nil {
                            showPasswordPrompt = true
                        } else {
                            showBackend = true
                        }

                    } label: {
                        Image(systemName: "gear")
                    }
                    .padding()
                }
            }

            if showMainForm {
                MainFormView(showMainForm: $showMainForm)
                    .transition(.move(edge: .bottom))
            }
        }
        .sheet(isPresented: $showBackend, content: {
            BackendView()
        })
        .alert(Text("Passwort erforderlich"), isPresented: $showPasswordPrompt) {
            SecureField("Passwort", text: $passwordTextField)
                .textContentType(.password)
            Button("Login", role: .destructive) {
                if passwordTextField == getPassword() {
                    showBackend = true
                    passwordTextField = ""
                }
            }
            Button("Abbrechen", role: .cancel) {
                passwordTextField = ""
            }

        } message: {
            Text("Bitte gib das Passwort für den Admin-Bereich ein: ")
        }
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
}

struct LogoView: View {
    var body: some View {
        HStack {
            Image("rgmLogo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 50)
                .padding(.leading)
            Text("**Rupprecht-Gymnasium** \nMünchen")
                .font(.caption)
        }
    }
}

#Preview { IntroView() }
