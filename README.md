# UIKit-In-SwiftUI
Showing a map view in SwiftUI and also an overlay technique for a text label.

### Update
I pruned a lot of old code that wasn't working properly and tried another approach. Calling into a UIViewRepresentable which then calls a function into the subclassed MKMapView. The approach works - but it feels brittle to me. I am sure it's not the corrext approach, but it does indeed work for the time being.

![Screenshot](./london.png)
