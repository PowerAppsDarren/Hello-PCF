$timestamp = (Get-Date).ToString('yyyy-MM-dd-hh-mm-ss-tt')
$simpleDir = "./SolutionPackages/HelloPCF"                # <-- REPLACE TOKEN! #️⃣ 
$finalDir = "./SolutionPackages/HelloPCF-$timestamp"      # <-- REPLACE TOKEN! #️⃣ 
New-Item -ItemType Directory -Path $simpleDir -Force
Push-Location $simpleDir
# #️⃣ REPLACE TOKENS! ⬇️
pac solution init --publisher-name "SuperPowerLabs" --publisher-prefix "spl"
pac solution add-reference --path "../.."
Pop-Location
New-Item -ItemType Directory -Path $finalDir -Force
Move-Item -Path "$simpleDir/*" -Destination $finalDir
Remove-Item -Path $simpleDir -Force
msbuild /t:build /restore
# #️⃣ REPLACE TOKENS! ⬇️
pac auth create --environment "Sandbox - GIT"
# #️⃣ REPLACE TOKENS! ⬇️
pac pcf push --publisher-prefix spl