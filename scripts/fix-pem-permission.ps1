# Sửa quyền file .pem trên Windows để OpenSSH chấp nhận (mục 3 tài liệu), rồi SSH vào EC2.
# Cách dùng (PowerShell):
#   powershell -ExecutionPolicy Bypass -File scripts\fix-pem-permission.ps1 -PemPath "D:\keys\luxe.pem" -Ec2Ip 13.250.1.2
param(
    [Parameter(Mandatory = $true)][string]$PemPath,
    [string]$Ec2Ip,
    [string]$User = "ubuntu"
)

if (-not (Test-Path $PemPath)) {
    Write-Error "Không tìm thấy file: $PemPath"
    exit 1
}

icacls $PemPath /reset
icacls $PemPath /inheritance:r
icacls $PemPath /remove "NT AUTHORITY\Authenticated Users" "BUILTIN\Administrators" "BUILTIN\Users" "NT AUTHORITY\SYSTEM" 2>$null
icacls $PemPath /grant:r "$($env:USERNAME):(R)"
icacls $PemPath

if ($Ec2Ip) {
    ssh -i $PemPath "$User@$Ec2Ip"
}
