# Looks for SQL2008 servers in a CSV file and produces a big OR-ed regular expression that can be used to define a Virtual Machine dynamic group in Turbonomic

# INPUTS: 
#	CSV_FILE: A CSV file containing at least a column called "Instance Name" which contains the server name (as it appears in Turbo) and a "Version" column that contains an indication whether it is an SQL2008 server or not.
#
# OUTPUT: a regular expression of server names to be used as a Name filter for a Turbonomic Virtual Machine Dynamic group.

param(
[Parameter(Mandatory=$true)][string]$CSV_FILE
)

$JSON_STUFF = Import-Csv $CSV_FILE |  ConvertTo-Json  | ConvertFrom-Json

$SQL_SERVER_REGEXP = ""
foreach ($ITEM in $JSON_STUFF) {
	$NAME = $ITEM."Name"
	$I_NAME = $ITEM."Instance Name"
	$VERSION = $ITEM."Version"
	if ($VERSION -match '[Ss][Qq][Ll] *2008') {
		#Write-Output "GOOD: $NAME --  $I_NAME -- $VERSION"
		$NAME_REGEXP = ".*$I_NAME.*"
		if ($SQL_SERVER_REGEXP) {
			$SQL_SERVER_REGEXP = "$SQL_SERVER_REGEXP|$NAME_REGEXP" 
		} else {
			$SQL_SERVER_REGEXP = $NAME_REGEXP
		}
	}
}

Write-Output $SQL_SERVER_REGEXP