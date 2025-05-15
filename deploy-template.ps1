$timestamp = (Get-Date).ToString('yyyy-MM-dd-hh-mm-ss-tt')
$simpleDir = "./SolutionPackages/PCF_COMPONENT_NAME"                # <-- REPLACE TOKEN! #️⃣ 
$finalDir = "./SolutionPackages/PCF_COMPONENT_NAME-$timestamp"      # <-- REPLACE TOKEN! #️⃣ 
New-Item -ItemType Directory -Path $simpleDir -Force
Push-Location $simpleDir
# #️⃣ REPLACE TOKENS! ⬇️
pac solution init --publisher-name "YOUR_PUBLISHER_NAME" --publisher-prefix "YOUR_PUBLISHER_PREFIX"
pac solution add-reference --path "../.."
Pop-Location
New-Item -ItemType Directory -Path $finalDir -Force
Move-Item -Path "$simpleDir/*" -Destination $finalDir
Remove-Item -Path $simpleDir -Force
msbuild /t:build /restore
# #️⃣ REPLACE TOKENS! ⬇️
pac auth create --environment "ENVIRONMENT_NAME"
# #️⃣ REPLACE TOKENS! ⬇️
pac pcf push --publisher-prefix YOUR_PUBLISHER_PREFIX