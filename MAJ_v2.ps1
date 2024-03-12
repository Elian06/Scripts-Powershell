# Vérifie si le script est exécuté avec des privilèges d'administrateur
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "Ce script nécessite des privilèges d'administrateur. Tentative de relance avec élévation..."
    Start-Process powershell.exe -ArgumentList "-File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Installation et importation conditionnelle du module PSWindowsUpdate
try {
    if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
        Install-Module -Name PSWindowsUpdate -Force
    }
    Import-Module PSWindowsUpdate
} catch {
    Write-Output "Impossible d'installer ou d'importer PSWindowsUpdate. Assurez-vous d'avoir accès à Internet et réessayez."
    exit
}

# Fonction principale pour l'application des mises à jour et gestion des redémarrages
function Update-WindowsAndHandleReboot {
    # Applique les mises à jour Windows
    try {
        Get-WindowsUpdate -AcceptAll -Install -AutoReboot
    } catch {
        Write-Output "Erreur lors de l'application des mises à jour. Vérification des mises à jour échouées."
    }

    # Vérification et enregistrement des mises à jour échouées
    $FailedUpdates = Get-WUHistory | Where-Object { $_.Result -eq "Failed" }
    if ($FailedUpdates.Count -gt 0) {
        $DesktopPath = [Environment]::GetFolderPath("Desktop")
        $FailedUpdates | Out-File "$DesktopPath\FailedWindowsUpdates.txt"
        Write-Output "Des mises à jour ont échoué. Consultez FailedWindowsUpdates.txt sur le bureau."
    }

    # Vérification de la nécessité de redémarrer
    if ((Get-WURebootStatus).RebootRequired) {
        $UserConsent = Read-Host "Un redémarrage est nécessaire pour finaliser les mises à jour. Redémarrer maintenant ? (O/N)"
        if ($UserConsent -eq 'O') {
            Restart-Computer -Force
        } else {
            Write-Output "Redémarrage différé par l'utilisateur."
        }
    } else {
        Write-Output "Aucun redémarrage nécessaire."
    }
}

# Exécution de la fonction principale
Update-WindowsAndHandleReboot
