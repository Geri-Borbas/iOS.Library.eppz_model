## Doing


* Configure
    + Could configure unknown objects actually
    
* Default mapper extensions
    + NSDate (`dateFormatter` property at mapper level)
    + NSData (`base64`)

* Refactor
    + Split interfaces
        + Public / Package visibility with split headers
    + Split `EPPZMapper`
        + Split Representing / reconstructing implementations

* Test error cases
    + Arbitrary `NSDictionary`
    + Invalid (unmodeled) objects
    + Non-existent field names in mappers
    + Misaligned types compared to value mappers for the given field

* Warnings for reconstruction
    + Model ID error
    + ClassName error
    + Unvailable class error
    + Invalid values, unknown types