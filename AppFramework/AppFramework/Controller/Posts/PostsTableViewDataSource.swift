import UIKit

extension PostsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        
        let post = postList[indexPath.row]
        
        let imageUrl = URL(string: "https://source.unsplash.com/random")!
        
        URLSession.shared.dataTask(with: imageUrl) { (imageData, imageResponse, imageError) in
            
            DispatchQueue.main.async {
                postCell.postImage.image = UIImage(data: imageData!)
            }
            
           }.resume()
        
        postCell.title.text = post.title
        postCell.body.text = post.body
        
        return postCell
    }
    
    
}
