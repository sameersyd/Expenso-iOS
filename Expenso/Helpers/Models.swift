//
//  Models.swift
//  Expenso
//
//  Created by Sameer Nawaz on 31/01/21.
//

import UIKit
import SwiftUI
import Lottie

// Lazy Navigation to load (constructor) after clicked on Button
struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) { self.build = build }
    var body: Content { build() }
}

struct LottieView: UIViewRepresentable {
    
    let animationView = AnimationView()
    var filename = "empty-face"
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        
        let view = UIView()
        let animation = Animation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {}
}

struct ToolbarModelView: View {
    
    var title: String
    var hasBackButt: Bool = true
    var button1Icon: String?
    var button2Icon: String?
    
    var backButtonClick: () -> ()
    var button1Method: (() -> ())?
    var button2Method: (() -> ())?
    
    var body: some View {
        ZStack {
            HStack {
                if hasBackButt {
                    Button(action: { self.backButtonClick() },
                        label: { Image("back_arrow").resizable().frame(width: 34.0, height: 34.0) })
                }
                Spacer()
                if let button2Method = self.button2Method {
                    Button(action: { button2Method() },
                           label: { Image(button2Icon ?? "").resizable().frame(width: 28.0, height: 28.0) }).padding(.horizontal, 8)
                }
                if let button1Method = self.button1Method {
                    Button(action: { button1Method() },
                           label: { Image(button1Icon ?? "").resizable().frame(width: 28.0, height: 28.0) }).padding(.horizontal, 8)
                }
            }
            HStack {
                TextView(text: title, type: .h6).foregroundColor(Color.text_primary_color)
                if !hasBackButt { Spacer() }
            }
        }.padding(16).padding(.top, 30).padding(.horizontal, 8).background(Color.secondary_color)
    }
}
