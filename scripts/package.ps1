<#
    .DESCRIPTION
        This script packages and uploads .Net Class Libraries to Nuget. 
    
    .PARAMETER version
        The semantec version number.
    
    .PARAMETER projectName
        The name of the .Net project.

    .PARAMETER projectDirectory
        The the directory where the Project file is located.
    
    .PARAMETER apiKey
        The Nuget API Key.

    .NOTES
        AUTHOR: Steve Owens
        LASTEDIT: July 26, 2022
        VERSION: 1.0.0
#>

param(
    [string] [Parameter(Mandatory=$true)] $version,
    [string] [Parameter(Mandatory=$true)] $projectName,
    [string] [Parameter(Mandatory=$true)] $apiKey,
    [securestring] [Parameter(Mandatory=$true)] $projectDirectory
)

try {
        if (Test-Path -Path $projectDirectory){
            Set-Location -Path $projectDirectory
        }
        else {
            throw "Error: Directory not found!"
        }
    }
catch
    {
        Write-Error "Error: Project Directory ($projectDirectory}) does not exist!"
    }

$packageName="${projectName}.${version}.nupkg"
$packageLocation="./bin/Debug/${packageName}"

try {
    dotnet build
    Write-Host "Software Built - ${packageName}"
}
catch {
    Write-Error "Error: Software build failed!"
}

try {
    dotnet pack /p:Version=${version}
    Write-Host "Package created - ${packageName}"
}
catch {
    Write-Error "Error: Package creation failed, please try again!"
}

Write-Host "Uploading Package to Nuget..."
try {
    dotnet nuget push ${packageLocation} --api-key ${apiKey} --source https://api.nuget.org/v3/index.json
    Write-Host "Package Uploaded to Nuget."
}
catch {
    Write-Error "Error: Package upload failed, please try again!"
}

