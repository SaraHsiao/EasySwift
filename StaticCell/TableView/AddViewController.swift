//
//  AddViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/20.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit

class AddViewController: UITableViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //使用 NSLayoutConstraint 代碼，將 coverImageView 進行，寬度、高度的 constraints 約束
        //coverImageView 的寬度(高度)等於 coverImageView 的父視圖`superview`的寬度(高度)
        let coverWidthCons = NSLayoutConstraint(item: coverImageView, attribute: .width, relatedBy: .equal, toItem: coverImageView.superview, attribute: .width, multiplier: 1, constant: 0)
        let coverHeightCons = NSLayoutConstraint(item: coverImageView, attribute: .height, relatedBy: .equal, toItem: coverImageView.superview, attribute: .height, multiplier: 1, constant: 0)
        
        coverWidthCons.isActive = true
        coverHeightCons.isActive = true
    }
}

// UIImagePickerControllerDelegate & UINavigationControllerDelegate
// 選擇圖像過後，必須遵從這個 delegate 才可以將選擇的圖像放置在 cell 中的 imageView 裡面
// 因為相簿裡面是 navigation 的型態，所以必須遵從 navigationController 的 delegate
extension AddViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 使用系統相簿，使用 guard 是因為，如果使用者不同意授權讀取相簿的時候，也不會報錯
        // 欲使用`相簿`&`相機`，必須在 plist 裡面去新增
        // private - photoLibrary & private - camera
        if indexPath.row == 0 {
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                print("Can't read photo library")
                return
            }
            
            let picker = UIImagePickerController()
            picker.isEditing = false
            picker.sourceType = .photoLibrary
            
            picker.delegate = self
            
            self.present(picker, animated: true, completion: nil)
        }
        
        // 取消選擇
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 選擇想要的圖片，使用 didFinishPickingMediaWithInfo，這個 info 是一個 dictionary 型別
        coverImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        
        // 選好欲要圖片，必須將相簿退場
        self.dismiss(animated: true, completion: nil)
    }
}
