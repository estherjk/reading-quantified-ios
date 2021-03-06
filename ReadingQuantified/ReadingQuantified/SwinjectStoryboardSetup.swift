//
//  SwinjectStoryboardSetup.swift
//  ReadingQuantified
//
//  Created by Esther Jun Kim on 3/31/19.
//  Copyright © 2019 Esther Jun Kim. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    
    @objc class func setup() {
        
        // Disable logging for unregistered view controllers
        // See https://github.com/Swinject/Swinject/issues/213
        Container.loggingFunction = nil
        
        // MARK: - View Controller Injections
        
        defaultContainer.storyboardInitCompleted(BooksViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(BooksViewModel.self)
        }
        
        defaultContainer.storyboardInitCompleted(DashboardViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(DashboardViewModel.self)
        }
        
        defaultContainer.storyboardInitCompleted(LoginViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(LoginViewModel.self)
        }
        
        defaultContainer.storyboardInitCompleted(SortByViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(SortByViewModel.self)
        }
        
        defaultContainer.storyboardInitCompleted(SettingsViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(SettingsViewModel.self)
        }
        
        defaultContainer.storyboardInitCompleted(SplashScreenViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(SplashScreenViewModel.self)
        }
        
        defaultContainer.storyboardInitCompleted(YearSelectionViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(YearSelectionViewModel.self)
        }
        
        // MARK: - View Model Injections
        
        defaultContainer.register(BooksViewModel.self) { resolver in
            BooksViewModel(booksRepositoryManager: resolver.resolve(BooksRepositoryManager.self)!,
                           coordinator: resolver.resolve(SortByCoordinator.self)!)
        }
        
        defaultContainer.register(SortByViewModel.self) { resolver in
            SortByViewModel(coordinator: resolver.resolve(SortByCoordinator.self)!)
        }
        
        defaultContainer.register(DashboardViewModel.self) { resolver in
            DashboardViewModel(booksRepositoryManager: resolver.resolve(BooksRepositoryManager.self)!,
                               dashboardCoordinator: resolver.resolve(DashboardCoordinator.self)!)
        }
        
        defaultContainer.register(YearSelectionViewModel.self) { resolver in
            YearSelectionViewModel(dashboardCoordinator: resolver.resolve(DashboardCoordinator.self)!)
        }
        
        defaultContainer.register(LoginViewModel.self) { resolver in
            LoginViewModel(keychainTokenRepository: resolver.resolve(KeychainTokenRepository.self)!,
                           remoteTokenRepository: resolver.resolve(RemoteTokenRepository.self)!)
        }
        
        defaultContainer.register(SettingsViewModel.self) { resolver in
            SettingsViewModel(keychainTokenRepository: resolver.resolve(KeychainTokenRepository.self)!)
        }
        
        defaultContainer.register(SplashScreenViewModel.self) { resolver in
            SplashScreenViewModel(keychainTokenRepository: resolver.resolve(KeychainTokenRepository.self)!,
                                  remoteTokenRepository: resolver.resolve(RemoteTokenRepository.self)!)
        }
        
        // MARK: - App Component Injections
        
        defaultContainer.register(SortByCoordinator.self) { _ in
            SortByCoordinator()
            }.inObjectScope(.container)
        
        defaultContainer.register(DashboardCoordinator.self) { _ in
            DashboardCoordinator()
        }.inObjectScope(.container)
        
        defaultContainer.register(KeychainTokenRepository.self) { _ in
            KeychainTokenRepository()
        }.inObjectScope(.container)
        
        defaultContainer.register(RemoteTokenRepository.self) { _ in
            RemoteTokenRepository()
            }.inObjectScope(.container)
        
        defaultContainer.register(LocalBooksRepository.self) { _ in
            LocalBooksRepository()
        }.inObjectScope(.container)
        
        defaultContainer.register(RemoteBooksRepository.self) { resolver in
            RemoteBooksRepository(keychainTokenRepository: resolver.resolve(KeychainTokenRepository.self)!)
        }.inObjectScope(.container)
        
        defaultContainer.register(BooksRepositoryManager.self) { resolver in
            BooksRepositoryManager(local: resolver.resolve(LocalBooksRepository.self)!,
                                   remote: resolver.resolve(RemoteBooksRepository.self)!)
        }.inObjectScope(.container)
    }
    
}
