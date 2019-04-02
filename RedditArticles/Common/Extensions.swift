//
//  Extensions.swift
//  RedditArticles
//
//  Created by Muddsar Butt on 2018-10-17.
//  Copyright © 2018 Muddsar Butt. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }
}


extension UIImageView {
    
    func setThumbnailImage(_ imgURLString: URL?) {
        guard let imageURL = imgURLString else {
            self.image = nil
            return
        }
        DispatchQueue.main.async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self.image = data != nil ? UIImage(data: data!) : nil
            }
        }
    }
}

