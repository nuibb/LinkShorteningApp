//
//  LinkShorteningAppWrapper.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 18/1/23.
//

import SwiftUI

@main
struct LinkShorteningAppWrapper {
    static func main() {
        if #available(iOS 14.0, *) {
            LinkShorteningApp.main()
        }
        else {
            UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(AppDelegate.self))
        }
    }
}
