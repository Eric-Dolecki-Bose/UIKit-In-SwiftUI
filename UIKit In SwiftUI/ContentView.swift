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
    @Binding var centerCoordinate: CLLocationCoordinate2D {
        didSet {
            //print("didSet Center Coordinate.")
        }
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        
        print(#function)

        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        
        view.showsBuildings = true
        view.showsScale = true
        view.mapType = .hybridFlyover
        
        let mapCamera = MKMapCamera()
        mapCamera.centerCoordinate = centerCoordinate
        mapCamera.pitch = 70
        mapCamera.altitude = 500
        mapCamera.heading = 260
        
        view.setRegion(region, animated: true)
        view.setCenter(centerCoordinate, animated: true)
        view.camera = mapCamera
    }
}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
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
    
    @State var myCurrentPage: Int = 0
    @State var myCenter = CLLocationCoordinate2D(latitude: 51.5003646652, longitude: -0.1214328476)
    
    var body: some View {
        ZStack {
            VStack {
                MapView(centerCoordinate: .constant(myCenter))
                    
            }
            ZStack {
                VStack {
                    
                    Button(action: {
                        self.recenterMap()
                    }) {
                        Panel()
                            .background(Color(.clear))
                            .padding(.bottom, -50)
                    }
                    
                    
                    // The ActivityIndicatorView can be tapped to adjust PageControl.
                    Button(action: {
                        self.increasePage()
                    }) {
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                        .colorScheme(.dark)
                        .padding(.bottom, 60)
                    }
                }
            }
            ZStack {
                VStack {
                    Spacer()
                    PageControl(numberOfPages: 5, currentPage: .constant(myCurrentPage))
                }.padding(.bottom, 20)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
    }
    
    func increasePage() {
        myCurrentPage = myCurrentPage + 1
        if myCurrentPage > 4 {
            myCurrentPage = 0
        }
    }
    
    func recenterMap() {
        print("TODO: re-center the map.")
        let thisCenter = CLLocationCoordinate2D(latitude: 51.5003646652, longitude: -0.1214328476)
        MapView(centerCoordinate: .constant(thisCenter))
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
