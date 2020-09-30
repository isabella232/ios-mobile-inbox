//
//  Copyright © 2020 Emarsys. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func color(fromHexCode hex: UInt64) -> UIColor {
        let r = ((CGFloat)((hex & 0xFF000000) >> 24)) / 255.0
        let g = ((CGFloat)((hex & 0x00FF0000) >> 16)) / 255.0
        let b = ((CGFloat)((hex & 0x0000FF00) >> 8)) / 255.0
        let a = ((CGFloat)((hex & 0x000000FF) >> 0)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
}

extension DateFormatter {
    
    static let yyyyMMddHHmm: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        return df
    }()
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
