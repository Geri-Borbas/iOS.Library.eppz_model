## Versions


0.4.4
    
    + Default mapper extensions
        + `NSDate` (`dateFormatter`, `timeZone` property at mapper level)
        + `NSData` (base64 encoded string)
    + `Achivement` objects don't get represented!

* 0.4.0

    + Reconstruction just works fine
    
* 0.3.5

    + Representing references
    + Tests adjusted
    + Comparison categories for test models
    + Ready to implement reconstruction

* 0.3.0

    + Aliases in value mappers
    + Resolving type names trough with getter methods (to comply with `UIKit` members)
    + Representing model attributes (modelId, className)
    + Mapper holds model attribute fields

* 0.2.4

    + Value mapping
        + Now accepts fields
    + Fields
        + Accepts both `NSArray` and `NSDictionary`
    + Collection processors
        + Representing now creeps trough collections

* 0.2.2

    + Value mappings
        + Created format
        + Hooked into representation
        + Class aliases
        + Hooked in `typeName` prefixes

* 0.2.0

    + Mappings (extracted to a composable object)
        + Field mappings
        + Value mappings (have not implemented yet)

* 0.0.16

    + Property name list added

* 0.0.15

    + Parse struct names if any 

* 0.0.1

    + Property type inspections
        + With tests