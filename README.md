# GetUpside-Challenge

### Description:

GetUpside-Challenge is a 2-screen POC to explore Clean Architecture + Coordinator, in conjunction with the State Machine pattern.

In scope of POC following user story has been implemented:

Implement an iOS application using Swift, which will show nearby food places as pins on the **Google Maps**. List of all found places also should be available for display. Tapping on a map pin or clicking list item should show place details.
 
 Technical requirements:
 - ✔️ You should use [ArcGIS Runtime SDK for iOS]( https://developers.arcgis.com/ios/) as a service that provides places;
 - ✔️ Limit a number of places fetched to 20. You should store them (last 20 fetched places) locally using **Realm**;
 - ✔️ on app start, initial map camera position has to be centered to device location with zoom level 14.
 - ✔️ If there are stored places on app start, that are visible on initial screen, show them and don't make a service fetch call;
 - ✔️ fetching places should happen only when all map interactions stopped (zoom, pan or camera movement). All fetched places have to be visible on map after search;
 - ✔️ completed test assignment should be uploaded to GitHub and only link to it provided as a final solution. Project needs to have instructions for launching the app in Xcode;

Bonus:
- ✔️ Splash screen has been implemented;

### How to compile and run project:

- Since app used 3rd part framework, distributed cocoapods. Install cocoapods in regular way:
    - Change the working directory (currently **GetUpsideChallenge**);
    - Then, run the following command:
        ```
        $ pod install
        ``` 
- Open GetUpsideChallenge.workspace;
- Build and run the app;

### Structure of project:

The project contains separated modules/frameworks + application (descriptions of each of them are listed below):

- [x] **GetUpside-Challenge** - iOS target which aggregates all frameworks listed below.
- [x] **FutureKit** - framework which provides an API for performing nonblocking asynchronous requests and combinator interfaces for serializing the processing of requests, error recovery and filtering. In most iOS libraries asynchronous interfaces are supported through either delegate-protocol pattern or with a callback. Even simple implementations of these interfaces can lead to business logic distributed over many files or deeply nested callbacks that can be hard to follow. **FutureKit** provides a very simple API to get rid of callback hell (inspired by [www.swiftbysundell.com](https://www.swiftbysundell.com/articles/under-the-hood-of-futures-and-promises-in-swift/)).

**FutureKit** is analog Future/Promises, provided by combine with advantage that the framework is available in iOS 10+, whereas Future/Promises available starting with iOS 13.

- [x] **ReusableKit** - framework which contains generic routines to reuse UIKit/Cocoa elements. Currently supports `UITableView` and `UICollectionView`.
- [x] **UI** - framework which provided some featured UI elements.
- [x] **FilterKit** - framework provided unified routines for filtering elements.

Also **GetUpside-Challenge** is using 3rd party frameworks including [ArcGIS Runtime SDK for iOS](https://developers.arcgis.com/ios/), and [GoogleMaps](https://developers.google.com/maps/documentation/ios-sdk/overview).

### Architectural approach:

Project is following MVVM+C pattern:
- *ViewController*/*UIView* is responsible for rendering, and passes user actions to *ViewModel* (knows about *ViewModel*);
- *ViewModel* knows about all services/providers and implement interactions with them (in the current case, this is fetching data) + *viewModel* is mapping fetched items into presentation Nodes.
- *Presentation node* is a wrapper around *Model* (Entity), it's implementing logic related to specific UI components populating, depends on data.
- *Model* = Entity;
- *Coordinator* is responsible for navigation in the scope of specific flow (one or several controllers)(might implement transition animation logic between specific screens);

### Supporting platforms:

- iOS 12.0+;

### TODO:

- Investigate how to set *searchArea* in **AGSGeocodeParameters**;
