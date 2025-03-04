# Gérer AD avec des scripts :

# Création de plusieurs utilisateurs :
$userList = Import-Csv "C:\Users\userlist.csv"

foreach($user in $userList){
    New-ADUser -Name $user.Name -GivenName $user.GivenName -Surname $user.Surname -SamAccountName $user.SamAccountName -UserPrincipalName $user.UserPrincipalName -Path $user.Path -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force) -Enabled $true
}



# Générer des rappports :
Get-ADUser -filter * -SearchBasE "OU=Users, DC=example, DC=com" | Select-Object Name, SamAccountName, UserPrincipalName | Export-csv -Path "C:\Users\report.csv" -NoTypeInformation
