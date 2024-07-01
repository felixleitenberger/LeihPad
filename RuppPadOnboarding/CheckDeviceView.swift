//
//  CheckDeviceView.swift
//  RuppPadOnboarding
//
//  Created by Felix Leitenberger on 26.10.23.
//

import SwiftUI

struct CheckDeviceView: View {
    @Binding var showMainForm: Bool
    @Binding var path: [String]
    @Binding var newUser: User?

    var body: some View {
        HStack {
            LottiePlusView(name: "Tasks", loopMode: .loop, contentMode: .scaleAspectFit)
                .frame(maxWidth: 300)
            VStack(alignment: .leading) {
                Text("📱 Ist das iPad beschädigt oder verschmutzt?")
                    .font(.subheadline)
                    .padding(.bottom)
                Text("🏞️ Sind in der Fotos-App bedenkliche Bilder gespeichert?")
                    .font(.subheadline)
                    .padding(.bottom)
                Text("📁 Lässt sich das iPad normal bedienen?")
                    .font(.subheadline)
                    .padding(.bottom)
                Text("🌎 Sind alle Tabs im Browser (Safari) geschlossen?")
                    .font(.subheadline)
                    .padding(.bottom)

                HStack {
                    Button ("Alles in Ordnung. Ich habe nichts festgestellt.") {
                        newUser?.checkedIpad = true
                        newUser?.reportedSomethingToTeacher = false
                        path.append("FinishedView")
                    }
                    .buttonStyle(.borderedProminent)

                    Button ("Ich habe der Lehrkraft Bescheid gesagt.") {
                        newUser?.checkedIpad = true
                        newUser?.reportedSomethingToTeacher = true
                        path.append("FinishedView")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }


        .navigationTitle("Überprüfe dein Gerät, \(newUser?.firstName ?? "")")
    }
}


//#Preview {
//    CheckDeviceView()
//}
