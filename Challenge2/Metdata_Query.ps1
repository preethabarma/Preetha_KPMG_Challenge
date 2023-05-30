###For all metadata of VM in json format###########################
$result= Invoke-RestMethod -Headers @{"Metadata"="true"} -Method Get -Proxy $null -Uri "http://169.254.169.254/metadata/instance?api-version=2021-02-01"
Write-Host `n"The VM metadata:"
$result | ConvertTo-Json

###For network metadata###########################
$resultnetwork= Invoke-RestMethod -Headers @{"Metadata"="true"} -Method Get -Proxy $null -Uri "http://169.254.169.254/metadata/instance/network/interface?api-version=2021-02-01"
Write-Host `n"The VM network metadata:"
$resultnetwork | ConvertTo-Json


#network dig in using key value pair
Write-Host `n"ipv4 metadata:"
$resultnetwork.ipv4 | ConvertTo-Json
$resultnetwork.macAddress | ConvertTo-Json



###For Compute metadata##############################
$resultcompute= Invoke-RestMethod -Headers @{"Metadata"="true"} -Method Get -Proxy $null -Uri "http://169.254.169.254/metadata/instance/compute?api-version=2021-02-01"
Write-Host `n"The VM compute metadata:"
$resultcompute | ConvertTo-Json 

Write-Host `n"VM's image reference metadata:"
$resultcompute.storageProfile.imageReference | ConvertTo-Json
$resultcompute.sku | ConvertTo-Json


###For tags########################################
$resulttags= Invoke-RestMethod -Headers @{"Metadata"="true"} -Method Get -Proxy $null -Uri "http://169.254.169.254/metadata/instance/compute/tagsList?api-version=2021-02-01"
Write-Host `n"The VM tags metadata:"
$resulttags| ConvertTo-Json
Write-Host `n"VM's tag names metadata:"
$resulttags.name | ConvertTo-Json
