//
//  ContentView.swift
//  ScreenTimeDemo
//
//  Created by user250962 on 7/14/24.
//

import SwiftUI
import FamilyControls

struct ContentView: View {
    @State var selection = FamilyActivitySelection()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            FamilyActivityPicker(selection: $selection)
            
            Text("Hello, world!")
        }
        .onAppear() {
            print("appear")
            Task {
                print("task")
                do {
                    print("try revoke")
                    AuthorizationCenter.shared.revokeAuthorization { _ in
                        Task {
                            print("task")
                            do {
                                print("try authorization")
                                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                            } catch {
                                print("error requesting permission")
                            }
                        }
                    }
                } catch {
                    print("nothing")
                }
            }
        }
        .onChange(of: selection) { newSelection in
            let applications = selection.applications
            let categories = selection.categories
            let webDomains = selection.webDomains
        }
    }
}

#Preview {
    ContentView()
}
