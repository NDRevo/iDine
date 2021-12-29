//
//  CustomProfileButtonStyle.swift
//  iDine
//
//  Created by Noe Duran on 5/31/21.
//

import SwiftUI

struct CustomProfileButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 120)
            .padding(10)
            .background(Color(UIColor.systemGray4))
            .cornerRadius(10)
            .foregroundColor(.blue)
    }
}

