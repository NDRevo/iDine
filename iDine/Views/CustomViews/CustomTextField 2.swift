//
//  CustomTextField.swift
//  iDine
//
//  Created by Noe Duran on 5/27/21.
//

import SwiftUI

struct CustomTextField: View {
    
    var title: String
    var keyboardType: UIKeyboardType
    var contentType: UITextContentType
    @State var inputtedText: Binding<String>

    var body: some View {
        TextField(title, text: inputtedText)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .keyboardType(keyboardType)
            .textContentType(contentType)
            .padding(12)
            .background(Color(UIColor.systemGray3))
            .cornerRadius(12)
        
    }
}
