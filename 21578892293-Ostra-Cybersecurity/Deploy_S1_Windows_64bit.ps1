$Local_Dest = "C:\Temp"
if (!(Test-Path  $Local_Dest)) {
    New-Item -Path $Local_Dest -ItemType Directory -Force | Out-Null
}
#https://github.com/ocs-eb1/ocs-epdr/blob/ostra/
Invoke-WebRequest -Uri https://raw.githubusercontent.com/ocs-eb1/ocs-epdr/blob/main/21578892293-Ostra-Cybersecurity/ostra-token.txt -OutFile $Local_Dest\ostra-token.txt
$token = Get-ChildItem "C:\Temp\ostra-token.txt"
$url = "https://raw.githubusercontent.com/ocs-eb1/ocs-epdr/tree/main/pkgs/SentinelInstaller_windows_64bit_v23_3_4_320.msi"
$file= Split-Path $url -Leaf 
$out_path = "C:\Temp\SentinelOneInstaller_windows_64bit_v23_3_4_320.msi"
$agent = (Get-ChildItem $Local_Dest -Filter "Sentinel*.msi").FullName
Invoke-WebRequest $url -OutFile $out_path
Start-Process msiexec.exe -ArgumentList " /i $agent $token /qn" -Wait