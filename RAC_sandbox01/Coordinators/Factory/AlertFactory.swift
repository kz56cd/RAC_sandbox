//
//  AlertFactory.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/24.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit

struct AlertFactory {

    static func makeNetworkErrorAlert() -> UIAlertController {
        return UIAlertController(
            title: "通信エラー",
            message: "通信に失敗しました。\nしばらく経ってから、再検索して下さい。",
            preferredStyle: .alert)
    }
}
