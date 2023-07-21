//
//  HomeViewController.swift
//  SpringUserLogin
//
//  Created by MD Faizan on 20/07/23.
//

import UIKit

class HomeViewController: UIViewController {
    private var userModel: UserModel?
    
    @IBOutlet weak var userCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "UserCellCollectionView", bundle: nil)
        userCollectionView.register(nib, forCellWithReuseIdentifier: "UserCellCollectionView")
        //        userCollectionView.dataSource = self
        //        userCollectionView.delegate = self
        fetchAndLoadData()
    }
    
    func fetchAndLoadData() {
        NetworkManager.shared.getAPIData { result in
            switch result {
            case .success(let response):
                print("API call successful. response.data.count: \(response.data.count)")
                DispatchQueue.main.async {
                    self.userModel = response
                    self.userCollectionView.reloadData()
                }
                
            case .failure(let error):
                print("Error occurred: \(error)")
            }
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: token)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addUserButton(_ sender: UIButton) {
        
        print("faizam------")
        let EmployeeVC = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeInfoViewController") as! EmployeeInfoViewController
        self.navigationController?.pushViewController(EmployeeVC, animated: true)
        
    }
}


extension HomeViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userModel?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCellCollectionView", for: indexPath) as? UserCellCollectionView else {
            fatalError("can't dequeue Custom Cell")
        }
        
        if let user = userModel?.data[indexPath.item] {
            cell.configureCell(user: user)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //                let width:CGFloat = (userCollectionView.frame.width - 15) / 2
        
        let width:CGFloat = (userCollectionView.frame.width - 10) / 2
        
        
        
        
        
        //            return CGSize(width: width, height: 300)
        
        return CGSize(width: width, height: userCollectionView.frame.size.height/5)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    
    
    
    
    
}
