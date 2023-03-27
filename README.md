# GetUpside-Challenge

### Description:

GetUpside-Challenge is a 2-screen POC to explore Clean Architecture + Coordinator, in conjunction with the State Machine and DI Container pattern.

In scope of POC following user story has been implemented:

Implement an iOS application using Swift, which will show nearby food places as pins on the **Google Maps**. List of all found places also should be available for display. Tapping on a map pin or clicking list item should show place details.
 
 Technical requirements:
 - ✔️ You should use [ArcGIS Runtime SDK for iOS]( https://developers.arcgis.com/ios/) as a service that provides places;
 - ✔️ Limit a number of places fetched to 20. You should store them (last 20 fetched places) locally using **Realm**;
 - ✔️ on app start, initial map camera position has to be centered to device location with zoom level 14.
 - ✔️ If there are stored places on app start, that are visible on initial screen, show them and don't make a service fetch call;
 - ✔️ fetching places should happen only when all map interactions stopped (zoom, pan or camera movement). All fetched places have to be visible on map after search;
 - ✔️ completed test assignment should be uploaded to GitHub and only link to it provided as a final solution. Project needs to have instructions for launching the app in Xcode;

In additional:
- ✔️ Splash screen;
- ✔️ Clustering;
- ✔️ Filtering by category and by near user location (20 km);

### How to compile and run project:

- Since app used 3rd part framework, distributed cocoapods. Install cocoapods in regular way:
    - Change the working directory (currently **GetUpside-Challenge**);
    - Then, run the following command:
        ```
        $ pod install
        ``` 
- Open GetUpside-Challenge.workspace;
- Build and run the app;

### Structure of project:

The project contains separated modules/frameworks + application (listed below):

- [x] **GetUpside-Challenge** - iOS target which aggregates all frameworks listed below.
- [x] **FutureKit** - framework which provides an API for performing nonblocking asynchronous requests and combinator interfaces for serializing the processing of requests, error recovery and filtering. In most iOS libraries asynchronous interfaces are supported through either delegate-protocol pattern or with a callback. Even simple implementations of these interfaces can lead to business logic distributed over many files or deeply nested callbacks that can be hard to follow. **FutureKit** provides a very simple API to get rid of callback hell (inspired by [www.swiftbysundell.com](https://www.swiftbysundell.com/articles/under-the-hood-of-futures-and-promises-in-swift/)).

**FutureKit** is analog Future/Promise, provided by combine with advantage that the framework is available in iOS 10+, whereas Future/Promises available starting with iOS 13.

- [x] **ReusableKit** - framework which contains generic routines to reuse UIKit/Cocoa elements. Currently supports `UITableView` and `UICollectionView`.
- [x] **UI** - framework which provided some featured UI elements.
- [x] **FilterKit** - framework contains unified routines for filtering elements.

The frameworks have been put into a separates modules so that they can be reused in other projects (if necessary, they are assembled into a static/dynamic frameworks).

Also **GetUpside-Challenge** is using 3rd party frameworks including [ArcGIS Runtime SDK for iOS](https://developers.arcgis.com/ios/), and [GoogleMaps](https://developers.google.com/maps/documentation/ios-sdk/overview).

### Architectural approach:

As it's been mentioned **GetUpside-Challenge** is following [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) pattern (VIP) (*by Robert C. Martin (Uncle Bob)*).

Entire project classes might be devided into 3 layers: **Data**, **Domain**, and **Presentation** layers.
**Data** layer components:

- Data Entities (e.x.: *RealmEetery*, *AGSGeocodeResult*);
- Data Services (e.x.: *Realm.Manager*); 

**Domain** layer components:

- Domain Entities (e.x.: *Eatery*);
- Wrokers (e.x.: *ArcGisWorker*, *DBWorker* (worker which dealing with Realm DB), *LocationWorker*));
- Interactors (e.x.: *Splash.InteractorImpl*, *Main.InteractorImpl*);

**Presenation** layer components:
- Presenters (e.x.: )
- View Models (e.x.: *Main.ViewModel*, *Splash.ViewModel*);

From the bottom direction:

Every service operates its own data entity.
The worker keeps the reference to service instance and handles all the API requests and responses to this data service. It implements its own specific "use case" (e.x.:. *GetEateryUseCase*) e.g. specific business scenarios. Also it might convert data from data entities to domain entities.
Interactor observes callbacks from workers, and depends on the received data changes states in State Machine accordantly (used to handle difficult scenarios). Presenter subscribe to states change and, prepares data to display, packing it into ViewModel instances and notify views (Screens) accordantly. Every screen "knows" how to display its specific ViewModel.

From the opposite direction:
The screens call the interactor, forming a request, and the interactor runs the specific scenario described.

### Supporting platforms:

- iOS 12.0+;
