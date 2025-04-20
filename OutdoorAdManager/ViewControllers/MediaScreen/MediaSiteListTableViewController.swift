//
//  MediaSiteListTableViewController.swift
//  OutdoorAdManager
//
//  Created by KEATON on 4/18/25.
//
import UIKit
import CoreData

class MediaSiteListTableViewController: UITableViewController {

    private var mediaSites: [MediaSite] = []

    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "사이트 목록"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fetchSites()
    }

    private func fetchSites() {
        let request: NSFetchRequest<MediaSite> = MediaSite.fetchRequest()
        if let results = try? context.fetch(request) {
            mediaSites = results
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaSites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let site = mediaSites[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = site.name ?? "(이름 없음)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let site = mediaSites[indexPath.row]
            
            let screenVC = MediaScreenListViewController()
            screenVC.mediaSite = site
            navigationController?.pushViewController(screenVC, animated: true)

    }
}
