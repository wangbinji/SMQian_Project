//
//  SJDetailVC.swift
//  SJProject
//
//  Created by 王斌绩 on 2021/4/19.
//

import UIKit
import WebKit




protocol ViewControllerDelegate: AnyObject {
    func printCurrentName(username: String) -> Void
}




class SJDetailVC: UIViewController {
    
    weak var delegate: ViewControllerDelegate?
        
    var passText = ""
    var passName = ""
    var textView = UITextView()
    var mutAttStr = NSMutableAttributedString()
    var searchBtn = UIButton()
    
    var globalJsonStr = ""
    
    let gesture = UISwipeGestureRecognizer()
    
    var sjzPopBgView = UIView()
    var sjzPopview = UIView()
    var sjzScrollView = UIScrollView()
    private var bottomBarGestureHandler: GenericPanGestureHandler?
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = passText
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.init(white: 1, alpha: 1)
        self.delegate?.printCurrentName(username: "wangbinji")
        searchBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
//        searchBtn.setTitle("编辑", for: .normal)
//        searchBtn.setTitle("完成", for: .selected)
        searchBtn.setImage(UIImage.init(systemName: "doc.text.magnifyingglass"), for: .normal)
        searchBtn.setTitleColor(.systemOrange, for: .normal)
        searchBtn.addTarget(self, action: #selector(pressBtnSearch), for: .touchUpInside)
        let rightItem = UIBarButtonItem.init(customView: searchBtn)
        self.navigationItem.rightBarButtonItem = rightItem
        
//        self.view.backgroundColor = .white
    
        
        
       
        
    }
    
    func addBottomBar() {
//        self.view.window.addSubview(self.bottomBar)
//        self.view.window.addSubview(self.bottomOperateView)
        
        
        self.view.window?.addSubview(self.bottomBar)
        self.view.window?.addSubview(self.bottomOperateView)
        
        
        self.bottomBar.bottom = self.view.height
        self.bottomOperateView.y = self.bottomBar.bottom
        
        
        self.bottomBarGestureHandler = GenericPanGestureHandler.init(gestureView: bottomBarCoverView, handleView: bottomBar, minY: kStatusBarAndNavigationBarHeight, midY: self.view.height - 315 - kTabbarSafeBottomMargin, maxY: self.view.height - bottomBar.height)
        self.bottomBarGestureHandler?.offsetCompleteBlock = {
            print("do something")
        }
        self.bottomBarGestureHandler?.offsetChangeBlock = { [weak self] afterY, _,direction in
            self?.bottomOperateView.y = self?.bottomBar.bottom ?? 0
            if afterY < (self?.view.height ?? 0) - 267 - 48 {
                self?.bottomOperateView.height = (self?.view.height ?? 0) - (self?.bottomOperateView.y ?? 0)
            }else {
                self?.bottomOperateView.height = 267
            }
            if afterY < self!.view.height && self!.bottomOperateView.isHidden {
                self?.bottomOperateView.isHidden = false
            }
        }
        self.bottomBarGestureHandler?.shouldResponseGesture = {
            return true
        }
    
    }
    
    
    private lazy var bottomBar: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.width, height: 48 + 20))
        view.addSubview(bottomBarCoverView)

        view.backgroundColor = UIColor.clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        view.layer.shadowOpacity = Float(0.14)
        view.layer.shadowRadius = 3
        
        let label = UILabel.init()
        label.text = "三家注"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.sizeToFit()
        view.addSubview(label)
        label.centerX = view.width * 0.5
        label.centerY = view.height * 0.5
        
        return view
    }()
    
    private lazy var bottomBarCoverView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.width, height: 48 + 20))
        view.backgroundColor = UIColor.white
        
        view.clipsToBounds = false
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = UIColor.systemTeal.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: -5)
        return view
    }()
    
    private lazy var bottomOperateView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.width, height: 267 + kTabbarSafeBottomMargin))
