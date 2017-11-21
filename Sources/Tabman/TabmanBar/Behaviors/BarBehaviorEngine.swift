//
//  BarBehaviorEngine.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import Foundation

internal class BarBehaviorEngine {
    
    // MARK: Properties
    
    private weak var bar: TabmanBar?
    
    var activeBehaviors: [TabmanBar.Behavior]? {
        didSet {
            updateActiveBehaviors(to: activeBehaviors ?? [])
        }
    }
    private var activists = [BarBehaviorActivist]()
    
    // MARK: Init
    
    init(for bar: TabmanBar) {
        self.bar = bar
    }
    
    // MARK: Behaviors
    
    private func updateActiveBehaviors(to behaviors: [TabmanBar.Behavior]) {
        activists.removeAll()
        
        behaviors.forEach { (behavior) in
            guard let activist = behavior.activistType?.init(for: behavior, bar: self.bar) else {
                return
            }
            self.activists.append(activist)
            activist.update()
        }
    }
    
    func update() {
        activists.forEach { (activist) in
            activist.update()
        }
    }
}
