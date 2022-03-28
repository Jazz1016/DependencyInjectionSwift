//
//  CoursesVC.swift
//  MyAppUIKit
//
//  Created by James Lea on 3/27/22.
//

import UIKit

public protocol DataFetchable {
    func fetchCourseNames(completion: @escaping ([String]) -> Void)
}

struct Course {
    let name: String
}

public class CoursesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataFetchable: DataFetchable
    
    private let tableView: UITableView = {
       let tableView =  UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    public init(dataFetchable: DataFetchable) {
        self.dataFetchable = dataFetchable
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var courses: [Course] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .systemBackground
        dataFetchable.fetchCourseNames { [weak self] names in
            guard let self = self else { return }
            self.courses = names.map({ Course(name: $0) })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = courses[indexPath.row].name
        return cell
    }

}//End of Class
