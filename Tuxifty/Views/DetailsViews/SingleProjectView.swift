//
//  SingleProjectView.swift
//  Tuxifty
//
//  Created by Ewan Bigotte on 05/05/2026.
//

import SwiftUI

struct SingleProjectView: View {
    
    let project: Project42;
    let color: Color;
    
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
                    .foregroundStyle(.title)
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

            HStack(spacing: 6) {
                Image(systemName: "calendar")
                    .foregroundStyle(.secondary)

                Text(
                    markedDateText(
                        from: project.markedAt != nil
                            ? project.markedAt!
                            : project.createdAt,
                        isMarked: project.markedAt != nil
                            ? true
                            : false
                    )
                )
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial.opacity(0.35))
                .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.blue.opacity(0.20), lineWidth: 1)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
        )
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
    
    @ViewBuilder
    private func statusBadge(for project: Project42) -> some View {
        let isDone = project.status == "finished"

        Text(isDone ? "Finished" : "In progress")
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .foregroundStyle(isDone ? .green : color)
            .background((isDone ? Color.green : color).opacity(0.12))
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
            return color;
        }

        return validated ? .green : .red;
    }

    private func markedDateText(from markedAt: String, isMarked: Bool) -> String {
        let date = dateFormatter.date(from: markedAt) ?? ISO8601DateFormatter().date(from: markedAt);
        
        guard let date else { return "Date error"; }
        
        let dateFormated = isMarked
            ? "Marked: \(date.formatted(date: .abbreviated, time: .omitted))"
            : "Created: \(date.formatted(date: .abbreviated, time: .omitted))"

        return dateFormated;
    }
}

#Preview {
    SingleProjectView(project: Project42.example, color: Color(.progressAltStart))
}
