//
//  ContentView.swift
//  UIKit In SwiftUI
//
//  Created by Eric Dolecki on 2/26/20.
//  Copyright © 2020 Eric Dolecki. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable
{
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 51.5074, longitude: -0.127758)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        view.showsBuildings = true
        view.showsScale = true
        view.mapType = .hybridFlyover
        
        let mapCamera = MKMapCamera()
        mapCamera.centerCoordinate = coordinate
        mapCamera.pitch = 45
        mapCamera.altitude = 500 // example altitude
        mapCamera.heading = 45
        
        view.setRegion(region, animated: true)
        view.camera = mapCamera
    }
}

struct Panel: View {
    var body: some View {
        VStack {
            Spacer()
            Text("")
                .frame(width:200, height:50)
                .background(Color(.black))
                .opacity(0.5)
                .cornerRadius(15.0)
                    .overlay (
                        Text("London, England")
                        .foregroundColor(.white)
                        .background(Color(.clear))
                        .frame(width:200, height: 40)
                        .font(.headline)
                    )
                   }.padding(.bottom, 70)
        }
}

struct ContentView: View {
    
    var body: some View {
        ZStack {
            VStack {
                MapView()
            }
            ZStack {
                VStack {
                    Panel()
                        .background(Color(.clear))
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}