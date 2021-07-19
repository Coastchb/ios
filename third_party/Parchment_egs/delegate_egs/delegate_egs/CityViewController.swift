import UIKit

class CityViewController: UIViewController {
  /*
    @IBAction func jump(_ sender: Any) {
        var nextResponder : UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            print("\(nextResponder)")
            
            if let responder = nextResponder as? UITabBarController {
                print("got it!")
                print("\(responder.children.first)")
                var navigation_VC = responder.children.first
                print("\(navigation_VC?.children.first)")
                
                if let vc = navigation_VC?.children.first as? delegate_egs.ViewController {
                    print("ok!")
                    //vc.selected_index = 2
                    responder.selectedViewController = navigation_VC
                    self.present(navigation_VC!, animated:true)
                    break
                    
                }
            }
        } while nextResponder != nil
    }*/
    init(title: String) {
    super.init(nibName: nil, bundle: nil)
    self.title = title
    
    let label = UILabel(frame: .zero)
    //let label = UILabel(frame: CGRect(x: 10.0, y: 200, width: 100.0, height: 30.0))
    label.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.thin)
    label.textColor = UIColor(red: 95/255, green: 102/255, blue: 108/255, alpha: 1)
    label.text = title
    label.sizeToFit()
    //label.alpha = 0.6
    view.addSubview(label)
    view.constrainCentered(label)
    
    let bt = UIButton(frame: CGRect(x:10.0, y:20.0, width:20.0, height: 30))
    bt.titleLabel?.text = title
    view.addSubview(bt)
    view.constrainCentered(bt)
    view.backgroundColor = .white
  }

    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func viewDidLoad() {
        self.view.backgroundColor = .gray
    }
}
