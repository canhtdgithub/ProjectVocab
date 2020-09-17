//
//  ToeicViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/4/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import iCarousel

class ToeicViewController: UIViewController, MyViewDelegate {
    
    var vocab = [Word700]()
    var star = [Bool]()
   
    //MARK: - @IBOUTLET

    @IBOutlet weak var viewHome: UIView!
    @IBOutlet weak var myIcarousel: iCarousel!
    
    //MARK: - @IBACTION
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - LIFE CYCLE VIEW
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initUi()
    }
    
}
    //MARK: - EXTENSION ICAROUSEL

extension ToeicViewController: iCarouselDelegate, iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return vocab.count
        
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let a = Bundle.main.loadNibNamed("MyView", owner: self, options: nil)?.first as? MyView
        a?.backgroundColor = .clear
        a?.config(value: vocab[index])
        a?.testShowStar(index: index)
        return a!
    }
    
}
    //MARK: - EXTENSION TOEIC VIEW CONTROLLER

extension ToeicViewController {
    private func initUi() {
        //custom icarousel
        myIcarousel.type = .cylinder
        //        myIcarousel.autoscroll = -0.1
        myIcarousel.delegate = self
        myIcarousel.dataSource = self
        getData()
        // Add Home View
        
        let view1 = Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)?.first as? HomeView
        view1?.dele = self
        view1!.frame = viewHome.bounds
        viewHome.addSubview(view1!)
        
        // Get data star in user default
        getDataStar()
    }
    func getData() {
        let path = Bundle.main.path(forResource: "700_TOEIC", ofType: "json")
        let get = try! Data(contentsOf: URL(fileURLWithPath: path!))
        
        vocab = try! JSONDecoder().decode([Word700].self, from: get)
        myIcarousel.reloadData()
        print(vocab)
    }
    // Protocol
    func didTapButton(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func getDataStar() {
        for _ in 0...vocab.count - 1 {
            star.append(false)
        }
        UserDefaults.standard.set(star, forKey: "star_toeic")
    }
    
   
}
    //MARK: - STRUCT WORD 700

struct Word700: Codable {
    var vocabulary: String
    var type: String
    var example: String
}
