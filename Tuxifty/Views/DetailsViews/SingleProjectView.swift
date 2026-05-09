//
//  SingleProjectView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 05/05/2026.
//

import SwiftUI

struct SingleProjectView: View {
    
    let project: Project42;
    private let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter();
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds];
        return formatter;
    }();
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Text(project.project.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)

                Spacer()

                statusBadge(for: project)
            }

            HStack(spacing: 10) {
                infoCapsule(
                    icon: "checkmark.seal",
                    label: "Result",
                    value: resultText(for: project),
                    color: validationColor(for: project)
                )

                if let mark = project.finalMark {
                    infoCapsule(
                        icon: "number",
                        label: "Mark",
                        value: "\(mark)",
                        color: validationColor(for: project)
                    )
                }
            }

            if let markedAt = project.markedAt {
                HStack(spacing: 6) {
                    Image(systemName: "calendar")
                        .foregroundStyle(.secondary)

                    Text(markedDateText(from: markedAt))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(14)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.blue.opacity(0.20), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
    
    @ViewBuilder
    private func statusBadge(for project: Project42) -> some View {
        let isDone = project.status == "finished"

        Text(isDone ? "Finished" : "In progress")
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .foregroundStyle(isDone ? .green : .blue)
            .background((isDone ? Color.green : Color.blue).opacity(0.12))
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke((isDone ? Color.green : Color.blue).opacity(0.28), lineWidth: 1)
            )
    }

    @ViewBuilder
    private func infoCapsule(icon: String, label: String, value: String, color: Color) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)

            Text("\(label): \(value)")
                .font(.caption.weight(.medium))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .foregroundStyle(color)
        .background(color.opacity(0.10))
        .clipShape(Capsule())
    }

    private func resultText(for project: Project42) -> String {
        guard let validated = project.validated else {
            return "Pending"
        }

        return validated ? "Validated" : "Failed"
    }

    private func validationColor(for project: Project42) -> Color {
        guard let validated = project.validated else {
            return .blue;
        }

        return validated ? .green : .red;
    }

    private func markedDateText(from markedAt: String) -> String {
        let date = dateFormatter.date(from: markedAt) ?? ISO8601DateFormatter().date(from: markedAt);

        guard let date else { return "Marked: -"; }

        return "Marked: \(date.formatted(date: .abbreviated, time: .omitted))";
    }
}

#Preview {
    SingleProjectView(project: Project42.example)
}
