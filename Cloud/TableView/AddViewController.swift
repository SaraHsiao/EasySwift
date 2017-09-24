//
//  AddViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/20.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit
import CoreData
import AVOSCloud

class AddViewController: UITableViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldProvince: UITextField!
    @IBOutlet weak var textFieldPart: UITextField!
    @IBOutlet weak var lblisVisited: UILabel!
    
    var area:AreaMO!
    var isVisited = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //使用 NSLayoutConstraint 代碼，將 coverImageView 進行，寬度、高度的 constraints 約束
        //coverImageView 的寬度(高度)等於 coverImageView 的父視圖`superview`的寬度(高度)
        let coverWidthCons = NSLayoutConstraint(item: coverImageView, attribute: .width, relatedBy: .equal, toItem: coverImageView.superview, attribute: .width, multiplier: 1, constant: 0)
        let coverHeightCons = NSLayoutConstraint(item: coverImageView, attribute: .height, relatedBy: .equal, toItem: coverImageView.superview, attribute: .height, multiplier: 1, constant: 0)
        
        coverWidthCons.isActive = true
        coverHeightCons.isActive = true
    }
    
    // MARK: - Action
    @IBAction func btnVisited(_ sender: UIButton) {
        
        switch sender.tag {
        case 666:
            isVisited = true
            lblisVisited.text = "YES, I have been here"
        case 999:
            isVisited = false
            lblisVisited.text = "NO, I have not been here"
        default:
            break
        }
    }
    
    // 要準備使用 CoreData 了，要直接將新增的資料，直接存儲起來
    // 這裡是 IBAction，而 IBOutlet 會在上方
    @IBAction func btnSave(_ sender: UIBarButtonItem) {
        
        // 在 save 之前，確定所有都有值
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        area = AreaMO(context: appDelegate.persistentContainer.viewContext)
        area.name = textFieldName.text
        area.address = textFieldAddress.text
        area.province = textFieldProvince.text
        area.part = textFieldPart.text
        area.isVisited = isVisited
        
        // 將圖片轉成 JPG 各式，`Representation 是表示的意思`
        if let imageData = UIImageJPEGRepresentation(coverImageView.image!, 0.7) {
            area.image = NSData(data: imageData)
        }
        print("Saving")
        appDelegate.saveContext()
        
        // 保存，設置在轉場之前 (確定保存成功，在轉場回去 tableViewController)
        saveToCloud(area: area)
        
        // 在 save 之後，直接回到 tableViewController
        performSegue(withIdentifier: "goBackTableVC", sender: self)
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
    
    // CoreData 是將新增的資料，儲存到本地(Xcode裡面)，現在使用 leanCloud 將新增的資料存儲到雲端
    // ==注意== 通常要將資料保存到雲端的時候，要格外注意 optional 的問題，`一定要有值` 才可以被存儲
    func saveToCloud(area:AreaMO!) {
        
        // 把 Area 對象轉換成一個 AVObject
        let cloudObject = AVObject(className: "Area")
        cloudObject["name"] = area.name!
        cloudObject["address"] = area.address!
        cloudObject["province"] = area.province!
        cloudObject["part"] = area.part!
        cloudObject["isVisted"] = area.isVisited
        
        // 為減小上傳文件的大小，超過 1024 的進行壓縮
        let orgImage = UIImage(data: area.image! as Data)!
        let scalingFactor = (orgImage.size.width > 1024) ? (1024 / orgImage.size.width) : 1
        
        // 為減小上傳文件的大小，超過 1024 的進行壓縮
        let scaledImage = UIImage(data: area.image! as Data, scale: scalingFactor)!
        
        // 對圖像、視屏的文件，採用 file 類型，圖片名稱設置為 area 的 name
        let imageFile = AVFile(name: "\(area.name!).jpg", data: UIImageJPEGRepresentation(scaledImage, 0.7)!)
        
        // 把圖像連接到 AVObject 對象
        cloudObject["image"] = imageFile
        
        // 後台保存並通知結果
        cloudObject.saveInBackground { (succeed, error) in
            if succeed {
                print("雲端保存成功")
            } else {
                print(error ?? "未知錯誤")
            }
        }
    }
}