//        view.backgroundColor = UIColor.init(red: 1.0, green: 102.0/255.0, blue: 0, alpha: 1.0)
        view.backgroundColor = .white
        return view
    }()
    
    @objc func gesture01() {
        let tempView = self.view.window!.viewWithTag(888)
        
//        tempView.transform = CGAffineTransform.init(translationX: 0, y: 300)
        UIView.animate(withDuration: 0.2) { [self] in
            tempView!.transform = CGAffineTransform.init(translationX: 0, y: 300)
            tempView?.removeFromSuperview()
        } completion: { (finish) in
            tempView!.backgroundColor = .darkGray
        }
    }
    
    
    @objc func pressBtnSearch() {
        
        let vc = SJMapVC()
        let nav = UINavigationController.init(rootViewController: vc)

        self.present(nav, animated: true, completion: nil)
        
        
        
        
        
//        let searchView = UISearchTextField.init(frame: CGRect(x: 100, y: 100, width: 120, height: 30))
//        searchView.center.x = self.view.center.x
//        searchView.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
////        searchView.layer.borderWidth = 1
////        searchView.layer.borderColor = UIColor.systemGreen.cgColor
//        self.view.window?.addSubview(searchView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sjzScrollView.removeFromSuperview()
        bottomOperateView.removeFromSuperview()
        bottomBarCoverView.removeFromSuperview()
        bottomBar.removeFromSuperview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let path = Bundle.main.url(forResource: "01", withExtension: "txt")
        let data = try! Data(contentsOf: path!)
        let jsonString = String(data: data, encoding: .utf8)
        self.globalJsonStr = jsonString!
        mutAttStr = NSMutableAttributedString.init(string: jsonString!)
        
        let style = NSMutableParagraphStyle.init()
        style.lineSpacing = 0
        style.firstLineHeadIndent = 40.0
        
        let shadow = NSShadow.init()
        shadow.shadowOffset = CGSize.init(width: 1, height: 2)
        shadow.shadowColor = UIColor.blue
        shadow.shadowBlurRadius = 3
        
        
        mutAttStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSMakeRange(0, jsonString!.count))
        mutAttStr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(0, jsonString!.count))
        
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: self.view.frame.size.width / 5, height: 50)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
//        layout.footerReferenceSize = CGSize(width: 300, height: 40)
        
        let sjtextDetailView = UICollectionView.init(frame: self.view.frame, collectionViewLayout: layout)
        sjtextDetailView.backgroundColor = .white
        sjtextDetailView.register(SJTextDetailCell.self, forCellWithReuseIdentifier: "Cell")
        sjtextDetailView.delegate = self
        sjtextDetailView.dataSource = self
//        sjtextDetailView.backgroundView = UIImageView.init(image: UIImage.init(named: "sj_icon_05.png"))
//        sjtextDetailView.layer.borderWidth = 2
//        sjtextDetailView.layer.borderColor = UIColor.green.cgColor
        sjtextDetailView.endEditing(true)
        gesture.addTarget(self, action: #selector(gesture01))
        gesture.direction = .down
        self.view.addSubview(sjtextDetailView)
    
        
//        let queue = DispatchQueue(label: "myQueue", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
//        queue.async {
//            print("-------00-------\(Thread.current)")
//            let array = self.searchSubString(sub: "太史公", parent: jsonString!)
//
//            DispatchQueue.main.async {
//                self.helightSubString(indexArray: array, color: .systemGreen, mutStr: self.mutAttStr, itemLength: 3)
//            }
//        }
//        queue.async {
//            print("-------01-------\(Thread.current)")
//            let array01 = self.searchSubString(sub: "司馬", parent: jsonString!)
//            DispatchQueue.main.async {
//                self.helightSubString(indexArray: array01, color: .systemGreen, mutStr: self.mutAttStr, itemLength: 2)
//            }
//        }
//
//        queue.async {
//            print("-------02-------\(Thread.current)")
//            let array02 = self.searchSubString(sub: "天子", parent: jsonString!)
//            DispatchQueue.main.async {
//                self.helightSubString(indexArray: array02, color: .systemRed, mutStr: self.mutAttStr, itemLength: 2)
//            }
//        }
        
//        queue.async {
//            print("-------03-------\(Thread.current)")
//            let array03 = self.searchSubString(sub: "君臣", parent: jsonString!)
//            DispatchQueue.main.async {
//                print("-------03-------\(Thread.current)")
//                self.helightSubString(indexArray: array03, color: .systemRed, mutStr: self.mutAttStr, itemLength: 2)
//            }
//        }
        
        
//        640840189.38879
//        640840189.631747          2495
        
        
//        640840242.272835
//        640840242.27357           174
        
        print(Date.timeIntervalSinceReferenceDate)
//        let aimStringArr = [ "太史公", "司馬", "天子", "君臣", "夫", "黄帝", "人"]
//        let colorArray = [UIColor.orange, UIColor.green, UIColor.blue, UIColor.purple, UIColor.red]
//
//        let array04 = searchSubString(subArray: aimStringArr, parent: jsonString!)
//        for i in 0..<aimStringArr.count {
//            helightSubString(indexArray: array04[i], color: colorArray.randomElement()!, mutStr: mutAttStr, itemLength: aimStringArr[i].count)
//
//        }
        print(Date.timeIntervalSinceReferenceDate)
        
        
        mutAttStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange.init(location: 0, length: jsonString!.count))
