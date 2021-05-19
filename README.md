# flutter_shutterstock_infinite_list

An infinite picture list Flutter application using shutterstock api .

## Target

This project is an implementation for an app that fetches pictures from the Shutterstock API (http://api.shutterstock.com/) and displays them in an infinite scrollable view.
- New pictures will be fetched and shown when the user scrolls to the end of the list.
- This is a client side solution: mobile, windows and web.
- Scoping the implementation in order to finish this example in less than two working days.

## Focus

The focus in this app is highly performant (smooth scrolling & lag-free UI) and on testing (unit/UI) feasible parts.
- I used ListView.builder that is responsible for constructing only a specific number of list items and when a user scrolls ahead, the earlier ones are destroyed.
- I used CachedNetworkImage in order to save mobile data usage and load the images faster after the first time.
- architecture:
-- I used flutter_bloc in order to manage the state of the app and separated UI layer from our business logic layer (Domain Layer and Data), make the code fast, easy to test, and reusable.
-- UI Layer/Domain Layer/Data Layer: Inspired from android-clean-architecture, I separated UI Domain And Data (usecase,repository,data_source and provider) in order to have many developers seamlessly working within a
 single code base following the same patterns and conventions and being able to test separately each part.


## Trade-offs

Tha app is an example for production ready architecture but ignoring some points (need to implement before push to production)
- Security vulnerability, Hardcoded params, the API authentication process and the passwords are hardcoded.
- There is no implementation of the LocalDataSource, the use of this DataSource is ready and tested already.
-- todo here, after implement LocalDataSource, I need to limit the list in ImageState and make sure I don't exceed memory limit.
- Navigation, Since the app is just one page there is no Navigation and routing.
- Dependency injection should be implemented in order to make the classes cleaner, and not create dependencies in their constructors. For example ImagesBloc shouldn't know the DataSource.