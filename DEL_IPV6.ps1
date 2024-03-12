# Vérifie si le script est exécuté avec des privilèges d'administrateur
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # Relance le script avec des privilèges d'administrateur
    Start-Process powershell.exe "-File `"$($MyInvocation.MyCommand.Definition)`"" -Verb RunAs
    exit
}
# Obtenir tous les adaptateurs réseau
$networkAdapters = Get-NetAdapter

foreach ($adapter in $networkAdapters) {
    try {
        # Désactiver IPv6 sur l'adaptateur actuel
        Set-NetAdapterBinding -Name $adapter.Name -ComponentID ms_tcpip6 -Enabled $False
        Write-Host "IPv6 désactivé sur l'adaptateur: $($adapter.Name)"
    } catch {
        Write-Error "Une erreur s'est produite lors de la tentative de désactivation de l'IPv6 sur l'adaptateur: $($adapter.Name). Erreur: $_"
    }
}

Write-Host "La désactivation de l'IPv6 sur tous les adaptateurs est complétée."
