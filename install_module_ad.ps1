# Installation du Module Active Directory sur Windows Server

Install-WindowsFeature -Name "RSAT-AD-PowerShell"


# Windows 10/11 : 
        # * Ouvrez Paramètres > Applications > Fonctionnalités optionnelles > Ajouter une fonctionnalité.
        # * Recherchez et installez RSAT: Active Directory Domain Services and Lightweight Directory Tools.


# Connexion à Active Directory :

Import-Module ActiveDirectory

# Vérifiez que le module est chargé en vérifiant les cmdlets disponibles : 

Get-Command -Module ActiveDirectory