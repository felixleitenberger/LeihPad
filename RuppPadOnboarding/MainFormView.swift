//
//  MainFormView.swift
//  RuppPadOnboarding
//
//  Created by Felix Leitenberger on 21.10.23.
//

import SwiftUI
import SwiftData

struct MainFormView: View {
    @Environment(\.modelContext) var modelContext
    @State private var newUser: User? = nil

    @Binding var showMainForm: Bool
    @State private var navPath: [String] = []

    @FocusState private var focusedField: FormField?

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var course = ""
    @State private var teacher = ""
    @State private var room = ""

    @State private var password = ""

    var body: some View {
        NavigationStack(path: $navPath) {
            Form {
                Section("Deine Daten:") {
                    HStack {
                        Text("Vorname: ")
                        TextField(FormField.firstName.rawValue, text: $firstName)
                            .focused($focusedField, equals: .firstName)
                            .disableAutocorrection(true)
                            .submitLabel(.next)
                            .onSubmit {
                                updateOrAddUser()
                                determineField()
                            }

                    }
                    HStack {
                        Text("Nachname: ")
                        TextField(FormField.lastName.rawValue, text: $lastName)
                            .focused($focusedField, equals: .lastName)
                            .disableAutocorrection(true)
                            .submitLabel(.next)
                            .onSubmit {
                                updateOrAddUser()
                                determineField()
                            }
                    }

                    HStack {
                        Text("Klasse/Kurs: ")
                        TextField(FormField.course.rawValue, text: $course)
                            .focused($focusedField, equals: .course)
                            .disableAutocorrection(true)
                            .submitLabel(.next)
                            .onSubmit {
                                updateOrAddUser()
                                determineField()
                            }
                    }
                }
                Section("Einsatz des Geräts:") {
                    HStack {
                        Text("Lehrkraft: ")
                        TextField(FormField.course.rawValue, text: $teacher)
                            .focused($focusedField, equals: .teacher)
                            .disableAutocorrection(true)
                            .submitLabel(.next)
                            .onSubmit {
                                updateOrAddUser()
                                determineField()
                            }
                    }
                    HStack {
                        Text("Raum: ")
                        TextField(FormField.room.rawValue, text: $room)
                            .focused($focusedField, equals: .room)
                            .disableAutocorrection(true)
                            .submitLabel(.done)
                            .onSubmit {
                                updateOrAddUser()
                                determineField()
                                if !firstName.isEmpty || !lastName.isEmpty || !course.isEmpty || !teacher.isEmpty || !room.isEmpty {
                                    navPath.append("CheckDeviceView")
                                }
                            }
                    }
                }

                Button("Weiter") {
                    updateOrAddUser()
                    navPath.append("CheckDeviceView")
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                .disabled(firstName.isEmpty || lastName.isEmpty || course.isEmpty || teacher.isEmpty || room.isEmpty)

                .navigationDestination(for: String.self) { pathValue in
                    if pathValue == "CheckDeviceView" {
                        CheckDeviceView(showMainForm: $showMainForm, path: $navPath, newUser: $newUser)
                    } else if pathValue == "FinishedView" {
                        FinishedView(showMainForm: $showMainForm, path: $navPath, newUser: $newUser)
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    focusedField = .firstName
                }

                if newUser == nil {
                    resetFields()
                }
            }

            .keyboardAvoiding()
            .navigationTitle("Trag dich als Benutzer ein")
            .onChange(of: focusedField) { oldState, newState in
                if newState != .firstName {
                    updateOrAddUser()
                }
            }
            .toolbar {
                Button {
                    resetFields()
                    newUser = nil
                    showMainForm = false
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }

            }

        }
    }

func updateOrAddUser() {
    if let newUser = newUser {
        if newUser.finishedOnbarding { self.newUser = nil}

        newUser.firstName = firstName
        newUser.lastName = lastName
        newUser.course = course
        newUser.teacher = teacher
        newUser.room = room
        newUser.time = Date.now
    } else {
        newUser = User()
        if let newUser = newUser {
            modelContext.insert(newUser)
            updateOrAddUser()
        }
    }
}

func determineField() {
    switch focusedField {
    case .firstName:
        focusedField = .lastName
    case .lastName:
        focusedField = .course
    case .teacher:
        focusedField = .room
    case .course:
        focusedField = .teacher
    case .room:
        focusedField = nil
    default:
        focusedField = .firstName
    }
}

    func resetFields() {
        firstName = ""
        lastName = ""
        course = ""
        teacher = ""
        room = ""
    }
}


#Preview {
    do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: User.self, configurations: config)
        return MainFormView(showMainForm: .constant(true))
                .modelContainer(container)
        } catch {
            fatalError("Failed to create model container.")
        }
}
