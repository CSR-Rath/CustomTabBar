//
//  ViewController.swift
//  TabBar
//
//  Created by Rath! on 27/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var btnCustomTabBar: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Custom", for: .normal)
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
        btn.tag = 0
        return btn
    }()
    
    lazy var btnOriginal: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .orange
        btn.setTitle("Original", for: .normal)
        btn.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
        btn.tag = 1
        return btn
    }()
    
    lazy var stackButton: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [btnCustomTabBar,btnOriginal])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle  = .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraint()
    }
}


extension ViewController{
    
    private func setupConstraint(){
        view.addSubview(stackButton)
        
        NSLayoutConstraint.activate([
            
            stackButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            btnCustomTabBar.heightAnchor.constraint(equalToConstant: 50),
            btnOriginal.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
    @objc private func didTappedButton(sender: UIButton){
         
        if sender.tag == 0 {
            let tabbar = CustomTabBarVC()
            
//            let nav = UINavigationController(rootViewController: tabbar)
            self.navigationController?.pushViewController(tabbar, animated: true)
            
        }else{
            let tabbar = OriginalTabBarVC()
//            let nav = UINavigationController(rootViewController: tabbar)
            self.navigationController?.pushViewController(tabbar, animated: true)
        }
     }
    
}
