module ReviewConfig exposing (config)

{-| Do not rename the ReviewConfig module or the config function, because
`elm-review` will look for these.

To add packages that contain rules, add them to this review project using

    `elm install author/packagename`

when inside the directory containing this file.

-}

import Docs.NoMissing exposing (allModules, onlyExposed)
import NoConfusingPrefixOperator
import NoExposingEverything
import NoImportingEverything
import NoMissingTypeAnnotation
import NoMissingTypeAnnotationInLetIn
import NoUnused.CustomTypeConstructorArgs
import NoUnused.CustomTypeConstructors
import NoUnused.Dependencies
import NoUnused.Exports
import NoUnused.Parameters
import NoUnused.Patterns
import NoUnused.Variables
import Review.Rule as Rule exposing (Rule)
import Simplify


config : List Rule
config =
    [ NoUnused.CustomTypeConstructors.rule []
    , NoUnused.CustomTypeConstructorArgs.rule
    , NoUnused.Dependencies.rule
    , NoUnused.Exports.rule
    , NoUnused.Parameters.rule
    , NoUnused.Patterns.rule
    , NoUnused.Variables.rule
        |> Rule.ignoreErrorsForDirectories [ "tests/" ]
    , Simplify.rule Simplify.defaults
    , NoConfusingPrefixOperator.rule
    , NoExposingEverything.rule
        |> Rule.ignoreErrorsForDirectories [ "tests/" ]
    , NoImportingEverything.rule []
        |> Rule.ignoreErrorsForDirectories [ "tests/" ]
    , NoMissingTypeAnnotation.rule
        |> Rule.ignoreErrorsForDirectories [ "tests/" ]
    , NoMissingTypeAnnotationInLetIn.rule
        |> Rule.ignoreErrorsForDirectories [ "tests/" ]
    ]
