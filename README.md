![Swift Version][swift-image]
![Platform][ios-image]
![License][license-image]
![Xcode][xcode-image]

# GetUpside-Challenge

### Description:

GetUpside-Challenge is a 2-screen POC to explore Clean Swift Architecture + Coordinator, in conjunction with the State Machine and DI Container pattern.

In scope of POC following user story has been implemented:

Implement an iOS application using Swift, which will show nearby food places as pins on the **Google Maps**. List of all found places also should be available for display.
 
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

- Since app used 3rd part frameworks, distributed via cocoapods. Install cocoapods in regular way:
    - Change the working directory (currently **GetUpside-Challenge**);
    - Then, run the following command:
        ```
        $ pod install
        ``` 
- Open GetUpside-Challenge.workspace;
- Build and run the app;

### Structure of project:

The project contains separated modules/frameworks + application (listed below):

- [x] **GetUpside-Challenge** - iOS target which implements technical requirements together with additional featues provided (architectual approch described bellow).
- [x] **FutureKit** - framework which provides an API for performing non-blocking asynchronous requests and combinator interfaces for serializing the processing of requests, error recovery and filtering. In most iOS libraries asynchronous interfaces are supported through either delegate-protocol pattern or with a callback. Even simple implementations of these interfaces can lead to business logic distributed over many files or deeply nested callbacks that can be hard to follow. **FutureKit** provides a very simple API to get rid of callback hell (inspired by [www.swiftbysundell.com](https://www.swiftbysundell.com/articles/under-the-hood-of-futures-and-promises-in-swift/)).

FutureKit is analog Future/Promise, provided by [Combine](https://developer.apple.com/documentation/combine) with advantage that the framework is available in iOS 10+, whereas Future/Promises available starting with iOS 13.

- [x] **ReusableKit** - framework which contains generic routines to reuse UIKit/Cocoa elements. Currently supports `UITableView` and `UICollectionView`.
- [x] **UI** - framework which provided some featured UI elements (<sub><sup>Probably, some components are going to be taken out into separated distributed pakage to reuse in other project experiences</sup></sub>).
- [x] **FilterKit** - framework contains unified routines for filtering elements.

<sub><sup>The frameworks have been put into a separates modules so that they can be reused in other projects (if necessary, they are assembled into a static/dynamic frameworks).</sup></sub>

Also **GetUpside-Challenge** is using 3rd party frameworks including [ArcGIS Runtime SDK for iOS](https://developers.arcgis.com/ios/), and [GoogleMaps](https://developers.google.com/maps/documentation/ios-sdk/overview).

### Architectural approach:

As it's been mentioned **GetUpside-Challenge** is following [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) pattern (VIP) (*by Robert C. Martin (Uncle Bob)*).

Entire project classes might be devided into 3 layers: **Data**, **Domain**, and **Presentation** layers.
**Data** layer components:

- Data Entities (e.x.: [RealmEetery](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Data/Workers/DB/Realm/RealmEatery.swift), [AGSGeocodeResult](https://developers.arcgis.com/ios/api-reference/interface_a_g_s_geocode_result.html));
- Data Services (e.x.: [Realm.Manager](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Data/Workers/DB/Realm/Realm.swift)); 

**Domain** layer components:

- Domain Entities (e.x.: [Eatery](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Domain/Entities/Eatery.swift));
- Wrokers (e.x.: [ArcGisWorker](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Data/Workers/ArcGIS/ArcGisWorker.swift), [DBWorker](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Data/Workers/DB/DBWorker.swift) (worker which dealing with Realm DB), [LocationWorker](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Data/Workers/Location/LocationWorker.swift)));
- Interactors (e.x.: [Splash.InteractorImpl](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Domain/Interactors/SplashInteractorImpl/SplashInteractorImpl.swift), [Main.InteractorImpl](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Domain/Interactors/MainInteractorImpl/MainInteractorImpl.swift));

**Presenation** layer components:
- Presenters (e.x.: [Splash.Presenter](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Presentation/Flows/Splash/SplashPresenter.swift), [Main.Presenter](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Presentation/Flows/Main/MainPresenter/MainPresenter.swift))
- View Models (e.x.: [Main.ViewModel](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Presentation/Flows/Main/MainViewModel.swift), [Splash.ViewModel](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Presentation/Flows/Splash/SplashViewModel.swift));
- Scenes (e.x.: [Splash.Scene](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Presentation/UI/ViewControllers/Screens%26Components/Scenes/SplashScene.swift), [Main.Scene](https://github.com/vovkroman/GetUpside-Challenge/blob/master/GetUpside-Challenge-App/GetUpside-Challenge-App/Presentation/UI/ViewControllers/Screens%26Components/Scenes/MainScene.swift))

From the bottom direction:

Each service works with its own data entity.
The worker stores a reference to a service instance and handles all requests and API responses to that data service. It implements its own specific "use case", such as specific business scenarios. It also converts data from data entities to domain entities using converters/translators (another "pros" of this approach, the data entity can only be used in the thread/sequence where it was created, as it does in Realm, and by converting to a domain-layer entity, the user removes the restriction on use in a particular thread).
Interactor observes callbacks from workers and, depending on the data received, changes states in the State Machine accordingly (used to handle complex scenarios). Presenter subscribes to state changes and prepares data for display by packaging it into ViewModel instances and notifying the view (scene) coherently. Each screen "knows" how to display its particular ViewModel.
Within a single scene, there is one interactor - the presenter. The Interceptor-Presenter-View relationship is referred to in various sources as the VIP cycle.

From the opposite direction:
The screens call the interactor, forming a request, and the interactor runs the specific scenario described.

Described above might be vizualzied with following graph.
<p align="center">
    <img src="Demo/Clean_Architecture.gif">
</p>

In addition, the application uses a coordinator pattern. It is used to handle various navigation streams. The interactor keeps the coordinator as a delegate and notifies it via events.
[Coordinator](https://medium.com/@mahmoudbasuni90/coordinator-pattern-in-swift-c38b40e73ea8) contains a reference to [Dependency Injection](http://fabien.potencier.org/do-you-need-a-dependency-injection-container.html) container (DI Container). Essetioally, it keeps references to global application services (such as URLSession, LocationManager, etc), and also DI "knows" rules instantiate scenes. These "rules" also instantiate interactors and pass them to initialzer of the scene (Dependancy injection). Thus, every instance might be mocked or stubbed during unit testing.  


### Supporting platforms:

- iOS 12.0+;
