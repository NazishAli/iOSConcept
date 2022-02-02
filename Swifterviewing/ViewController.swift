//
//  ViewController.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   // var albums:[Album] = []
   
    // MARK: IBOutlet........
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables........
    var viewModel = AlbumViewModel()
    let activityIndicater = UIActivityIndicatorView(style: .large)
    
    // MARK: View Life cycle........
    override func viewDidLoad() {
        self.configure()
        activityIndicater.center = self.view.center
        self.view.addSubview(activityIndicater)
        activityIndicater.startAnimating()
        viewModel.getAlbums()
        viewModel.callBack = { [weak self] (isSucess, error) in
            self?.activityIndicater.stopAnimating()
            if isSucess {
                self?.tableView.reloadData()
            } else {
                self?.showError(message: error)
            }
        }
        
    }
    
    func configure() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
    }
    
    // MARK: - Private methods
    
   
    private func registerCell() {
           tableView.registerCell("AlbumTableViewCell")
       }
    
    private func showError(message: String?) {
         UIAlertController.presentAlert(title: "", message: message, style: UIAlertController.Style.alert).action(title: "OK", style: UIAlertAction.Style.default) { (action: UIAlertAction) in
               }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.albumList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as? AlbumTableViewCell
        cell?.albumTitleLabel.text = viewModel.albumList[indexPath.row].title
       // cell.imageView?.image = <#Album Image#>
        if let url = viewModel.albumList[indexPath.row].url {
            cell?.albumImageView.setImageForUrl(url: url)
        }
        return cell!
        
         
    }
}

extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}
