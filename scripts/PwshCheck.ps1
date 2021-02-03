<#

.SYNOPSIS
    Healthcheck the Uri and display the result.

.DESCRIPTION
    The polling.ps1 display the helthcheck result for each second. You will see the format
    [Timestamp] | [StatusCode] | [Uri]

.PARAMETER Uri
    The target uri for checking the status

.PARAMETER displayUri
    If $true, it displays the Uri in output

.EXAMPLE
PS > .\polling.ps1 -Uri https://github.com/Azure-Samples/openhack-devops-proctor -displayUri $true
.\polling.ps1 -Uri https://github.com/Azure-Samples/openhack-devops-proctor -displayUri $true
21/03/2019 14:21:17 | 200 | https://github.com/Azure-Samples/openhack-devops-proctor
21/03/2019 14:21:21 | 200 | https://github.com/Azure-Samples/openhack-devops-proctor

.EXAMPLE
PS > .\polling.ps1 -Uri https://github.com/Azure-Samples/openhack-devops-proctor
21/03/2019 14:21:55 | 200
21/03/2019 14:21:58 | 200

#>

Param(
    [string] [Parameter(Mandatory = $true)] $Uri,
    [boolean] [Parameter(Mandatory = $false)] $displayUri
)

$iMax = 120
$i = 0
$output = while ($i -lt $iMax) {
    try {
        $R = Invoke-WebRequest -Uri $Uri -ErrorAction SilentlyContinue
    }
    catch {}

    if ($R.StatusCode -eq 200) { break }
    Start-Sleep -Seconds 1
    $i++
}
if ($i -eq $iMax) {
    Write-Error 'No 200 received'
}