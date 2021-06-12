//
//  ViewController.swift
//  SJProject
//
//  Created by 王斌绩 on 2021/4/19.
//

import UIKit
import WebKit
import QuickLook

class ViewController: UIViewController {
    let sectionTitle = ["十二本紀", "十表", "八書", "三十世家", "七十列傳"]
    var BenJiList = Array<Any>()
    var BiaoList = Array<Any>()
    var ShuList = Array<Any>()
    var ShiJiaList = Array<Any>()
    var LieZhuanList = Array<Any>()
    
    
    var tableView = UITableView()
    var rightBtn = UIButton()
    
    var menuView = UIView()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "史記";
        tableView = UITableView.init(frame: self.view.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self;
        tableView.dataSource = self
        tableView.isEditing = false
//        tableView.backgroundView = UIImageView.init(image: UIImage.init(named: "02.png"))
        self.view .addSubview(tableView)
        
        rightBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        rightBtn.setTitle("编辑", for: .normal)
        rightBtn.setTitle("完成", for: .selected)
        rightBtn.setTitleColor(.systemOrange, for: .normal)
        rightBtn.addTarget(self, action: #selector(pressBtnOne), for: .touchUpInside)
        let rightItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
        
        let leftBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        leftBtn.setTitle("关于", for: .normal)
        leftBtn.setTitleColor(.red, for: .normal)
        leftBtn.addTarget(self, action: #selector(pressBtnTwo), for: .touchUpInside)
        let leftItem = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = leftItem
        
        
        
        
        
        
        let path = Bundle.main.path(forResource: "SJCategory", ofType: "plist")
        let dict = NSDictionary.init(contentsOfFile: path!)
        
        var swiftDict = Dictionary<String, Any>.init()
        swiftDict = dict?.copy() as! [String : Any]
//        for bookname in swiftDict.keys {
//            print(bookname)
//        }
//
//        for bookcontent in swiftDict.values {
//            print(bookcontent)
//        }
       
        let dictionary = ["userName": "xiaoming", "sex": "Male", "grade": "A", "hometown": "NewYork"]
        
        let newDict = dictionary.map { (value: String, value1: String) -> Dictionary<String, String> in
            print(value1)
            return ["Hello": "World"]
        }
        
    
       
        

//        let newDict = dictionary.map { (value: String) -> String in
//            return "Hello"
//        }
        
//       print(newDict)
    
        
        BenJiList = dict?.object(forKey: "BenJi") as! [Any]
        BiaoList = dict?.object(forKey: "Biao") as! [Any]
        ShuList = dict?.object(forKey: "Shu") as! [Any]
        ShiJiaList = dict?.object(forKey: "ShiJia") as! [Any]
        LieZhuanList = dict?.object(forKey: "LieZhuan") as! [Any]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func pressBtnOne() {
        tableView.isEditing = !tableView.isEditing
        rightBtn.isSelected = !rightBtn.isSelected
    }
    
    @objc func pressBtnThree() {
//        let webView = WKWebView.init(frame: CGRect(x: 300, y: 0, width: self.view.frame.width - 300, height: self.view.frame.height))
////        webView.load(URLRequest.init(url: URL.init(string: "https://wangbinji.github.io")!))
//        let vc = UIViewController.init()
//        let url = Bundle.main.path(forResource: "i17_01327_0001", ofType: "pdf")
//        let request = URLRequest.init(url: URL.init(string: url!)!)
//        webView.load(request)
////        webView.load(URLRequest.init(url: URL.ini))
//        vc.view.addSubview(webView)
//
//        self.present(vc, animated: true, completion: nil)
        gesture()
    }
    
    @objc func pressBtnTwo() {
        print("NanJing")
        menuView = UIView.init(frame: CGRect(x: 0, y: 0, width: 300, height: self.view.frame.height + 20))
        let image = UIImageView.init(image: UIImage.init(named: "sj_icon_03.png"))
        image.frame = CGRect(x: 20, y: 60, width: 80, height: 160)
//        image.clipsToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.black.cgColor
        
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        image.layer.shadowRadius = 20
        image.layer.shadowColor = UIColor.systemBlue.cgColor
        image.layer.shadowOpacity = 1
        image.clipsToBounds = false
        
        menuView.addSubview(image)
        
        
        menuView.backgroundColor = UIColor.systemBackground
        self.view.window?.addSubview(menuView)
        
        let button = UIButton.init(frame: CGRect(x: 260, y: 40, width: 40, height: 40))
        button.setTitle("🔙", for: .normal)
        button.addTarget(self, action: #selector(pressBtnThree), for: .touchUpInside)
        menuView.addSubview(button)
        
     
        menuView.transform = CGAffineTransform.init(translationX: -300, y: 0)
        UIView.animate(withDuration: 0.2) { [self] in
            menuView.transform = CGAffineTransform.init(translationX: 0, y: 0)
        } completion: { (finish) in
//            self.menuView.backgroundColor = .white
        }
        
        let swipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(gesture))
        swipeGesture.direction = .left
        menuView.addGestureRecognizer(swipeGesture)
    }
    
    @objc func gesture() {
        UIView.animate(withDuration: 0.2) { [self] in
            menuView.transform = CGAffineTransform.init(translationX: -300, y: 0)
        } completion: { (finish) in

        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = self.view.frame
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
//            return dataSource[section].count
            return BenJiList.count
        } else if section == 1 {
            return BiaoList.count
        } else if section == 2 {
            return ShuList.count
        } else if section == 3 {
            return ShiJiaList.count
        } else if section == 4 {
            return LieZhuanList.count
        }
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        cell.contentView.backgroundColor = UIColor.clear
//        cell.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        cell.selectionStyle = .none
//        cell.textLabel?.textColor = .white
        if indexPath.section == 0 {
            cell.textLabel?.text = BenJiList[indexPath.row] as? String
            
        } else if indexPath.section == 1 {
            cell.textLabel?.text = BiaoList[indexPath.row] as? String
        } else if indexPath.section == 2 {
            cell.textLabel?.text = ShuList[indexPath.row] as? String
        } else if indexPath.section == 3 {
            cell.textLabel?.text = ShiJiaList[indexPath.row] as? String
        } else if indexPath.section == 4 {
            cell.textLabel?.text = LieZhuanList[indexPath.row] as? String
        }
        
        return cell
        
    }
    
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
//            self.navigationController?.navigationBar.isHidden = true
        } else {
//            self.navigationController?.navigationBar.isHidden = false
        }
    }
}

extension ViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let bookObject = CustObject()
        let path = Bundle.main.path(forResource: "i17_01327_0001", ofType: "pdf")
        
