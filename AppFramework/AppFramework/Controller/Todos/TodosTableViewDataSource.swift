import UIKit

extension TodosViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoCell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        
        let todo = todoList[indexPath.row]
        
        if todo.completed == true{
            todoCell.checkTodo.image = UIImage(systemName: "checkmark.square")
        }else{
            todoCell.checkTodo.image = UIImage(systemName: "square")
        }

        todoCell.title.text = todo.title
        
        return todoCell
    }
    
    
}
