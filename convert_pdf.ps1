$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$htmlPath = "d:\New folder\Portfolio\cv_template.html"
$pdfPath = "d:\New folder\Portfolio\Burhan_Flutter_CV.pdf"
$userData = "C:\Users\user\AppData\Local\Temp\edge_pdf_profile_clean"

if (Test-Path $userData) {
    Remove-Item -Recurse -Force $userData -ErrorAction SilentlyContinue
}

$cmd = "`"$edge`" --headless=new --user-data-dir=`"$userData`" `"--print-to-pdf=$pdfPath`" `"$htmlPath`""
Write-Host "Running cmd: $cmd"

$result = Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$cmd`"" -PassThru -NoNewWindow
$result.WaitForExit(10000)

Start-Sleep -Seconds 2
if (Test-Path $pdfPath) {
    $item = Get-Item $pdfPath
    Write-Host "SUCCESS! Generated PDF:" $item.Name "Size:" $item.Length "Bytes" "LastWrite:" $item.LastWriteTime
} else {
    Write-Host "Checking if file exists in target directory..."
    Get-ChildItem "d:\New folder\Portfolio"
}
