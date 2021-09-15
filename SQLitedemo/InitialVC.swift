//
//  InitialVC.swift
//  SQLitedemo
//
//  Created by Vinay Patel on 14/09/2021.
//

import UIKit

class InitialVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnOpen(_ sender: Any) {
        
        let storybaord = UIStoryboard.init(name: UIDevice.current.userInterfaceIdiom == .phone ? "Main_iPhone" :"Main", bundle: nil)
        
        let vc = storybaord.instantiateViewController(withIdentifier: "NewChoiceVC")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
       // self.navigationController?.pushViewController(vc, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
