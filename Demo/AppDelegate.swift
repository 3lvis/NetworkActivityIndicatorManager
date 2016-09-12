import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: Controller())
        self.window!.makeKeyAndVisible()
        return true
    }
}

class Controller: UITableViewController {
    struct Option {
        var activated = false
    }

    var dataSource = [Option(), Option(), Option(), Option()]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Simulated activities"
        self.tableView.rowHeight = 60
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        let option = self.dataSource[indexPath.row]
        cell.textLabel?.text = option.activated ? "Stop activity" : "Run activity"
        cell.textLabel?.textColor = option.activated ? UIColor.red : UIColor.blue

        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.hidesWhenStopped = true
        cell.accessoryView = indicator

        if option.activated {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var option = self.dataSource[indexPath.row]
        option.activated = !option.activated
        self.dataSource[indexPath.row] = option

        NetworkActivityIndicator.sharedIndicator.visible = option.activated

        self.tableView.reloadData()
    }
}
