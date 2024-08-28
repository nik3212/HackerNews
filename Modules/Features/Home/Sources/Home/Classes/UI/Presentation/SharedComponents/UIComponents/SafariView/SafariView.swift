//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    let onDismiss: () -> Void

    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        let parent: SafariView

        init(parent: SafariView) {
            self.parent = parent
        }

        func safariViewControllerDidFinish(_: SFSafariViewController) {
            parent.onDismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = context.coordinator
        return safariViewController
    }

    func updateUIViewController(_: SFSafariViewController, context _: Context) {}
}