//        mutAttStr.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 4, range: NSRange.init(location: 22, length: 2))
//        mutAttStr.addAttribute(NSAttributedString.Key.shadow, value: shadow, range: NSRange.init(location: 40, length: 5))
//        mutAttStr.addAttribute(NSAttributedString.Key.link, value: url!, range: NSMakeRange(80, 8))
//        mutAttStr.addAttribute(NSAttributedString.Key.baselineOffset, value: 4, range: NSMakeRange(100, 9))
        mutAttStr.addAttribute(NSAttributedString.Key.link, value: URL.init(string: "https://www.baidu.com")!, range: NSMakeRange(0, 22))
        textView = UITextView.init(frame: self.view.frame)
        textView.contentOffset = .init(x: 0, y: -80)
        textView.isEditable = false
        textView.attributedText = mutAttStr
        textView.delegate = self
        textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
//        self.view.addSubview(textView)
        
//        mutAttStr.addAttribute(NSAttributedString.Key.link, value: URL.init(string: "https://www.baidu.com")!, range: NSMakeRange(0, 22))
        viewLayoutMarginsDidChange()
    }
    
    /// 用給定顏色高亮查找出的字符串
    /// - Parameters:
    ///   - indexArray: 所需高亮的字符串下標
    ///   - color: 顏色
    ///   - mutStr: 原始字符串
    ///   - itemLength: 目標字符串長度
    /// - Returns: 無
    func helightSubString(indexArray: Array<Int>, color: UIColor, mutStr: NSMutableAttributedString, itemLength: Int) -> Void {
        for item in indexArray {
//            mutStr.addAttribute(NSAttributedString.Key.link, value: URL.init(string: "https://www.baidu.com")!, range: NSMakeRange(item, itemLength))
            mutStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSMakeRange(item, itemLength))
        }
    }
    
    
    
    /// 查找符合條件的子字符串
    /// - Parameters:
    ///   - sub: 目標字符串
    ///   - parent: 父字符串
    /// - Returns: 返回索引
    func searchSubString(subArray: Array<String>, parent: String) -> Array<Array<Int>> {
        
        var array: Array<Array<Int>> = Array()
        for i in 0..<subArray.count {
            let array01: Array<Int> = Array()
            array.insert(array01, at: i)
        }
        
        
        for i in 0..<parent.count {
            let childStr = parent.subString(rang: NSRange.init(location: i, length: 1))
            
            for j in 0..<subArray.count {
                if childStr == subArray[j].substring(to: 1) {
                    let newChildStr = parent.subString(rang: NSRange.init(location: i, length: subArray[j].count))
                    if newChildStr == subArray[j] {
                        array[j].append(i)
                    }
                }
            }
        }
        return array
    }
    
}

extension SJDetailVC: UINavigationControllerDelegate {
    
}

