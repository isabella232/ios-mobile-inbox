//
//  Copyright © 2019 Emarsys. All rights reserved.
//

import UIKit
import EmarsysSDK

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Emarsys.setContactWithContactFieldValue("biancalui")
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        navigationController?.pushViewController(EmarsysInboxController.new(), animated: true)
//        present(EmarsysInboxController.new(), animated: true, completion: nil)
    }
    
}
