//
//  LibraryPageViewController.swift
//  InstagramApp
//
//  Created by Aviral on 29/03/22.
//  Copyright © 2022 Gwinyai Nyatsoka. All rights reserved.
//

import UIKit
import Photos

class LibraryPageViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    var images:[PHAsset] = [PHAsset]()
    var imageSize: CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getDeviceImages()
    }
    
    func getDeviceImages(){
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            self.getImages()
        }else{
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .notDetermined,.denied,.restricted:
                    return
                case .authorized,.limited:
                    self.getImages()
                @unknown default:
                    return
                }
            }
        }
    }
    
    private func getImages(){
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image,options: nil)
        assets.enumerateObjects { [self] object, count, stop in
            images.append(object)
            let asset = object as! PHAsset
            imageSize = CGSize(width: asset.pixelWidth,height: asset.pixelHeight)
            print("Image Size:::: \(imageSize)")
        }
        images.reverse()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}


extension LibraryPageViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LibraryImageCollectionViewCell", for: indexPath) as! LibraryImageCollectionViewCell
        let imageData = images[indexPath.row]
        let manager = PHImageManager.default()
        
        if cell.tag != 0 {
            manager.cancelImageRequest(PHImageRequestID(cell.tag))
        }
        
        cell.tag = Int(manager.requestImage(for: imageData, targetSize: imageSize, contentMode: PHImageContentMode.aspectFill, options: nil, resultHandler: { image, _ in
            cell.imageView.image = image
        }))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = self.view.frame.width * 0.2
        let height = self.view.frame.width * 0.2
        return CGSize(width: width, height: height)
    }

    

    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 2.5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
}
