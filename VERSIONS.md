## Versions

* [feature/refactor-interfaces] 0.0.0

    + Split interfaces
        + Public / Internal headers
        + Categories along features


* 0.4.6

    + Bump version number after merge [feature/reference-reconstructing]


* [feature/reference-reconstructing] 0.0.3

    + Seems override `modelId` with the represented `modelId` resolved the issue
    + Now try to solve the problem sole with this
    + Tests are passing!


* [feature/reference-reconstructing] 0.0.2

    + Replacement models should be there in all track
        + Or better replacement models should be indexed in tracker itself
        + So in the end, every tracker can set the same replacemodel to their track


* [feature/reference-reconstructing] 0.0.1

    + Tracker tracks, but `modelId` values seems mixed up somewhere
        + Next is simply skip `modelId` from interface


* [feature/reference-reconstructing] 0.0.0

    + Added Tracker
        + Tracks represented models
        + Track every references to it so far
        + Real instances can be set back to references


* 0.4.51

    + Project grouping


* 0.4.5

    + Representing pool uses modelId to track ongoing representations
    + Leaves one issue
        + If a model gets reconstructed first by a reference representation only (only with model attributes)...
        + ...it will tracked in the pool with that.
            + Replacing with real values won't take place this case
            + Somehow that placeholder should get real values (all the way down the graph!)


* 0.4.4
    
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