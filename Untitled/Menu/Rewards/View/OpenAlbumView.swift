//
//  OpenAlbumView.swift
//  Untitled
//
//  Created by Julia Conti Mestre on 22/10/20.
//

import UIKit

class OpenAlbumView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var albumPage: UIImageView!
    @IBOutlet weak var topPhoto: UIImageView!
    @IBOutlet weak var bottomPhoto: UIImageView!
    @IBOutlet weak var topDescription: UIImageView!
    @IBOutlet weak var bottomDescription: UIImageView!
    
    @IBOutlet weak var topPhotoWidth: NSLayoutConstraint!
    @IBOutlet weak var topPhotoTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topPhotoLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topPhotoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingPhotoConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingPhotoConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topPhotoButton: UIButton!
    @IBOutlet weak var bottomPhotoButton: UIButton!
    
    weak var photoDetailDelegate: PhotoDetail?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("OpenAlbum", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func topPhotoTapped(_ sender: Any) {
        photoDetailDelegate?.showPhotoDetail(photoPosition: 0)
    }
    
    @IBAction func bottomPhotoTapped(_ sender: Any) {
        photoDetailDelegate?.showPhotoDetail(photoPosition: 1)
    }
    
}
