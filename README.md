# TMDb Index

It is an iOS app that allows user to check the upcoming movies from TMDb and see some informations about it.

## Screenshots

Upcoming Movies | Search Upcoming Movies | Movie Detail
----|----|----
![](/screenshots/UpcomingMovies.png) | ![](/screenshots/SearchUpcomingMovies.png) | ![](/screenshots/MovieDetail.png)

## Libraries

### 1. RxSwift

RxSwift is a multiplatform library available for iOS, macOS, tvOS, and watchOS. It brings reactive programming to iOS apps and allows the developers to listen and create signals all over the app, keeping the information on screen and the data in memory always up-to-date.

Used `BehaviorRelay` to store data, `Reactive` to write functions for a specific `ReactiveCompatible` object, and `ObservableType` operators to filter and map the propagated signals.

### 2. Moya

Moya is a multiplatform library available for all Apple devices. It is a capsule over Alamofire that does the network operations when Moya keeps the project divided and organized into reactive requests and endpoint enumerators.

Used `MoyaProvider` to make reactive request with `TargetType` enumerator that returns the endpoint, parameters and headers so Moya can build the request.

### 3. SDWebImage

SDWebImage is a multiplatform library that is written in Objective-C. It allows us to download images over the internet and automatically sets it to the imageView that made the request. Besides, it keeps image cached in memory and at disk over demand.

Used `sd_setImage(with:)` to download the image on a UIImageView object.

## Instructions for compilation

This project use Swift Package Manager that check and updates the dependency automatically. No instructions provided.
