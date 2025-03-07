//
//  WineLabelView.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/6/25.
//

import SwiftUI

struct WineLabelView: View {
    @State private var viewModel = WineLabelViewModel()
#warning("TODO: Inject captured image")

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                viewModel.image
                    .resizable()
                    .frame(width: 175, height: 175)
            }
            Form {
                Section("Wine Info") {
                    HNTextField(text: $viewModel.name,
                                prompt: viewModel.namePrompt)
                    HNTextField(text: $viewModel.type,
                                prompt: viewModel.typePrompt)
                    HNTextField(text: $viewModel.color,
                                prompt: viewModel.colorPrompt)
                    HNTextField(text: $viewModel.vintage,
                                prompt: viewModel.vintagePrompt)
                }
                .padding(.vertical)

                Section("Notes") {
                    HNTextField(text: $viewModel.notes,
                                prompt: viewModel.notesPrompt)
                        .frame(minHeight: 100)
                }
                .padding(.vertical)

                HNButton(title: "Save", font: .title) {
                    print("Saving label: \(viewModel.label)")
                    //viewModel.save(in: <#T##WineLabelRepo#>)
                }

            }
        }
        .navigationBar(title: "Add Wine",
                       leadingIcon: Icons.gearShape,
                       leadingAction: {

#warning("TODO: Settings")
        })
        .task {
            viewModel.setData()
        }
    }
}

#Preview {
    WineLabelView()
}
