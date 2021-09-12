import UIKit

class AlbumsViewController: UIViewController {
    
    @IBOutlet weak var albumsCollectionView: UICollectionView!
    @IBOutlet weak var albumsSearchField: UITextField!
    
    var albumsList: [Album] = []
    
    
    
    @IBAction func searhField(_ sender: Any) {
        let fieldSize = self.albumsSearchField.text?.count
        
        fetchData(){ (albums) in
            
            DispatchQueue.main.async {
                
                self.albumsList = albums.filter(){ album in
                    album.title.prefix(fieldSize!) == self.albumsSearchField.text!
                }
            
                self.albumsCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumsCollectionView.dataSource = self
        
        fetchData(){ (albums) in
        
            self.albumsList = albums
            
            DispatchQueue.main.async {
                self.albumsCollectionView.reloadData()
            }
        }
    }
    
    
    func fetchData(completion: @escaping ([Album]) -> ()){
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let responseData = data else { return }
            
            do{
                var albums = try JSONDecoder().decode([Album].self, from: responseData)
                
                albums.sort(by: {$0.title < $1.title})
                
                completion(albums)
                
            } catch {
                print(error)
            }
        }.resume()
    }
}
