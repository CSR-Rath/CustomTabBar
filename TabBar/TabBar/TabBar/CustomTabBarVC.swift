//
//  CustomTabBarVC.swift
//  CoreStructure_iOS
//
//  Created by Rath! on 18/9/24.
//

import UIKit


struct TitleIconModel{
    let name: String
    let iconName: String
}


class CustomTabBarVC: UITabBarController {
    
    private let dataList : [TitleIconModel] = [
    
        TitleIconModel(name: "VC", iconName: ""),
        TitleIconModel(name: "Package", iconName: ""),
        TitleIconModel(name: "Padding", iconName: ""),
        TitleIconModel(name: "Find", iconName: ""),

    ]

    var indexSelected: Int = 0{
        didSet{
            self.selectedIndex = indexSelected
            collactionView.reloadData()
            // Update the title based on the selected index
            self.title = viewControllers?[indexSelected].title
        }
    }
    
    
    
    lazy var collactionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .blue
        collection.delegate = self
        collection.dataSource = self
        collection.register(CustomTabBarCell.self, forCellWithReuseIdentifier: CustomTabBarCell.identifier)
        return collection
    }()
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create instances of view controllers
        let firstVC = UIViewController()
        firstVC.view.backgroundColor = .orange
        let twoVC = UIViewController()
        twoVC.view.backgroundColor = .green
        let threeVC = UIViewController()
        threeVC.view.backgroundColor = .red
        let fourtVC = UIViewController()
        fourtVC.view.backgroundColor = .yellow
        let five = UIViewController()
        five.view.backgroundColor = .white
        
        
        
        // Set titles and tab bar items for each view controller
        firstVC.title = "title"
        firstVC.tabBarItem = UITabBarItem(title: "Home",
                                            image: UIImage(systemName: "1.circle"),
                                            tag: 0)
        
        twoVC.title = "title"
        twoVC.tabBarItem = UITabBarItem(title: "News",
                                             image: UIImage(systemName: "2.circle"),
                                             tag: 1)
        
        threeVC.title = "title"
        threeVC.tabBarItem = UITabBarItem(title: "Station",
                                            image: UIImage(systemName: "3.circle"),
                                            tag: 2)
        
        fourtVC.title = "title"
        fourtVC.tabBarItem = UITabBarItem(title: "More",
                                            image: UIImage(systemName: "4.circle"),
                                            tag: 3)
        five.title = "title"
        five.tabBarItem = UITabBarItem(title: "More",
                                            image: UIImage(systemName: "5.circle"),
                                            tag: 4)
        
        
        viewControllers = [firstVC, twoVC, threeVC, fourtVC]
        
       title = viewControllers?[indexSelected].title
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        leftBarButton()
        setupConstraintAndSetupController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        //MARK: Setup items size collection view
        if let layout = collactionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 0
            let itemWidth = (view.bounds.width-30) / 4
            let itemHeight = collactionView.frame.height
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }
    }
    
    //MARK: Handle Setup ViewController
    private func setupConstraintAndSetupController(){
    
        view.addSubview(collactionView)
        NSLayoutConstraint.activate([
        
            collactionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collactionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collactionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collactionView.heightAnchor.constraint(equalToConstant: 85),
        
        ])
        
//        print( "statusBarHeight ==> ", ConstantsHeight.statusBarHeight,
//               "\navigationBarHeight ==> " , ConstantsHeight.navigationBarHeight,
//               "\navailableHeight ==> ", ConstantsHeight.availableHeight,
//               "\nConstantsHeight.safeAreaTop ==> ", ConstantsHeight.safeAreaTop,
//               "\nConstantsHeight.safeAreaBottom ==> ", ConstantsHeight.safeAreaBottom
//        )
        
    }
}




//MARK: Delegate and Datasource
extension CustomTabBarVC:  UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomTabBarCell.identifier, for: indexPath) as! CustomTabBarCell
        
        cell.lblTitle.text = dataList[indexPath.item].name
        
        
        UIView.animate(withDuration: 0.3, animations: {
//            cell.imgIcon.image = item.selectedImage?.withTintColor(.white) // Change color if needed
//            item.image = item.selectedImage?.withRenderingMode(.alwaysOriginal)
        }, completion: nil)
        
        if indexSelected  == indexPath.item {
            
            configureSelectedCell(cell)
        } else {
            configureDeselectedCell(cell)
        }
        
        cell.imgIcon.image = UIImage(systemName: "\(indexPath.item+1).circle")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSelected = indexPath.item
    }
}

//MARK: Handle Cell conditions

private func configureSelectedCell(_ cell: CustomTabBarCell) {
    
    cell.imgIcon.setImageColor(color: .white)
    cell.lblTitle.textColor = .white
    cell.lblTitle.font = UIFont.systemFont(ofSize: 13, weight: .bold)

    animateCellSelection(cell)
}

private func configureDeselectedCell(_ cell: CustomTabBarCell) {
    cell.imgIcon.setImageColor(color: .gray)
    cell.lblTitle.textColor = .gray
    cell.lblTitle.font = UIFont.systemFont(ofSize: 13, weight: .regular)
}

private func animateCellSelection(_ cell: CustomTabBarCell) {
    UIView.animate(withDuration: 0.05, animations: {
        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        cell.backgroundColor = .white.withAlphaComponent(0.1)
    }, completion: { _ in
        UIView.animate(withDuration: 0.05) {
            cell.transform = CGAffineTransform.identity
            cell.backgroundColor = .clear
        }
    })
}


extension UIImageView {
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
