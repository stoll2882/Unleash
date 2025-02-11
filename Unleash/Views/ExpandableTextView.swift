//
//  ExpandableTextView.swift
//  Unleash
//
//  Created by Sam Toll on 2/5/25.
//

import SwiftUI

struct ExpandableTextView: View {
    let text: String
    let previewCharacterLimit: Int
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(isExpanded ? text : previewText)
                .lineLimit(isExpanded ? nil : 2)
                .foregroundColor(.primary)
                .font(.system(size: 12))
                .animation(.easeInOut, value: isExpanded)

            if text.count > previewCharacterLimit {
                Button(action: { isExpanded.toggle() }) {
                    Text(isExpanded ? "Show Less" : "Show More")
                        .font(.caption)
                        .foregroundColor(Color(AppConfig.main_bright_pink))
                }
            }
        }
    }

    private var previewText: String {
        let trimmedText = text.prefix(previewCharacterLimit)
        return trimmedText + (text.count > previewCharacterLimit ? "..." : "")
    }
}
