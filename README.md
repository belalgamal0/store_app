# Store App
The app is based on clean architecture based on the book and blog by Uncle Bob. It is a combination of concepts taken from Onion Architecture and other architectures. The main focus of the architecture is the separation of concerns and scalability. It consists of 3 main modules: App, Domain, Data

Source code dependencies only point inwards. This means inward modules are neither aware of nor dependent on external modules. However, external modules are both aware of and dependent on inner modules. Outer modules represent the mechanisms by which the business rules and policies (inner modules) operate. The more you move inward, the more abstraction is present. The outer you move the more concrete implementations are present. Inner modules are not aware of any classes, functions, names, libraries, etc.. present in the outer modules. They simply represent rules and are completely independent of the implementations.
![0_zUtZYiJ1bDTugOYY](https://user-images.githubusercontent.com/32741765/193946500-5f998419-d653-4b58-af0a-91fc3c4e0e7c.png)

Every "feature" of the app, like getting products, will be divided into 3 layers - presentation, domain, and data.
<img width="260" alt="Screen Shot 2022-10-05 at 1 08 05 AM" src="https://user-images.githubusercontent.com/32741765/193946865-95c67341-a0e2-4bc2-83a5-6aa1e024a741.png">

Presentation<br /> 
This layer contains widgets to display UI on the screen. These widgets then dispatch events to the Bloc and listen for states, and in this app, there is only a single bloc "ProductsBloc".

Domain<br />
is the inner layer. It will contain only the core business logic (use cases) and business objects (entities). It's independent of every other layer.
Use Cases are classes that encapsulate all the business logic of a particular use case of the app (GetProducts).
And the way that the domain gets data from a Repository, which is from the data layer is accomplished with dependency inversion.

Data<br />
the data layer consists of a Repository implementation (the contract comes from the domain layer) and data sources - one is for getting remote (API) data and the other for caching that data, unlike domain the data layer works with Models, not Entities
Therefore, there is a  Model class that extends Entity and adds some specific functionality (toJson, fromJson) or additional fields.
The RemoteDataSource will perform HTTP GET requests on the Products API. LocalDataSource will cache data using the Hive package.
These two data sources will be "combined" in ProductsRepository.
The caching policy is simple. If there is a network connection, always get data from the API and cache it. Then, if there's no network, return the latest cached data.

And to ensure that the app continues to work as more features are added or change existing functionality. units testing is applied, as sometimes, unit tests might depend on classes that fetch data from live web services or databases. rather than relying on a live web service or database, "Mockito" is used mock these dependencies as mocking allows emulating a live web service or database and returning specific results depending on the situation.
Unit testing is written based on a specific sequence, for example, to check internet connection these steps are taken in sequence:<br />
1- Add the package dependencies.<br />
2- Create a function to test.<br />
3- Create a test file with a mock internet connection checker.<br />
4- Write a test case.<br />
5- Run the tests.<br />

<img width="637" alt="Screen Shot 2022-10-05 at 1 33 35 AM" src="https://user-images.githubusercontent.com/32741765/193949413-e3c3b137-8621-49d8-98e9-68d8c686f7ca.png">



