//
//  TransparentSheetModifier.swift
//  Unleash
//
//  Created by Rod Toll on 4/17/25.
//

import SwiftUI

struct TransparentSheetModifier: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            if let presentedController = controller.presentedViewController?.view.superview {
                presentedController.backgroundColor = UIColor.clear  // ✅ Make background transparent
            }
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
