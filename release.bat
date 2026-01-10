@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM 1) Ask for version
set "ver="
set /p ver=Enter version (e.g., v1.0 or 1.0):
if "%ver%"=="" (
  echo ERROR: Version cannot be empty.
  exit /b 1
)

REM normalize to no-leading-v for naming: "v1.0" -> "1.0"
set "verNoV=%ver%"
if /I "!verNoV:~0,1!"=="v" set "verNoV=!verNoV:~1!"

set "PACK1=DFH Datapack"
set "PACK2=DFH Resources"
set "PACK3=dependency"

if not exist "%CD%\%PACK1%\" (
  echo ERROR: Folder not found: "%CD%\%PACK1%"
  exit /b 1
)
if not exist "%CD%\%PACK2%\" (
  echo ERROR: Folder not found: "%CD%\%PACK2%"
  exit /b 1
)

set "ZIP1=%CD%\DFH Datapack v%verNoV%.zip"
set "ZIP2=%CD%\DFH Resources v%verNoV%.zip"
set "ZIP3=%CD%\DFH-dependency-v%verNoV%.zip"

if exist "%ZIP1%" del /f /q "%ZIP1%" >nul 2>&1
if exist "%ZIP2%" del /f /q "%ZIP2%" >nul 2>&1
if exist "%ZIP3%" del /f /q "%ZIP3%" >nul 2>&1

REM 2/3) Zip folder CONTENTS (not the folder itself), then normalize entry paths to "/"
powershell -NoProfile -ExecutionPolicy Bypass ^
  "$ErrorActionPreference='Stop';" ^
  "function New-ZipWithForwardSlashes([string]$SourceDir,[string]$ZipPath) {" ^
  "  $SourceDir = (Resolve-Path -LiteralPath $SourceDir).Path;" ^
  "  if (Test-Path -LiteralPath $ZipPath) { Remove-Item -LiteralPath $ZipPath -Force }" ^
  "  $items = Get-ChildItem -LiteralPath $SourceDir -Force -ErrorAction SilentlyContinue;" ^
  "  if ($items) {" ^
  "    Compress-Archive -LiteralPath ($items.FullName) -DestinationPath $ZipPath -CompressionLevel Optimal;" ^
  "  } else {" ^
  "    New-Item -ItemType Directory -Path (Join-Path $env:TEMP ('zip_empty_' + [guid]::NewGuid())) | Out-Null;" ^
  "    Compress-Archive -LiteralPath (Join-Path $env:TEMP '*') -DestinationPath $ZipPath -CompressionLevel Optimal;" ^
  "  }" ^
  "  Add-Type -AssemblyName System.IO.Compression | Out-Null;" ^
  "  Add-Type -AssemblyName System.IO.Compression.FileSystem | Out-Null;" ^
  "  $tmp = Join-Path ([IO.Path]::GetDirectoryName($ZipPath)) ([IO.Path]::GetFileNameWithoutExtension($ZipPath) + '.tmp.zip');" ^
  "  if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Force }" ^
  "  $in  = [System.IO.Compression.ZipFile]::OpenRead($ZipPath);" ^
  "  $out = [System.IO.Compression.ZipFile]::Open($tmp, 'Create');" ^
  "  try {" ^
  "    foreach ($e in $in.Entries) {" ^
  "      $name = $e.FullName -replace '\\','/';" ^
  "      if ($name.EndsWith('/')) {" ^
  "        $null = $out.CreateEntry($name);" ^
  "        continue" ^
  "      }" ^
  "      $ne = $out.CreateEntry($name, [System.IO.Compression.CompressionLevel]::Optimal);" ^
  "      $ne.LastWriteTime = $e.LastWriteTime;" ^
  "      $sIn  = $e.Open();" ^
  "      $sOut = $ne.Open();" ^
  "      try { $sIn.CopyTo($sOut) } finally { $sOut.Dispose(); $sIn.Dispose() }" ^
  "    }" ^
  "  } finally { $out.Dispose(); $in.Dispose() }" ^
  "  Move-Item -LiteralPath $tmp -Destination $ZipPath -Force;" ^
  "}" ^
  "New-ZipWithForwardSlashes -SourceDir (Join-Path $PWD '%PACK1%') -ZipPath '%ZIP1%';" ^
  "New-ZipWithForwardSlashes -SourceDir (Join-Path $PWD '%PACK2%') -ZipPath '%ZIP2%';" ^
  "New-ZipWithForwardSlashes -SourceDir (Join-Path $PWD '%PACK3%') -ZipPath '%ZIP3%';"

if errorlevel 1 (
  echo ERROR: Packaging failed.
  exit /b 1
)

echo.
echo Done:
echo   "%ZIP1%"
echo   "%ZIP2%"
echo   "%ZIP3%"
exit /b 0
