$Local_Dest = "C:\Temp"
if (!(Test-Path  $Local_Dest)) {
    New-Item -Path $Local_Dest -ItemType Directory -Force | Out-Null
}
Invoke-WebRequest -Uri https://raw.githubusercontent.com/ocs-eb1/ocs-epdr/refs/heads/main/Ostra-site-token.mst -OutFile $Local_Dest\Ostra-site-token.mst
$token = Get-ChildItem "C:\Temp\Ostra-site-token.mst"
$url = "https://raw.githubusercontent.com/ocs-eb1/ocs-epdr/refs/heads/main/SentinelInstaller_windows_64bit_v23_3_4_320.msi"
$file= Split-Path $url -Leaf 
$out_path = "C:\Temp\SentinelOneInstaller_windows_64bit_v23_3_4_320.msi"
$agent = (Get-ChildItem $Local_Dest -Filter "Sentinel*.msi").FullName
Invoke-WebRequest $url -OutFile $out_path
Start-Process msiexec.exe -ArgumentList " /i $agent TRANSFORMS=$($token) /qn" -Wait

