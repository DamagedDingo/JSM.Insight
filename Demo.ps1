# Set Script Defaults
# These will be passed in automatically to all other functions in script scope
Set-InsightServer -Server 'YOUR URL HERE'
Set-InsightCreds -Username 'YOUR CASE SENSITIVE JIRA USERNAME' -Password 'YOUR JIRA PASSWORD'
Set-WorkspaceID

# Create a new Object Schema
New-ObjectSchema -Name "API Test" -objectSchemaKey "API" -Description "A Simple Demo Schema"

# Get Global Icons
Get-Icons

# Get Individual Icon
Get-Icons -IconID 1

# Get an object by its Key
Get-Object -ID "OBJECT ID HERE" # Only Name and ID
Get-Object -ID "OBJECT ID HERE" -Full # Complete information
