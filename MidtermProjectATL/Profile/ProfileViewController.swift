//
//  ProfileViewController.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 21.03.25.
//

import UIKit

class ProfileViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!

    var userInfoModel: UserInfoModel?
    
    
    var items: [ProfileTableViewCell.item] = [
        .init(leftImageName: "person", title: "Personal Data"),
        .init(leftImageName: "book.pages", title: "Transaction History"),
        .init(leftImageName: "gear", title: "Settings"),
        .init(leftImageName: "wand.and.sparkles", title: "Appearance"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileTableViewCell.nib, forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier)
        
        imageBgView.clipsToBounds = true
        imageBgView.layer.cornerRadius = imageBgView.frame.height / 2
        
        
        
        
        
       
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = UserManager.shared.getUser().first{
            userNameLabel.text = user.name
            userEmailLabel.text = user.email
        }
        
        

    }
}

extension ProfileViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier, for: indexPath) as? ProfileTableViewCell else {return UITableViewCell()}
        cell.configure(items[indexPath.row])
        return cell
    
    }
    
    
}

extension ProfileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileDetailViewController") as? ProfileDetailViewController{
                self.navigationController?.pushViewController(vc, animated: true)
                vc.delegate = self
                
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProfileViewController: ChangeUserInfo{
    func didChangeUserInfo(name: String, email: String) {
        if let user = UserManager.shared.getUser().first{
            var newName = user.email
            var newEmail = user.name
            
            newName = name
            newEmail = email
            
            
        }
    }
}



