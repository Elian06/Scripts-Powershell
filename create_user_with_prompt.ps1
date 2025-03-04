# Demander le prénom, le nom et l'identifiant de connexion

$UtilisateurPrenom = Read-Host -Prompt "Prénom"
$UtilisateurNom = Read-Host -Prompt "Nom"
$UtilisateurLogin = Read-Host -Prompt "Identifiant"




# Demander l'adresse e-mail et la fonction

$UtilisateurEmail = Read-Host -Prompt "Adresse e-mail"
$UtilisateurFonction = Read-Host -Prompt "Fonction"




# Demander le mot de passe (stocké de manière sécurisée)

$UtilisateurMotDePasse = Read-Host -Prompt "Mot de passe" -AsSecureString




# Afficher les unités d'organisation disponibles

Write-Host "Unités d'organisation disponibles :"
Get-ADOrganizationalUnit | Select-Object -ExpandProperty Name




# Demander à l'utilisateur de choisir une unité d'organisation

$OU = Read-Host -Prompt "Entrez le nom de l'unité d'organisation"




# Créer l'utilisateur

New-ADUser -Name "$UtilisateurPrenom $UtilisateurNom" `
    -GivenName $UtilisateurPrenom `
    -Surname $UtilisateurNom `
    -SamAccountName $UtilisateurLogin `
    -UserPrincipalName "$UtilisateurLogin@votre_domaine.com" `
    -AccountPassword $UtilisateurMotDePasse `
    -Enabled $true `
    -ChangePasswordAtLogon $true `
    -Path "OU=$OU,DC=votre_domaine,DC=com"