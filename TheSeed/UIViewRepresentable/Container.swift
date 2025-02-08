//
//  Container.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 09/12/2022.
//

import SwiftUI

struct Container: UIViewControllerRepresentable {
    let imageNames: [String]
    
    func makeUIViewController(context: Context) -> UIViewController {
        //let vc = UIHostingController(rootView: Text("First View Controller"))
        //vc.view.backgroundColor = .none
        //return vc
        
        let pvc = CustomPageViewController(imageNames: imageNames)
        return pvc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
    
    
}


class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
       
        guard let index = allControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        if index == 0 { return nil }
        return allControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = allControllers.firstIndex(of: viewController) else { return nil }
        
        if index == allControllers.count - 1 {
            return nil
        }
        return allControllers[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return allControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
    
    
    /*let firstVC = UIHostingController(rootView: Text("First View Controller"))
    
    let secondVC = UIHostingController(rootView: Text("Second View Controller"))
    
    let thirdVC = UIHostingController(rootView: Text("Third View Controller"))
    
    lazy var allControllers: [UIViewController] = [firstVC, secondVC, thirdVC]
    */
    
    lazy var allControllers: [UIViewController] = []
    
    
    init(imageNames: [String]) {
        
        //show the current indicator color
        UIPageControl.appearance().pageIndicatorTintColor =
            UIColor.systemGray5
        
        UIPageControl.appearance().currentPageIndicatorTintColor
        = .red
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        
        allControllers = imageNames.map({ imageName in
            let hostingController =
            UIHostingController(rootView: Image(imageName)
                        .resizable()
                        .scaledToFill()
                        
            
            )
            
            hostingController.view.clipsToBounds = true
            return hostingController
        })
        
        //view.backgroundColor = .red
        guard let firstPageItem = allControllers.first else { return }
        setViewControllers([firstPageItem], direction: .forward, animated: true, completion: nil)
        
        //define the datasource and delegate
        self.dataSource = self
        self.delegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct Container_Previews: PreviewProvider {
    static var previews: some View {
        Container(imageNames:  ["creation", "just", "letting", "prayer"])
    }
}
