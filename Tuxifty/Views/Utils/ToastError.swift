//
//  ToastError.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 08/05/2026.
//

import SwiftUI

struct ToastError: View {

    let message: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundStyle(.white)
            Text(message)
                .font(.footnote)
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.red.opacity(0.9))
        .clipShape(Capsule())
    }
}

private struct ErrorToastModifier: ViewModifier {

    let errorMessage: String?;
    let onDismiss: () -> Void;

    @State private var toastMessage: String?;
    @State private var hideToastTask: Task<Void, Never>?;

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if let toastMessage {
                    ToastError(message: toastMessage)
                        .padding(.bottom, 12)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.easeInOut(duration: 0.25), value: toastMessage)
            .onChange(of: errorMessage) { _, newError in
                guard let newError else { return }
                toastMessage = newError

                hideToastTask?.cancel()
                hideToastTask = Task {
                    try? await Task.sleep(for: .seconds(3))
                    guard !Task.isCancelled else { return }
                    await MainActor.run {
                        withAnimation {
                            toastMessage = nil
                            onDismiss()
                        }
                    }
                }
            }
    }
}

extension View {

    func errorToast(errorMessage: String?, onDismiss: @escaping () -> Void) -> some View {
        modifier(ErrorToastModifier(errorMessage: errorMessage, onDismiss: onDismiss))
    }
}

#Preview {
    Color.clear
        .ignoresSafeArea()
        .errorToast(errorMessage: "Une erreur est survenue") { }
}
