//
//  ViewController.swift
//  Di
//
//  Created by James Lea on 3/27/22.
//

import APIKit
import MyAppUIKit
import UIKit

extension APICaller: DataFetchable {}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // https://iosacademy.io/api/v1/courses/index.php
        configureViewController()
    }
    
    func configureViewController(){
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemBlue
        button.setTitle("Tap me", for: .normal)
        button.center = view.center
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton(){
        let VC = CoursesVC(dataFetchable: APICaller.shared)
        present(VC, animated: true)
    }


}//End of Class

