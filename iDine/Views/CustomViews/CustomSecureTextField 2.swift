//
//  CustomSecureTextField.swift
//  iDine
//
//  Created by Noe Duran on 5/30/21.
//

import SwiftUI

struct CustomSecureTextField: View {
    
    var title: String
    var contentType: UITextContentType
    @State var inputtedText: Binding<String>

    var body: some View {
        SecureField(title, text: inputtedText)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .textContentType(contentType)
            .border(Color.clear)
            .padding(12)
            .background(Color(UIColor.systemGray3))
            .cornerRadius(12)
    }
}

struct CustomSecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureTextField(title: "Password", contentType: .password, inputtedText: .constant(""))
    }
}
