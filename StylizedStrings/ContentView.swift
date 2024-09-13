//
//  ContentView.swift
//  StylizedStrings
//
//  Created by Yerassyl Zhassuzakhov on 13.09.2024.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        let text = AttributedString(makeNSAttributedString())
        Text(text).multilineTextAlignment(.center)
    }

    private func makeNSAttributedString() -> NSAttributedString {
        let text = NSLocalizedString("offerBannerText", comment: "empty")
        let mutableAttributedString = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)])

        return mutableAttributedString
            .bolded(
                withFont: .systemFont(
                    ofSize: 40,
                    weight: .bold
                )
            )
            .strikedThrough(
                withFont: .systemFont(
                    ofSize: 22,
                    weight: .light
                ),
                color: .black
            )
    }
}

#Preview {
    ContentView()
}
