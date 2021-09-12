import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    
    @IBOutlet weak var searchText: UITextField!
    
    @IBAction func searchField(_ sender: Any) {
        let fieldSize = self.searchText.text?.count
        
        fetchData(){ (posts) in
            
            DispatchQueue.main.async {
                
                self.postList = posts.filter(){ post in
                    post.title.prefix(fieldSize!) == self.searchText.text!
                }
            
                self.postTableView.reloadData()
            }
        }
    }
    
    var postList: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        postTableView.dataSource = self
        
        fetchData(){ (posts) in
        
            self.postList = posts
            
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
            
        }
    }
    
    func fetchData(completion: @escaping ([Post]) -> ()){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let responseData = data else { return }
            
            do{
                var posts = try JSONDecoder().decode([Post].self, from: responseData)

                posts.sort(by: {$0.title < $1.title})
                
                completion(posts)
                
            } catch {
                print(error)
            }
        }.resume()
    }
}
