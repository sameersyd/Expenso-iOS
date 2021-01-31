//
//  TextView.swift
//  Expenso
//
//  Created by Sameer Nawaz on 31/01/21.
//

import SwiftUI

enum TextView_Type {
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case subtitle_1
    case subtitle_2
    case body_1
    case body_2
    case button
    case caption
    case overline
}

struct TextView: View {
    var text: String
    var type: TextView_Type
    var lineLimit: Int = 0
    var body: some View {
        switch type {
        case .h1: return Text(text).tracking(-1.5).modifier(InterFont(.bold, size: 96)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .h2: return Text(text).tracking(-0.5).modifier(InterFont(.bold, size: 60)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .h3: return Text(text).tracking(0).modifier(InterFont(.bold, size: 48)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .h4: return Text(text).tracking(0.25).modifier(InterFont(.bold, size: 34)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .h5: return Text(text).tracking(0).modifier(InterFont(.semiBold, size: 24)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .h6: return Text(text).tracking(0.15).modifier(InterFont(.semiBold, size: 20)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .subtitle_1: return Text(text).tracking(0.15).modifier(InterFont(.bold, size: 16)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .subtitle_2: return Text(text).tracking(0.1).modifier(InterFont(.bold, size: 14)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .body_1: return Text(text).tracking(0.5).modifier(InterFont(.regular, size: 16)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .body_2: return Text(text).tracking(0.25).modifier(InterFont(.regular, size: 14)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .button: return Text(text).tracking(1.25).modifier(InterFont(.semiBold, size: 14)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .caption: return Text(text).tracking(0.4).modifier(InterFont(.medium, size: 12)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .overline: return Text(text).tracking(1.5).modifier(InterFont(.semiBold, size: 10)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        }
    }
}