extension SJDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            print(scrollView.contentOffset.y)
            if scrollView.contentOffset.y > 400 {
                return
            }
            if scrollView.tag == 888 {
//                scrollView.isScrollEnabled = true
                self.sjzScrollView.frame = CGRect(x: 0, y:  (self.view.frame.height - 300), width: self.view.frame.width, height: 300)
            }
            
        } else {
            print(scrollView.contentOffset.y)
//            self.navigationController?.navigationBar.isHidden = false

            sjzScrollView.transform = CGAffineTransform.init(translationX: 0, y: 0)
            if scrollView.tag == 888 && scrollView.contentOffset.y == 0 {
                UIView.animate(withDuration: 0.2) { [self] in
                    sjzScrollView.transform = CGAffineTransform.init(translationX: 0, y: 300)
                } completion: { [self] (finish) in
                    sjzScrollView.removeFromSuperview()
                }
            }
            
           
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//                        UIView.animate(withDuration: 1) { [self] in
//                            sjzScrollView.transform = CGAffineTransform.init(translationX: 0, y: 300)
//                        } completion: { [self] (finish) in
//                            sjzScrollView.removeFromSuperview()
//                        }
    }
}

extension SJDetailVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemStr = globalJsonStr.subString(rang: NSMakeRange(indexPath.item * 1, 1))
        print(itemStr)
        
        let alertController = UIAlertController.init(title: "提示", message: itemStr, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "确定", style: .destructive, handler: nil))
//        present(alertController, animated: true, completion: nil)
        
        sjzScrollView.removeFromSuperview()
        sjzScrollView = UIScrollView.init(frame: CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300))
        sjzScrollView.backgroundColor = UIColor.systemBackground
        sjzScrollView.delegate = self
        sjzScrollView.tag = 888
        sjzScrollView.layer.shadowOffset = CGSize(width: -10, height: -10)
        sjzScrollView.layer.shadowColor = UIColor.red.cgColor
        sjzScrollView.contentSize = CGSize(width: self.view.frame.width, height: 1500)
        
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        label.text = "三家注"
//        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.center.x = sjzScrollView.center.x
        sjzScrollView.addSubview(label)
        
        
        let textView = UITextView.init(frame: CGRect(x: 0, y: 20, width: self.view.frame.width - 40, height: 400))
        textView.backgroundColor = .cyan
        textView.center.x = sjzScrollView.center.x
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGreen.cgColor
        textView.text = "【集解】：凡是徐氏义，称徐姓名以别之。馀者悉是骃注解，并集众家义。【索隐】：纪者，记也。本其事而记之，故曰本纪。又纪，理也，丝缕有纪。而帝王书称纪者，言为後代纲纪也。【正义】：郑玄注中候敕省图云：“德合五帝坐星者，称帝。”又坤灵图云：“德配天地，在正不在私，曰帝。”案：太史公依世本、大戴礼，以黄帝、颛顼、帝喾、唐尧、虞舜为五帝。谯周、应劭、宋均皆同。而孔安国尚书序，皇甫谧帝王世纪，孙氏注世本，并以伏牺、神农、黄帝为三皇，少昊、颛顼、高辛、唐、虞为五帝。裴松之史目云“天子称本纪，诸侯曰世家”。本者，系其本系，故曰本；纪者，理也，统理众事，系之年月，名之曰纪；第者，次序之目；一者，举数之由：故曰五帝本纪第一。礼云：“动则左史书之，言则右史书之。”正义云：“左阳，故记动。右阴，故记言。言为尚书，事为春秋。”案：春秋时置左右史，故云史记也。"
        sjzScrollView.addSubview(textView)
        
        
        
        bottomOperateView.addSubview(textView)
        
        
        sjzPopBgView = UIView.init(frame: CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300))
        sjzPopBgView.tag = 999
        sjzPopBgView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        sjzPopBgView.addGestureRecognizer(gesture)
        
        
        sjzPopview = UIView.init(frame: CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300))
        sjzPopview.backgroundColor = .orange
