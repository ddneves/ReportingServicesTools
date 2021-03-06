# Copyright (c) 2016 Microsoft Corporation. All Rights Reserved.
# Licensed under the MIT License (MIT)

function Get-RsCatalogItems
{
	<#
	.SYNOPSIS
		List all catalog items under a given path.

	.DESCRIPTION
		List all catalog items under a given path.

	.PARAMETER ReportServerUri (optional)
		Specify the Report Server URL to your SQL Server Reporting Services Instance.
		Has to be provided if proxy is not provided.

	.PARAMETER ReportServerCredentials (optional)
		Specify the credentials to use when connecting to your SQL Server Reporting Services Instance.

	.PARAMETER Proxy (optional)
		Report server proxy to use. 
		Has to be provided if ReportServerUri is not provided.

	.PARAMETER Path
		Path to folder.

	.PARAMETER Recurse (optional)
		Recursively list subfolders with content.


	.EXAMPLE
		Get-RsCatalogItems -ReportServerUri 'http://localhost/reportserver_sql2012' -Path /
	   
		Description
		-----------
		List all items under the root folder
	#>
	
	[cmdletbinding()]
    param(
        [string]
        $ReportServerUri = 'http://localhost/reportserver',
        
        [System.Management.Automation.PSCredential]
        $ReportServerCredentials,
        
        $Proxy,
        
        [Parameter(Mandatory=$True)]
        [string]
        $Path,
        
        [switch]
        $Recurse
    )

    if(-not $Proxy)
    {
		$Proxy = New-RSWebServiceProxy -ReportServerUri $ReportServerUri -Credentials $ReportServerCredentials
    }

    $Proxy.ListChildren($Path, $Recurse)    
}