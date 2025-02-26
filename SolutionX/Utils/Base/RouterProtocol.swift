//
//  RouterProtocol.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 26/02/2025.
//


import UIKit

public protocol RouterProtocol: AnyObject {
    
    var presentedView: UIViewController? { get }
    var navigationController : UINavigationController? { get set }
    
    func push(_ view: UIViewController)
}

public extension RouterProtocol {
    func push(_ view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
    
    func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
}

public extension RouterProtocol {
    unowned var presentedView: UIViewController? {
        return navigationController?.topViewController
    }
    
    unowned var presentedSheet: UIViewController? {
        return navigationController?.presentedViewController
    }
}
