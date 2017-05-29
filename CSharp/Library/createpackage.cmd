rem @echo off
rem Param1 = %1

setlocal
setlocal enabledelayedexpansion
setlocal enableextensions
set errorlevel=0
mkdir ..\nuget
erase /s ..\nuget\Microsoft.Bot.CognitiveServices.QnAMaker*nupkg
IF NOT {%1}=={nobuild} msbuild /property:Configuration=release Microsoft.Bot.Builder.CognitiveServices.QnAMaker.csproj 
for /f %%v in ('powershell -noprofile "(Get-Command .\bin\release\Microsoft.Bot.Builder.dll).FileVersionInfo.FileVersion"') do set builder=%%v
for /f %%v in ('powershell -noprofile "(Get-Command .\bin\release\Microsoft.Bot.Builder.CognitiveServices.QnAMaker.dll).FileVersionInfo.FileVersion"') do set version=%%v
IF NOT {%1}=={nobuild} ..\packages\NuGet.CommandLine.3.4.3\tools\NuGet.exe pack Microsoft.Bot.Builder.CognitiveServices.QnAMaker.nuspec -symbols -properties version=%version%;builder=%builder% -OutputDirectory ..\nuget

 IF {%1}=={nobuild} echo ##vso[task.setvariable variable=builder;]%builder%
 IF {%1}=={nobuild} echo ##vso[task.setvariable variable=version;]%version% 