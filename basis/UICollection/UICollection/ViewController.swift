import UIKit

//集合视图列数,即:每一行有几个单元格
let COL_NUM = 3

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {

    var events = [String]()
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let plistPath = Bundle.main.path(forResource: "events", ofType: "plist")
        //获取属性列表文件中的全部数据
        self.events = ["A","B","A","B","A","B","A","B","A","B","A","B","A","B","A","B","A","B","A","B","A","B","A","B",]
        self.setupCollectionView()
        
        
    }
    
    func setupCollectionView(){
        
        //1. 创建流式布局(从左到右,从上到下)
        let layout = UICollectionViewFlowLayout()
        //2. 设置每个单元格的尺寸
        layout.itemSize = CGSize(width: 20, height: 20)
        //3. 设置整个collectionView的内边距
        layout.sectionInset = UIEdgeInsets(top: 15,left: 15,bottom: 20,right: 15)
        let screenSize = UIScreen.main.bounds.size
        //重新设置iPhone6/6s/7/7s/Plus
        if (screenSize.height > 568){
            layout.itemSize = CGSize(width: 30, height: 30)
            layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 20, right: 15)
        }
        
        //4. 设置单元格之间的间距
        layout.minimumInteritemSpacing = 5
        
        //创建集合视图UICollectionView对象的构造函数,第一个参数是设置集合视图frame属性,第二个参数是设置布局管理器对象
        self.collectionView = UICollectionView(frame: CGRect(x: 150, y: 150, width: 150, height: 150), collectionViewLayout: layout)
        
        //5. 设置可重用单元格标识与单元格类型
        self.collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        
        self.collectionView.backgroundColor = UIColor.white
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.layer.borderColor = .init(srgbRed: 255, green: 0, blue: 0, alpha: 1)
        self.collectionView.layer.borderWidth = 0.3
        
        self.collectionView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        self.collectionView.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.collectionView.layer.shadowOpacity = 1
        self.collectionView.layer.shadowRadius = 6
        self.collectionView.layer.masksToBounds = false
        self.collectionView.clipsToBounds = false
        
        
        
        //self.collectionView.layer.backgroundColor = CGColor.init(srgbRed: 255, green: 0, blue: 0, alpha: 1)
        self.view.addSubview(self.collectionView)
        
    }
    
    //实现数据源协议
    //提供视图中节的个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let num = self.events.count % COL_NUM
        if(num == 0){ //偶数
            return self.events.count / COL_NUM
        } else { //奇数
            return self.events.count / COL_NUM + 1
        }
    }
    //提供某个节中的列数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return COL_NUM
    }
    //为某个单元格提供显示数据
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //第一个参数是可重用单元格标识符
        //第二个参数是indexPath(一种复杂多维数组结构,常用属性有section和row,section是集合视图节索引,row是集合视图当前节中列(单元格)的索引)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! EventCollectionViewCell
        
        //计算events集合下表索引
        let idx = indexPath.section * COL_NUM + indexPath.row
        
        if(self.events.count <= idx) {//防止下标越界
            return cell
        }
        
        //let event = self.events[idx] as! NSDictionary
        
        cell.label.text = events[indexPath.row]
        //cell.imageView.image = UIImage(named: event["image"] as! String)
        cell.layer.masksToBounds = false
        return cell
        
    }

        

    
    
    //实现委托协议
    //选择单元格之后触发
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*let event = self.events[(indexPath as NSIndexPath).section * COL_NUM + (indexPath as NSIndexPath).row] as! NSDictionary
        print("selection event name: " , event["name"]!)*/
    }
    


}
