
<#PSScriptInfo

.VERSION 1.0

.GUID ca29368b-7563-4e39-b855-5b52f8205d3a

.AUTHOR jdfen

.COMPANYNAME

.COPYRIGHT

.TAGS

.LICENSEURI

.PROJECTURI

.ICONURI

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES


.PRIVATEDATA

#>

<#

.DESCRIPTION
Syntax highlight Posix help with bat

#>
Param()

Function Get-Something {

    [CmdletBinding()]

    Param(

            [Parameter(ValueFromPipeline)]

            $item

         )

    process {
    $item | bat --plain --language help
    }
}
