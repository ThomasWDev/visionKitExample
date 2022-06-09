//
//  VKFeatureListVC.swift
//  VisionKitTest
//
//  Created by Thommas Woodfin on 6/9/22.
//

import UIKit

class VKFeatureListVC: UIViewController {
    
    @IBOutlet weak private var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feature List"
        tblView.estimatedRowHeight = 44.0
        tblView.rowHeight = UITableView.automaticDimension
    }
}

extension VKFeatureListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.featureList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VKFeatureCell.identifier, for: indexPath) as! VKFeatureCell
        cell.configuerCell(data: Constants.featureList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        gotoTextRecognition()
    }
    
    private func gotoTextRecognition(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VKTextRecognitionVC") as! VKTextRecognitionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