        bookObject.previewItemURL = URL.init(fileURLWithPath: path!)
        bookObject.previewItemTitle = "文档预览"
        return bookObject
        
    }
}

extension ViewController: QLPreviewControllerDelegate {
    func previewController(_ controller: QLPreviewController, editingModeFor previewItem: QLPreviewItem) -> QLPreviewItemEditingMode {
        return .updateContents
    }
    
//    func previewController(_ controller: QLPreviewController, transitionViewFor item: QLPreviewItem) -> UIView? {
//        let view = UIView.init()
//        view.frame = self.view.frame
//        view.backgroundColor = .red
//        return view
//    }
}


class CustObject: NSObject, QLPreviewItem {
    var previewItemURL: URL?
    
    var previewItemTitle: String?
}

extension ViewController: ViewControllerDelegate {
    func printCurrentName(username: String) {
        print("wangbinji--------------")
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        let vc = SJDetailVC()
        vc.delegate = self
        if indexPath.section == 0 {
            vc.passText = BenJiList[indexPath.row] as! String
            vc.passName = "benji_0\(indexPath.row + 1)"
        } else if indexPath.section == 1 {
            let quickLock = QLPreviewController()
            quickLock.delegate = self
            quickLock.dataSource = self
            quickLock.isEditing = true
            
            present(quickLock, animated: true, completion: nil)
            return
            vc.passText = BiaoList[indexPath.row] as! String
            vc.passName = "03"
        } else if indexPath.section == 2 {
            let vc = SJSJZVC()
            self.navigationController?.pushViewController(vc, animated: true)
            return
//            vc.passText = ShuList[indexPath.row] as! String
//            vc.passName = "01"
        } else if indexPath.section == 3 {
            vc.passText = ShiJiaList[indexPath.row] as! String
            vc.passName = "02"
            
//            let newclass: AnyClass<> = NSClassFromString("SJMapVC")
//            let newclassone: ViewController = newclass()
//            present(newclassone, animated: true, completion: nil)
//            return
            
            NSStringFromClass(ViewController.self)
//            printCurrentName(username: "")
        } else if indexPath.section == 4 {
            vc.passText = LieZhuanList[indexPath.row] as! String
            vc.passName = "02"
            let newvc = BenJiDetailView()
            present(newvc, animated: true, completion: nil)
            return
            
        }

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .insert
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section == destinationIndexPath.section {
            if sourceIndexPath.section == 0 {
                let item = BenJiList[sourceIndexPath.row]
                BenJiList.remove(at: sourceIndexPath.row)
                BenJiList.insert(item, at: destinationIndexPath.row)
                
            } else if sourceIndexPath.section == 1 {
                let item = BiaoList[sourceIndexPath.row]
                BiaoList.remove(at: sourceIndexPath.row)
                BiaoList.insert(item, at: destinationIndexPath.row)
            } else if sourceIndexPath.section == 2 {
                let item = ShuList[sourceIndexPath.row]
                ShuList.remove(at: sourceIndexPath.row)
                ShuList.insert(item, at: destinationIndexPath.row)
            } else if sourceIndexPath.section == 3 {
                let item = ShiJiaList[sourceIndexPath.row]
                ShiJiaList.remove(at: sourceIndexPath.row)
                ShiJiaList.insert(item, at: destinationIndexPath.row)
            } else if sourceIndexPath.section == 4 {
                let item = LieZhuanList[sourceIndexPath.row]
                LieZhuanList.remove(at: sourceIndexPath.row)
                LieZhuanList.insert(item, at: destinationIndexPath.row)
            }
        } else {
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        var content = String()
        
        if indexPath.section == 0 {
            content = BenJiList[indexPath.row] as! String
        } else if indexPath.section == 1 {
            content = BiaoList[indexPath.row] as! String
        } else if indexPath.section == 2 {
            content = ShuList[indexPath.row] as! String
        } else if indexPath.section == 3 {
            content = ShiJiaList[indexPath.row] as! String
        } else if indexPath.section == 4 {
            content = LieZhuanList[indexPath.row] as! String
        }
        let alert = UIAlertController.init(title: "提示", message: content, preferredStyle: .alert)
        let affirm = UIAlertAction.init(title: "確定", style: .default, handler: nil)
        alert.addAction(affirm)
//        self.present(alert, animated: true, completion: nil)
        
        let center = UNUserNotificationCenter.current()
        let content01 = UNMutableNotificationContent.init()
        content01.title = "史記"
        content01.subtitle = content;
        content01.sound = .default
        let tirgger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest.init(identifier: "noticeId", content: content01, trigger: tirgger)
        center.add(request) { (error) in
            print(error)
        }
        
        
        
        
        
    }
}

