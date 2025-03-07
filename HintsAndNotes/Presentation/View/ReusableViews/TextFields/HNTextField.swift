//
//  HNTextField.swift
//  HintsAndNotes
//
//  Created by Dylan  on 3/6/25.
//

import SwiftUI

struct HNTextField: View {
    @Binding var text: String
    let prompt: String
    let height: CGFloat

    var body: some View {
        TextField("", text: $text, prompt: Text(prompt), axis: .vertical)
       // TextField(text: $text, prompt: Text(prompt), label: {})
       // .axis
        .textFieldStyle(
            HNTextFieldStyle(image: Icons.pencil,
                             showClear: !text.isEmpty,
                             height: height) {
                                 text = ""
                             }
        )
    }

    init(text: Binding<String>,
         prompt: String,
         height: CGFloat = 40) {
        self._text = text
        self.prompt = prompt
        self.height = height
    }
}

#Preview {
    HNTextField(text: .constant(""), prompt: "Enter some text")
}
