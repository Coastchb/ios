import UIKit

var a = 1

switch a {
case 1 :
    print("0")
    break
print("1")
case 2:
    print("2")
default:
    print("3")
}

var str = "<html>>无法连接到目标服务器，请刷新页面重试</p> <p>请试试以下办法：</p> <ul> <li>联系站点负责人迁移服务至标准 Web 端口(80/8080/8081/443)</li> </ul> <div class='errinfo'>该站点可能因使用了非标准 Web 端口而导致无法正常使用</div> <div class='errcode'>Agent v2.3.0.4: ILLEGALPORT</div> <p><button  onclick=>重新加载</button></p> </div> </body> </html>"

if(str.contains("443")) {
    print("E")
}
