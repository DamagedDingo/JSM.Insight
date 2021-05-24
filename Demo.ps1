# Set Script Defaults
# These will be passed in automaticly to all other commands in script scope
Set-InsightServer -Server 'YOUR URL HERE'
Set-InsightCreds -Username 'YOUR CASE SENSITIVE JIRA USERNAME' -Password 'YOUR JIRA PASSWORD'
Set-WorkspaceID

# Get Global Icons
Get-Icons

# Get Individual Icon
Get-Icons -IconID 1

# Get an object by its Key
Get-Object -ID "OBJECT ID HERE" # Only Name and ID
Get-Object -ID "OBJECT ID HERE" -Full # Complete information