//        sjzScrollView.addSubview(sjzPopview)
        
        var appear = false
        
        for item in self.view.window!.subviews {
            if item.tag != 888 {
                appear = false
            } else {
                appear = true
            }
        }
//        if !appear {
//            sjzScrollView.removeFromSuperview()
//            self.view.window?.addSubview(sjzScrollView)
//        }
        
        
//        sjzScrollView.transform = CGAffineTransform.init(translationX: 0, y: 300)
//        UIView.animate(withDuration: 3) { [self] in
//            sjzScrollView.transform = CGAffineTransform.init(translationX: 0, y: 0)
//        } completion: { [self] (finish) in
////            sjzPopBgView.backgroundColor = .orange
//        }
        
        
        addBottomBar()
        
    }
    

}

extension SJDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return globalJsonStr.count / 1 + 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SJTextDetailCell
        
        let colorArray = [ UIColor.blue, UIColor.red, UIColor.green, UIColor.cyan, UIColor.orange]
//        cell.backgroundColor = colorArray.randomElement()
        let textArray = [ "昔在", "顓頊", "命南正", "重以司", "天", "北正黎", "以司地", "唐虞", "之際", "紹重黎", "之後", "使復", "典之", "至於", "夏商", "故", "重黎氏", "世序", "天地", "其在周", "程伯休甫", "其後", "也", "當", "周宣王", "時", "失其守", "而為", "司馬氏", "司馬氏", "世典", "周史" ]
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemGray.cgColor
//        cell.titleLabel.text = textArray.randomElement()
        cell.titleLabel.backgroundColor = UIColor.systemBackground
//        cell.titleLabel.font = UIFont.systemFont(ofSize: 35)
        cell.titleLabel.textAlignment = .center
//        cell.titleLabel.textColor = UIColor.systemBackground
        cell.titleLabel.text = globalJsonStr.subString(rang: NSMakeRange(indexPath.item * 1, 1))
    
//        if indexPath.item % 3 == 0 {
//            cell.titleLabel.backgroundColor = UIColor.orange
//        } else {
//            cell.titleLabel.backgroundColor = UIColor.white
//        }
        cell.titleLabel.alpha = 0.2
        cell.titleLabel.font = UIFont.systemFont(ofSize: 10)
        UIView.animate(withDuration: 2) {
            cell.titleLabel.alpha = 1
            cell.titleLabel.font = UIFont.systemFont(ofSize: 35)
            
            if indexPath.item % 3 == 0 {
//                cell.titleLabel.backgroundColor = UIColor.systemGreen
            } else if indexPath.item % 3 == 2 {
//                cell.titleLabel.backgroundColor = UIColor.systemYellow
            } else {
//                cell.titleLabel.backgroundColor = UIColor.white
            }
        }
        return cell
        
    }
    
    
}


extension SJDetailVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString.contains("https") {
            pressBtnSearch()
            return false
        }
        return false
    }
}



extension String{
    
    /// 从某个位置开始截取：
    /// - Parameter index: 起始位置
    public func substring(from index: Int) -> String {
        if(self.count > index){
            let startIndex = self.index(self.startIndex,offsetBy: index)
            let subString = self[startIndex..<self.endIndex];
            return String(subString);
        }else{
            return ""
        }
    }
    
    /// 从零开始截取到某个位置：
    /// - Parameter index: 达到某个位置
    public func substring(to index: Int) -> String {
        if(self.count > index){
            let endindex = self.index(self.startIndex, offsetBy: index)
            let subString = self[self.startIndex..<endindex]
            return String(subString)
        }else{
            return self
        }
    }
    
    /// 某个范围内截取
    /// - Parameter rangs: 范围
    public func subString(rang rangs:NSRange) -> String{
        var string = String()
        if(rangs.location >= 0) && (self.count > (rangs.location + rangs.length)){
            let startIndex = self.index(self.startIndex,offsetBy: rangs.location)
            let endIndex = self.index(self.startIndex,offsetBy: (rangs.location + rangs.length))
            let subString = self[startIndex..<endIndex]
            string = String(subString)
        }
        return string
    }
    

    
}
