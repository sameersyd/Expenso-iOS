//
//  LottieView.swift
//  Expenso
//
//  Created by Sameer Nawaz on 07/02/21.
//

import SwiftUI
import Lottie

enum LottieAnimType: String {
    case empty_face = "empty-face"
}

struct LottieView: UIViewRepresentable {
    
    var animType: LottieAnimType
    let animationView = AnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        
        let view = UIView()
        let animation = Animation.named(animType.rawValue)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundBehavior = .pauseAndRestore
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

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(animType: .empty_face)
    }
}
