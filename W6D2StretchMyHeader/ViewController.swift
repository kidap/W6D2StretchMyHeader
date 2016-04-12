//
//  ViewController.swift
//  W6D2StretchMyHeader
//
//  Created by Karlo Pagtakhan on 04/12/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//

import UIKit

let kTableHeaderHeight:CGFloat = 200.0
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var headerDataLabel: UILabel!
  @IBOutlet weak var customTableHeaderView: UIView!
  
  var sourceArray = [Dictionary<String,String>]()
  
  enum NewsCategory:String {
    case World
    case Americas
    case Europe
    case MiddleEast = "Middle East"
    case Africa
    case AsiaPacific = "Asia Pacific"
    
    func getTitleTextColor()->UIColor{
      switch self {
      case .World:
        return UIColor.redColor()
      case .Americas:
        return UIColor.blueColor()
      case .Europe:
        return UIColor.greenColor()
      case .MiddleEast:
        return UIColor.yellowColor()
      case .Africa:
        return UIColor.orangeColor()
      case .AsiaPacific:
        return UIColor.purpleColor()
      }
    }
  }
  struct NewsItem{
    var category :NewsCategory
    var headline = ""
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.prepareData()
    self.prepareView()
    self.prepareDelegates()
  }
  
  //MARK: Preparation
  func prepareData(){
    let formatter = NSDateFormatter()
    formatter.dateFormat = "MMMM dd"
    self.headerDataLabel.text = formatter.stringFromDate(NSDate())

    var data:Dictionary<String,String> = ["category": NewsCategory.World.rawValue ,
                                          "headline": "Climate change protests, divestments meet fossil fuels realities"]
    self.sourceArray.append(data)
    
    data = [ "category": NewsCategory.Europe.rawValue,
             "headline": "Scotland's 'Yes' leader says independence vote is 'once in a lifetime"]
    self.sourceArray.append(data)
    
    data = [ "category": NewsCategory.MiddleEast.rawValue,
             "headline": "Airstrikes boost Islamic State, FBI director warns more hostages possible"]
    self.sourceArray.append(data)
    
    data = [ "category": NewsCategory.Africa.rawValue,
             "headline": "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"]
    self.sourceArray.append(data)
    
    data = [ "category": NewsCategory.AsiaPacific.rawValue,
             "headline": "Despite UN ruling, Japan seeks backing for whale hunting"]
    self.sourceArray.append(data)
    
    data = [ "category": NewsCategory.Americas.rawValue,
             "headline": "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"]
    self.sourceArray.append(data)
    
    data = [ "category": NewsCategory.World.rawValue,
             "headline": "South Africa in $40 billion deal for Russian nuclear reactors"]
    self.sourceArray.append(data)
    
    data = [ "category": NewsCategory.Europe.rawValue,
             "headline": "One million babies' created by EU student exchanges"]
    self.sourceArray.append(data)
  
  }
  func prepareView(){
    //Dynamic size of table view cell
    self.tableView.estimatedRowHeight = 66
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
    self.navigationController?.navigationBar.hidden = true
    UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .None)
    
    //Table view properties
    self.tableView.tableHeaderView = nil
    self.tableView.addSubview(self.customTableHeaderView)
    
    self.customTableHeaderView.frame.origin.y -= kTableHeaderHeight
    
    self.tableView.contentInset.top = kTableHeaderHeight
    self.tableView.contentOffset.y = -kTableHeaderHeight
  }
  func prepareDelegates(){
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  //MARK: TableView delegate/datasource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.sourceArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
    
    let newsCat: NewsCategory =  NewsCategory.init(rawValue: self.sourceArray[indexPath.row]["category"]!)!
    cell.categoryLabel.text = newsCat.rawValue
    cell.categoryLabel.textColor = newsCat.getTitleTextColor()
    cell.headlineLabel.text = self.sourceArray[indexPath.row]["headline"]!
    return cell
    
  }
  //MARK: ScrollView delegate
  func scrollViewDidScroll(scrollView: UIScrollView) {
    print(self.tableView.contentInset)
    print(self.tableView.contentOffset)
    self.updatedHeaderView()
  }
  //MARK: Helper methods
  func updatedHeaderView(){
    if self.tableView.contentOffset.y < -kTableHeaderHeight{
      self.customTableHeaderView.frame.origin.y = self.tableView.contentOffset.y
      self.customTableHeaderView.frame.size.height = kTableHeaderHeight + -self.tableView.contentOffset.y - kTableHeaderHeight
      
      print(self.customTableHeaderView.frame.origin.y)
      print(self.customTableHeaderView.frame.size.height)
    }
  }
  
  
}
