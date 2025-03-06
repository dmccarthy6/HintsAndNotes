//
//  View+additions.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/6/25.
//

import SwiftUI

extension View {
    func navigationBar(title: String,
                       trailingLabel: String,
                       _ trailingAction: OptionalClosure = nil) -> some View {
        self
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: trailingAction ?? {}) {
                        HNTextView(text: trailingLabel, font: .headline)
                    }
                }
            }
    }

    func navigationBar(title: String,
                       tint: Color = .black,
                       leadingIcon: Image? = Icons.gearShape,
                       trailingIcon: Image? = Icons.plus,
                       leadingAction: OptionalClosure = nil,
                       trailingAction: OptionalClosure = nil) -> some View {
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if let leadingAction {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: leadingAction) {
                            leadingIcon
                                .tint(tint)
                        }
                    }
                }
                if let trailingAction {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: trailingAction) {
                            trailingIcon
                                .tint(tint)
                        }
                    }
                }
            }
    }
}
