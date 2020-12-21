//
//  HomeViewController.swift
//  GCDExercise
//
//  Created by Phan Nguyen on 17/12/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    let data = ["https://www.wcrf-uk.org/sites/default/files/Apple_A-Z%20Fruit1.jpg",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyMJT8U6qsRUTjujjRbtvWaBDaWb117ez43Q&usqp=CAU",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT67evcrI2WUip8dtI0FP7awtxE6eQpXuHajg&usqp=CAU",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf40dSsgHV969kuWZhRZr5IqJuHopNZvSk6w&usqp=CAU",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrgQl7av2s2J_QFMxtjIQnrZXdF_GmLX6nZw&usqp=CAU",]

    @IBOutlet weak var tableView: UITableView!
    
    let queue = DispatchQueue(label: "Serial")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return HomeTableViewCell()
        }
        //task2
//        cell.tag = indexPath.row
//        cell.setImageFromUrl(ImageURL: data[indexPath.row % 5], index: indexPath.row)
        
        //task1
        queue.async{
            let group = DispatchGroup()
            group.enter()
            let url = URL(string: self.data[indexPath.row])
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.fruitImageView.image = UIImage(data: data!)
            }
            group.leave()
            group.notify(queue: .global()) {
                print(indexPath.row)
            }
        }
        return cell
    }
}
