//
//  XunJianTJCell0.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/9.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit


class XunJianTJCell0: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource {

    
    @IBOutlet weak var label01: UILabel!
    
    @IBOutlet weak var textField01: UITextField!
    
    @IBOutlet weak var textField02: UITextField!
    
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var buttonShiFouFanXiu: UIButton!//是否返修
    @IBOutlet weak var buttonShiFouFanXiuQingXuanZe: UIButton!
    
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var buttonQueXianYuanYing: UIButton!//缺陷原因
    @IBOutlet weak var buttonQueXianYuanYingXuanZe: UIButton!
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var arrayDateImage:[UploadImageBean] = []
    
//    @property (nonatomic, copy) void(^blockDaTu)(NSInteger rowYZ);
//    - (void)buttonClickChaKanDaTuBlock:(void(^)(NSInteger rowYZ))block;
//    @property (nonatomic, copy) void(^blockAddImage)(void);
//    - (void)buttonAddImageBlock:(void(^)(void))block;

    var blockDaTu: (NSInteger) -> Void = {_ in }
    
    @objc func buttonClickChaKanDaTuBlock(block: @escaping (NSInteger) -> Void) {
        self.blockDaTu = block
    }
    
    var blockAddImage: () -> Void = {}

    @objc func buttonAddImageBlock(block: @escaping () -> Void) {
        self.blockAddImage = block
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var layout = UICollectionViewFlowLayout.init()
        layout.estimatedItemSize = CGSize(width: 0.1, height: 0.1)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.minimumLineSpacing = 0.1
        self.collectionView.collectionViewLayout = layout
        
        self.collectionView.register(UINib.init(nibName: "ZuoYeDanYuanTiJiaoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "zuoYeDanYuanTiJiaoCollectionViewCell")
        self.collectionView.register(UINib.init(nibName: "ZuoYeDanYuanTiJiaoCollectionViewCell1", bundle: nil), forCellWithReuseIdentifier: "zuoYeDanYuanTiJiaoCollectionViewCell1")
        self.collectionView.delegate = self as! UICollectionViewDelegate
        self.collectionView.dataSource = self as! UICollectionViewDataSource
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayDateImage.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < self.arrayDateImage.count {
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zuoYeDanYuanTiJiaoCollectionViewCell", for: indexPath) as! ZuoYeDanYuanTiJiaoCollectionViewCell
            cell.imageViewYZ?.image = UIImage(data: self.arrayDateImage[indexPath.row].data)
            cell.button?.addTarget(self, action: #selector(buttonClickChaKanDaTuD(_:)), for: UIControl.Event.touchUpInside)
            cell.button?.tag = indexPath.row
            return cell
        } else {
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zuoYeDanYuanTiJiaoCollectionViewCell1", for: indexPath) as! ZuoYeDanYuanTiJiaoCollectionViewCell1
            cell.button?.addTarget(self, action: #selector(buttonAddImage(_:)), for: UIControl.Event.touchUpInside)
            return cell
        }
    }
    
    @objc func buttonAddImage(_ button: UIButton) {
        self.blockAddImage()
    }
    
    @objc func buttonClickChaKanDaTuD(_ button: UIButton) {
        self.blockDaTu(button.tag)
    }
    
    
}
