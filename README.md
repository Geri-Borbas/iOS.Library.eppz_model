## **eppz!model**

**A model layer for the everydays.** Extreme simplicity (while fully customizable).

```Objective-C

// Just add `<EPPZModel>` to your existing model(s)
@interface ComplexStuff <EPPZModel>
// Various properties, containing references to / collections of other models
@end

// On monday.
NSDictionary *representation = [complexStuff dictionaryRepresentation];

// Two days later.
ComplexStuff *complexStuff = [ComplexStuff instanceWithDictionary:representation];

```

Basically eppz!model is designed for **network usage**, to represent complex entities / object graphs
(probably in an `NSDictionary` / `JSON` output), and also reconstruct runtime objects from a network
responses (probably `JSON`). Later on I'll open the source that works with `CoreData`, and sync (based
on last modification date) stuff as well.

Though, it can be use as **object formatter** for example, supposing you're designed an [MVVM](https://en.wikipedia.org/wiki/Model_View_ViewModel)
architecture, it can be a flexible formatting layer in your view model conversions. Value / field
mappers can be plugged in at runtime to fit every need.

> #### Basic usage
> Represent an object.
> #### Custom field mapping
> Map runtime property names to custom field names in representation.
> #### Custom value mapping
> Customize value representing / reconstruction in different fields.
> #### Represent foreign classes
> Represent / reconstruct a `UIView`.
> #### Save representations
> Save to `plist`, archive (automatic `<NSCoding>`) and more.
> #### Represent cross-references
> See cross-references being represented / reconstructed.
> #### Goodies
> Property inspection, collection tools, handy macros.
> #### Examples (test suites)
> See every feature in action in test suites.


## Basic usage

If you just need a dictionary representation of an objecy, or object graph, you can simply mark the model as an `<EPPZModel>`, and done.

```Objective-C
// Model.
// Dictionary.
// Result.
```

The basic value mapper beside basic Foundation classes can represent `NSData` (as Base64 string), `NSDate` (using a default formatter, or your own), `CGPoint`, `CGSize`, `CGRect`, `CGAffineTransform`.


### Custom field mapping

+ Field is a property, value is a value
+ Convert
+ Mask


### Custom value mapping

+ Per field
+ Different color representations


### Represent foreign classes

+ Represent `UIView`


### Save representations

+ `JSON`
+ `plist`
+ `NSUserDefaults`
+ `<NSCoding>` (automatic)


### Represent cross-references

+ Player / GameProgress / Achivement example


### Goodies (property inspection, collection tools, handy macros)

+ Property inspection
+ Collection operators
+ Handy macros (`FORMAT`, `WEAK_SELF`)


### Configure unknown objects

+ SpriteKit `SKSpriteNode` configuration example


### Examples (test suites)

Browsing test cases can tell you the most about every aspect of the library, it is actually almost 100% covered.


### License

+ MIT


