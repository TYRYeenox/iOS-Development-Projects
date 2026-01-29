//  Scope Lab #1: Scope Demo
//
//  # Instructions:
//  - With a partner, throughly annotate this file to describe
//    the scope of each and every variable and constant,
//    including those declared as part of function parameters.
//  - Add comments at the end of each line with a new variable
//    to annotate their scope.
//  - We will do the first few together.


import Foundation

let appName: String = "Scope Explorer" //Global
var globalUserCount: Int = 0 //Global

@MainActor // Ignore this
class ScopeDemoViewModel {

    static let maxCachedItems: Int = 100 //Global since static.
    static var sharedInstanceCount: Int = 0 //Global since static.

    let id: UUID //Local. Is a let defined within.
    var title: String //Local
    private var isDirty: Bool = false //Local
    fileprivate var lastSyncDate: Date //Global inside of this file
    private var retryCount: Int = 0 //Local, only inside class
    public var isEnabled: Bool = true //Global marked as public

    var isSynced: Bool { //Local inside the scope
        return !isDirty
    }

    private var shouldRetry: Bool { //Local, only inside class
        return retryCount < 3 && !isSynced
    }

    static var descriptionText: String { //Global since static.
        return "This type demonstrates many different scopes."
    }

    struct SyncSettings { //GLobal
        let maxAttempts: Int //Local wthin this struct in SyncSettings
        var delayBetweenAttempts: TimeInterval //Local still within the struct
        private(set) var lastUsedVersion: String //Local still within the struct

        mutating func markUsed(version: String) { //Local still within the struct
            lastUsedVersion = version
        }
    }

    var syncSettings: SyncSettings //Local within scop demo view model

    init(title: String) { //Local still within the scopeDemoView Model
        self.id = UUID() //local within init
        self.title = title //local within init
        self.syncSettings = SyncSettings( //local within init
            maxAttempts: 3, //Local
            delayBetweenAttempts: 2.0, //Local
            lastUsedVersion: "1.0" //Local
        )
        self.lastSyncDate = Date() //local within init

        let initialStatusMessage = "Created view model with  title: \(title)" //local within init
        print(initialStatusMessage)

        ScopeDemoViewModel.sharedInstanceCount += 1 //local within init
    }

    convenience init() { //Local within class
        self.init(title: "Untitled") //local within init
    }

    func performSync() { //Local within scopedemo
        let startTime = Date() //Local within function
        var attempts = 0 //Local within this func

        let retryCount = 0 //Local within this func
        print("Local retryCount (shadowing property): \(retryCount)") //Local within this func

        func attemptSyncOnce() -> Bool { //Local within this performCync
            attempts += 1 //Local within this func
            globalUserCount += 1 //Local within this func

            let syncId = UUID() //Local within this func
            print("Attempt \(attempts) with id \(syncId)")
            return Bool.random() //Local within this func
        }

        while attempts < syncSettings.maxAttempts { //Local within performSync
            let success = attemptSyncOnce() //Local within this loop attempts
            if success { //Local within loop attempts
                lastSyncDate = Date() //Local within if statement
                isDirty = false //Local within if statement
                break //Local within if statement
            }
        }

        let elapsed = Date().timeIntervalSince(startTime)
        print("Sync finished in \(elapsed) seconds") //Local within func performSync
    }

    private func logStatusChange(from old: String, to new: String) { //Local within scopeDemoViewModel
        let logMessage = "Status changed from \(old) to \(new)"
        print(logMessage) //Local within private func logStatusChange
    }

    func updateTitle(to newTitle: String, animated: Bool) { //Local within scopeDemoViewModel
        let oldTitle = title //Local within func updateTital
        title = newTitle //Local within func updateTital
        isDirty = true //Local within func updateTital

        if animated { //Local within func updateTital
            animateTitleChange(from: oldTitle, to: newTitle) //Local within if stament animated
        }
    }

    private func animateTitleChange(from old: String, to new: String) { //Local within scopeDemoViewModel
        let animationDuration: TimeInterval = 0.25 //Local within private func animateTitleChange

        let animations = { //Local within private func animateTitleChange
            let transitionText = "\(old) → \(new)"
            print("Animating title change: \(transitionText)")//Local within private func animateTitleChange
        }

        performAnimation(duration: animationDuration, animations: animations) //Local within private func animateTitleChange
    }

    private func performAnimation(duration: TimeInterval, animations: () -> Void) { //Local within scope demo view model
        print("Starting animation for \(duration) seconds")
        animations() //Local within private func performAnimation
        print("Animation complete") //Local within private func performAnimation
    }

    static func resetSharedInstanceCount() { //Global outside class
        sharedInstanceCount = 0 //Local to static func
    }

    static func makeSampleViewModels() -> [ScopeDemoViewModel] { //Global scopeDemo
        let titles = ["Home", "Profile", "Settings", "About"] //Local within static func
        var result: [ScopeDemoViewModel] = [] //Local within static func

        for name in titles { //Local within static func
            let model = ScopeDemoViewModel(title: name) //Local Within loop
            result.append(model)
        }

        return result //Local within static func
    }
    
    fileprivate func markAsDirtyForTesting() { //Local within file
        isDirty = true //Local within this func fileprivate
    }
}

fileprivate extension ScopeDemoViewModel { //Only inside of file
    func debugPrintState() { //Local within fileprivate extension
        print("Debug id: \(id)") //Local within this fun debigPrintState
        print("Debug lastSyncDate: \(String(describing: lastSyncDate))") //Local within this fun debigPrintState
    }
}

@MainActor // Ignore this
func runScopeDemo() { //Global outside of class
    let models = ScopeDemoViewModel.makeSampleViewModels() //Local within func runScopeDemo
    print("Created \(models.count) models in \(appName)") //Local within func runScopeDemo
    print("Global user count: \(globalUserCount)") //Local within func runScopeDemo

    if let first = models.first { //Local within func runScopeDemo
        first.performSync() //Local within if let
    }
}
