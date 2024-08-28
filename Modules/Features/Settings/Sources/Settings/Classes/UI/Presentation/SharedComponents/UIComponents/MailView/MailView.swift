//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import MessageUI
import SwiftUI

struct MailView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isPresented: Bool

        init(isPresented: Binding<Bool>) {
            _isPresented = isPresented
        }

        func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith _: MFMailComposeResult,
            error _: Error?
        ) {
            isPresented = false
            controller.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented)
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setSubject("Feedback")
        vc.setToRecipients(["your_email@example.com"])
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_: MFMailComposeViewController, context _: Context) {}
}
