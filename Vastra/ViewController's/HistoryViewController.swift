//
//  HistoryViewController.swift
//  Vastra
//
//  Created by Николай Никитин on 21.09.2022.
//

import UIKit

class HistoryViewController: BaseViewController {

  //MARK: - Properties
  private static let reuseID = "REUSEID"

  //MARK: - Subview's
  private lazy var topLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Run Logs"
    label.textAlignment = .center
    label.textColor = .darkGray
    label.font = label.font.withSize(32)
    return label
  }()

  private lazy var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.delegate = self
    table.dataSource = self
    table.register(HistoryTableViewCell.self, forCellReuseIdentifier: Self.reuseID)
    table.backgroundColor = .clear
    table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    table.separatorColor = .white
    return table
  }()

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tableView.reloadData()
  }

  //MARK: - Methods
  private func setupViews() {
    view.addSubview(topLabel)
    view.addSubview(tableView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      topLabel.heightAnchor.constraint(equalToConstant: 50)
    ])

    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

//MARK: - UITableViewDelegate & UITableViewDataSource Protocols
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Run.getAllRuns()?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.reuseID) as? HistoryTableViewCell,
          let run = Run.getAllRuns()?[indexPath.row] else {
      return UITableViewCell()
    }
    cell.configure(run: run)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard let run = Run.getAllRuns()?[indexPath.row] else {
      return
    }
    let viewController = RunDetailViewControler(run: run)
    present(viewController, animated: true, completion: nil)
  }

  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      guard let run = Run.getAllRuns()?[indexPath.row] else {
        return
      }
      Run.removeRunFromRealm(run: run)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
}
