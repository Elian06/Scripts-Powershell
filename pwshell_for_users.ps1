# Interroger AD 
# Récupération des données de l'utilisateur :

Get-AdUser -identity jhonDoe

# Lister tous les utilisateurs de l'AD :
Get-ADUser -filter * -SearchBase "OU=Users, DC=example, DC=com"

# Créer un nouvel utilisateur : 
New-ADUser -Name "Jhon Doe" -GivenName Jhon -Surname Doe -SamAccountName jdoe -UserPrincipalName jdoe@example.com -path "OU=Users, DC=example, DC=com" -AccountPassword (ConvertTo-SecureString "P@ssWord" -AsPlainText -Force) -Enabled $true

# Modifier un user :
Set-ADUser -Identity jdoe -Title "Project Manager" -Depetment "IT"

# Supprimer un user :
Remove-ADUser -identity jdoe 