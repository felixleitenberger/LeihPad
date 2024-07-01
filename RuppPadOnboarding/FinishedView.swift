//
//  FinishedView.swift
//  RuppPadOnboarding
//
//  Created by Felix Leitenberger on 26.10.23.
//

import SwiftUI

struct FinishedView: View {
    @Binding var showMainForm: Bool
    @Binding var path: [String]
    @Binding var newUser: User?

    var body: some View {
        Text("Alles klar. Viel Spaß beim Arbeiten mit diesem iPad. \nBehandle es gut! Drücke auf fertig und verlasse die App.")
            .font(.title)
            .padding()
        Button("Fertig") {
            path = []
            newUser = nil
            withAnimation {
                showMainForm = false
            }
        }
        .buttonStyle(.borderedProminent)
        .onAppear { newUser?.finishedOnbarding = true}
        .navigationTitle("Abgeschlossen")
        Text("Drücke auf 'Fertig' um das Onboarding von vorne zu beginnen.")
    }
}

//
//#Preview {
//    FinishedView()
//}
