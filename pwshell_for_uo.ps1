# Créer un UO :

New-ADOrganizationalUnit -Name "Marketing" -path "DC=example, DC=com"



# Déplacer un Objet vers un UO :

Move-ADObject -identity "CN=Jane Doe, OU=Users, DC=example, DC=com" -TargetPath  "OU=Marketing, DC=example, DC=com"



# Supprimer une UO :
Remove-ADOrganizationalUnit -identity "OU=Marketing, DC=example, DC=com"
