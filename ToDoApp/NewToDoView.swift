//
//  NewToDoView.swift
//  ToDoApp
//
//  Created by Eduard Ptushko on 19.12.2023.
//

import SwiftUI

struct NewToDoView: View {
    var body: some View {
        NavigationStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            //  dismiss()
                        } label: {
                            Text("")
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("New ToDo")
                            .bold()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            // dismiss()
                        } label: {
                            Text("")
                        }
                    }
                }
        }
    }
}

#Preview {
    NewToDoView()
}
