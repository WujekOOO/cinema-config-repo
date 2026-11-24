
# Przejdź do folderu, w którym znajduje się skrypt
Set-Location $PSScriptRoot

# Sprawdź, czy są zmiany do zapisania
$changes = git status --porcelain

if (-not $changes) {
    Write-Host "Brak zmian do wyslania."
    exit 0
}

# Dodaj pliki i utwórz commit
git add .

if ($LASTEXITCODE -ne 0) {
    Write-Host "Blad podczas git add."
    exit 1
}

$message = "Aktualizacja konfiguracji $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git commit -m $message

if ($LASTEXITCODE -ne 0) {
    Write-Host "Blad podczas git commit."
    exit 1
}

# Wyslij zmiany do GitHuba
git push

if ($LASTEXITCODE -ne 0) {
    Write-Host "Blad podczas git push."
    exit 1
}

Write-Host "Konfiguracja zostala wyslana do GitHuba."
