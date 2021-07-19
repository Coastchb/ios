import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var label: UILabel!
    
    //重写构造函数,在该构造函数中实例化单元格包含的各个子视图属性对象.
    override init(frame: CGRect){
        super.init(frame: frame)
        
        //单元格的宽度
        let cellWidth: CGFloat = self.frame.size.width
        
        let imageViewWidth: CGFloat = 101
        let imageViewHeight: CGFloat = 101
        let imageViewTopView: CGFloat = 15
        
        //1.添加ImageView
        self.imageView = UIImageView(frame: CGRect(x: (cellWidth - imageViewWidth)/2, y: imageViewTopView, width: imageViewWidth, height: imageViewHeight))
        self.addSubview(self.imageView)   //子视图添加到单元格视图
        
        //2. 添加标签
        let labelWidth: CGFloat = 101
        let labelHeight: CGFloat = 16
        let labelTopView: CGFloat = 120
        self.label = UILabel(frame: CGRect(x: (cellWidth - labelWidth)/2, y: labelTopView, width: labelWidth, height: labelHeight))
        
        self.label.textAlignment = .center
        self.label.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(self.label)
        
    }
    
    //该构造函数是单元格视图父类要求必须实现的.
    //单元格视图父类中声明实现NSCoding协议,子类中要求实现该构造函数(但本例中并未用到该构造函数.)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
