//
//  EarthQuakeItemCell.swift
//  EarthQuake
//
//  Created by Layne on 2024/11/7.
//

import UIKit

class EarthQuakeItemCell: UITableViewCell {

    private lazy var titleLabel = makeLabel()
    private lazy var magnitudeLabel = makeLabel()
    private lazy var placeLabel = makeLabel()
    private lazy var timeLabel = makeLabel()
    private lazy var updatedTimeLabel = makeLabel()
    private lazy var alertLabel = makeLabel()
    private lazy var alertValueLabel: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [
            titleLabel,
            magnitudeLabel,
            placeLabel,
            timeLabel,
            updatedTimeLabel,
            alertLabel,
            alertValueLabel
        ].forEach(addSubview)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

            magnitudeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            magnitudeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            magnitudeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            placeLabel.topAnchor.constraint(equalTo: magnitudeLabel.bottomAnchor, constant: 6),
            placeLabel.leadingAnchor.constraint(equalTo: magnitudeLabel.leadingAnchor),
            placeLabel.trailingAnchor.constraint(equalTo: magnitudeLabel.trailingAnchor),

            timeLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 6),
            timeLabel.leadingAnchor.constraint(equalTo: placeLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: placeLabel.trailingAnchor),

            updatedTimeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 6),
            updatedTimeLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            updatedTimeLabel.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor),

            alertLabel.topAnchor.constraint(equalTo: updatedTimeLabel.bottomAnchor, constant: 6),
            alertLabel.leadingAnchor.constraint(equalTo: updatedTimeLabel.leadingAnchor),
            alertLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),

            alertValueLabel.heightAnchor.constraint(equalToConstant: 16.0),
            alertValueLabel.widthAnchor.constraint(equalToConstant: 16.0),
            alertValueLabel.centerYAnchor.constraint(equalTo: alertLabel.centerYAnchor),
            alertValueLabel.leadingAnchor.constraint(equalTo: alertLabel.trailingAnchor, constant: 6)
        ])
    }

    func config(_ earthquake: EarthQuake) {
        // Font color will be RED if magnitude is greater or equal to 7.5
        var color: UIColor = .black
        if earthquake.properties.mag >= 7.5 {
            color = .red
        }
        titleLabel.attributedText = NSAttributedString(string: earthquake.properties.title,
                                                       attributes: [
                                                        .font: UIFont.systemFont(ofSize: 18, weight: .bold),
                                                        .foregroundColor: color
                                                       ])
        magnitudeLabel.attributedText = NSAttributedString(string: "Magnitude: \(earthquake.properties.mag)",
                                                           attributes: [
                                                            .font: UIFont.systemFont(ofSize: 14),
                                                            .foregroundColor: color
                                                           ])
        placeLabel.attributedText = NSAttributedString(string: "Place: \(earthquake.properties.place)",
                                                       attributes: [
                                                        .font: UIFont.systemFont(ofSize: 14),
                                                        .foregroundColor: color
                                                       ])
        timeLabel.attributedText = NSAttributedString(string: "Time: \(earthquake.properties.time)",
                                                      attributes: [
                                                        .font: UIFont.systemFont(ofSize: 14),
                                                        .foregroundColor: color
                                                      ])
        updatedTimeLabel.attributedText = NSAttributedString(string: "Updated: \(earthquake.properties.updated)",
                                                             attributes: [
                                                                .font: UIFont.systemFont(ofSize: 14),
                                                                .foregroundColor: color
                                                             ])
        alertLabel.attributedText = NSAttributedString(string: "Alert: ",
                                                       attributes: [
                                                        .font: UIFont.systemFont(ofSize: 14),
                                                        .foregroundColor: color
                                                       ])
        alertValueLabel.backgroundColor = earthquake.properties.alert.color
    }
}

extension EarthQuakeItemCell {

    func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }
}

extension EarthQuake.Properties.Alert {

    var color: UIColor {
        switch self {
        case .green: return .green
        case .yellow: return .yellow
        case .orange: return .orange
        case .red: return .red
        }
    }
}
