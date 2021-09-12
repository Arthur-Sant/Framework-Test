import UIKit

class TodosViewController: UIViewController {
    
    @IBOutlet weak var todosTableView: UITableView!
    
    @IBOutlet weak var todoSearchField: UITextField!
    
    
    @IBAction func searchField(_ sender: Any) {
        let fieldSize = self.todoSearchField.text?.count
        
        fetchData(){ (todos) in
            
            DispatchQueue.main.async {
                
                self.todoList = todos.filter(){ todo in
                    todo.title.prefix(fieldSize!) == self.todoSearchField.text!
                }
            
                self.todosTableView.reloadData()
            }
        }
    }
    
    var todoList: [Todo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        todosTableView.dataSource = self
        
        fetchData(){ (todos) in
        
            self.todoList = todos
            
            DispatchQueue.main.async {
                self.todosTableView.reloadData()
            }
            
        }
    }
    
    func fetchData(completion: @escaping ([Todo]) -> ()){
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let responseData = data else { return }
            
            do{
                var todos = try JSONDecoder().decode([Todo].self, from: responseData)
                
                todos.sort(by: {$0.title < $1.title})
                
                completion(todos)
                
            } catch {
                print(error)
            }
        }.resume()
    }

}

