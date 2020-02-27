//
//  ContentView.swift
//  UIKit In SwiftUI
//
//  Created by Eric Dolecki on 2/26/20.
//  Copyright © 2020 Eric Dolecki. All rights reserved.
//

import SwiftUI
import MapKit

// Trying another approach.

class SomeView: MKMapView {
    
    func foo() {
        print("Foo was called.")
        let centerCoordinate = CLLocationCoordinate2D(latitude: 51.5003646652, longitude: -0.1214328476)
        self.setCenter(centerCoordinate, animated: true)
    }
    
    func setUp() {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        self.showsBuildings = true
        self.showsScale = true
        self.mapType = .hybridFlyover
        let mapCamera = MKMapCamera()
        mapCamera.centerCoordinate = centerCoordinate
        mapCamera.pitch = 70
        mapCamera.altitude = 500
        mapCamera.heading = 260
        self.setRegion(region, animated: true)
        self.setCenter(centerCoordinate, animated: true)
        self.camera = mapCamera
    }
}

struct SomeViewRepresentable: UIViewRepresentable {

    let someView = SomeView()
    
    func makeUIView(context: Context) -> SomeView {
        someView.backgroundColor = UIColor.red
        return someView
    }
    
    func updateUIView(_ uiView: SomeView, context: Context) {
        //
    }
    
    func callFoo() {
        someView.foo()
    }
    
    func callSetup() {
        someView.setUp()
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
        VStack
        {
            Spacer()
            Text("")
                .frame(width:250, height:50)
                .background(Color(.black))
                .opacity(0.5)
                .cornerRadius(15.0)
                    .overlay (
                        Text("London, England (re-center)")
                            .foregroundColor(.white)
                            .background(Color(.clear))
                            .frame(width:200, height: 40)
                            .font(.headline)
                    )
                   }.padding(.bottom, 70)
        }
}

struct ContentView: View {
    
    let someView = SomeViewRepresentable()
    @State var myCurrentPage: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                someView
                    .onAppear {
                        self.someView.callSetup()
                        self.someView.callFoo()
                    }
            }
            ZStack {
                VStack {
                    
                    Button(action: {
                        self.someView.callFoo()
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
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
