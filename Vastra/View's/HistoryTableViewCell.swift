//
//  HistoryTableViewCell.swift
//  Vastra
//
//  Created by Николай Никитин on 27.09.2022.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell {

  //MARK: - Properties
  var totalKilometers: Double = 0.0 {
    didSet {
      totalKilometersLabel.text = String(format: "%0.1f", totalKilometers)
      layoutIfNeeded()
    }
  }

  var totalTime: String = "00:00:00" {
    didSet {
      totalTimeLabel.text = totalTime
      layoutIfNeeded()
    }
  }

  var entryDate: String = "01/02/2003" {
    didSet {
      entryDateLabel.text = entryDate
      layoutIfNeeded()
    }
  }

  //MARK: - UI Elements
  private lazy var totalKilometersLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "0.0"
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 24)
    return label
  }()

  private lazy var totalTimeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "0.0"
    label.textColor = .white
    label.font = label.font.withSize(18)
    return label
  }()

  private lazy var entryDateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "0.0"
    label.textColor = .white
    label.font = label.font.withSize(18)
    return label
  }()

  //MARK: - Init's
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupSubviews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Layout
  override func layoutSubviews() {
    super.layoutSubviews()
    setupConstraints()
  }

  //MARK: - Methods
  private func setupSubviews() {
    backgroundColor = UIColor.black.withAlphaComponent(0.1)
    contentView.addSubview(totalKilometersLabel)
    contentView.addSubview(totalTimeLabel)
    contentView.addSubview(entryDateLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      totalKilometersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      totalKilometersLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
    ])

    NSLayoutConstraint.activate([
      totalTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      totalTimeLabel.topAnchor.constraint(equalTo: totalKilometersLabel.bottomAnchor, constant: 8),
      totalTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])

    NSLayoutConstraint.activate([
      entryDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      entryDateLabel.centerYAnchor.constraint(equalTo: totalKilometersLabel.centerYAnchor)
    ])
  }
}
