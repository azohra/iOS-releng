//
//  main.swift
//  RedditArticles
//
//  Created by Muddsar Butt on 2018-10-24.
//  Copyright © 2018 Muddsar Butt. All rights reserved.
//

import UIKit

// Refereence
// https://developer.apple.com/swift/blog/?id=7

let appDelegateClass: AnyClass = CommandLine.arguments.contains("IS_TEST_MODE") ? (NSClassFromString("RedditArticlesTests.TestAppDelegate") ?? AppDelegate.self) : AppDelegate.self

let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))
UIApplicationMain(CommandLine.argc, args, nil, NSStringFromClass(appDelegateClass))
