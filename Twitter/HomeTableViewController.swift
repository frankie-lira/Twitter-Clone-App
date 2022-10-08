

import UIKit

class HomeTableViewController: UITableViewController {

    
    var tweetArray = [NSDictionary]()
    var numberOfTweet: Int!
    
    let refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        numberOfTweet = 20
//        refresher.addTarget(self, action: #selctor(loadTwee), )
        
        
        refresher.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl = refresher
        
//        self.tweetTable.rowHeight = UITableView.automaticDimension
//        self.tweetTable.estimatedRowHeight = 150
        
//        loadTweet()

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweet()
    }

    
    
    
    @objc func loadTweet(){
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": 10]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            
            self.refresher.endRefreshing() //end refreshing icon
            
        }, failure: { (Error) in
            print("Could not retreive tweets!")
        })
        
        
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
        return cell
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }


}
