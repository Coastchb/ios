//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by 操海兵 on 2019/6/25.
//  Copyright © 2019 Coast. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view")
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
    }
}
