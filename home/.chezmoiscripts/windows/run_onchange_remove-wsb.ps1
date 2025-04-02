"Disabling Windows Search Bar"

"requires elevated prompt..."

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = " -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -Wait -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force
New-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "EnableDynamicContentInWSB" -PropertyType DWORD -Value 0