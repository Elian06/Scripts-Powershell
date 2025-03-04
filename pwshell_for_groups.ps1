#  Créer un groupe :

New-ADGroup -Name "HR Group" -SamAccountName hrgroup -GroupScope Global -GroupCategory Security -path "OU=Users, DC=example, DC=com"



# Ajouter des membres dans un groupe :

Add-ADGroupmember -Identity "HR Group" -Members jdoe



# Supprimer un groupe :

Remvove-ADGroup -Identity "HR Group"