## Doing


* Test error cases

    + Arbitrary `NSDictionary`
    + Invalid (unmodeled) objects
    + Non-existent field names in mappers
    + Misaligned types compared to value mappers for the given field


* Warnings for reconstruction

    + Model ID errors
    + ClassName error
    + Unvailable class error
    + Invalid values, unknown types


* Hide some more methods

    + `EPPZFieldMapper` and `EPPZValueMapper` yet have some methods left public


* Configure

    + Could configure unknown objects actually