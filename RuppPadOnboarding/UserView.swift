//
//  UserView.swift
//  RuppPadOnboarding
//
//  Created by Felix Leitenberger on 02.11.23.
//

import SwiftUI
import SwiftData

struct UserView: View {
    let user: User

    var body: some View {
        VStack (alignment: .leading) {
            HStack  {
                Text(user.firstName)
                Text(user.lastName)
                Text("(\(user.course))")
            }
            .font(.title)

            HStack {
                Text("Lehrkraft:")
                Text(user.teacher)
                Text(", Raum:")
                Text(user.room)
            }
            .font(.subheadline)


            HStack {
                Text("\(user.time.formatted(date: .numeric, time: .shortened))")
                    .font(.subheadline)
            }
            .padding(.bottom)

            HStack {
                Text("iPad überprüft:")
                    .font(.caption2)
                user.checkedIpad ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "x.circle.fill")

                Text("Auffälligkeit(en) gemeldet:")
                    .font(.caption2)
                    .padding(.leading)
                user.reportedSomethingToTeacher ? Image(systemName: "hand.raised.fill") : Image(systemName: "hand.raised.slash.fill")

                Text("Onboarding abgeschlossen:")
                    .font(.caption2)
                    .padding(.leading)
                user.finishedOnbarding ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "x.circle.fill")

            }
        }
        .padding()
    }
}


#Preview {
    do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: User.self, configurations: config)

            let example = User(firstName: "Hans", lastName: "Dampfhuber", room: "A203", course: "9c", teacher: "LEI", checkedIpad: true, reportedSomethingToTeacher: false, finishedOnbarding: true)
            return UserView(user: example)
                .modelContainer(container)
        } catch {
            fatalError("Failed to create model container.")
        }
    }
