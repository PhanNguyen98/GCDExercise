//
//  HomeViewController.swift
//  GCDExercise
//
//  Created by Phan Nguyen on 17/12/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    let dataSources = ["https://www.wcrf-uk.org/sites/default/files/Apple_A-Z%20Fruit1.jpg",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyMJT8U6qsRUTjujjRbtvWaBDaWb117ez43Q&usqp=CAU",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT67evcrI2WUip8dtI0FP7awtxE6eQpXuHajg&usqp=CAU",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf40dSsgHV969kuWZhRZr5IqJuHopNZvSk6w&usqp=CAU",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrgQl7av2s2J_QFMxtjIQnrZXdF_GmLX6nZw&usqp=CAU"]

    @IBOutlet weak var tableView: UITableView!
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        downloadImage()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
    }
    
    func downloadImage() {
            let dispatchGroup = DispatchGroup()
            let queue = DispatchQueue.global(qos: .userInteractive)
            
            dispatchGroup.enter()
            print("start \(index)")
            queue.async() {
                let url = URL(string: self.dataSources[self.index])
                do {
                    let data = try Data(contentsOf: url!)
                    DispatchQueue.main.async {
                        print("done \(self.index)")
                        let indexPath = IndexPath(row: self.index, section: 0)
                        let cell = self.tableView.cellForRow(at: indexPath) as! HomeTableViewCell
                        cell.fruitImageView.image = UIImage(data: data)
                        self.index += 1
                        dispatchGroup.leave()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                if self.index < self.dataSources.count {
                    self.downloadImage()
                }
            }
        }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            return HomeTableViewCell()
        }
        //task2
//        cell.tag = indexPath.row
//        cell.setImageFromUrl(ImageURL: dataSources[indexPath.row % 5], index: indexPath.row)
        
        
//        url = URL(string: dataSources[indexPath.row])
//        data = try? Data(contentsOf: url!)
        //task1
       
        return cell
    }
}
