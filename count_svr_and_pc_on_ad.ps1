#Importation du ModuleActive Directory
Import-Module ActiveDirectory

#Obtenuir tous les ordinateurs de l'AD
$allcomputers = get-adcomputer -filter * -property DistinguishedName

#Initiliser les compteurs 
$serverCount = 0
$workstationCount = 0


#Parcourir chaque ordinateur pour savoir si c'est un pc ou un serveur
foreach ($computer in $allcomputers){
    if($computer.DistinguishedName -match "server"){
        #si le nom du système contient "server", c'est un serveur
        $serverCount++
    } else { 
        #sinon, c'est un pc
        $workstationCount++
    }
}

$totalCount = $serverCount + $workstationCount

$message = "Le nombre de serveurs est : $serverCount, Le nombre de worsktations est : $workstationCount, Le nombre total est de $totalCount"

#Charger l'assembly nécessaire pour les notifications
Add-Type -AssemblyName System.Windows.Forms

#Pour afficher sur une "popup" [System.Windows.Forms.MessageBox]::Show($message, "Résultat nombre Serveurs // Workstations", 'OK', 'Information')

#Pour afficher en notification en bas à droite de l'écran
$notify = New-Object System.Windows.Forms.NotifyIcon
$notify.Icon = [System.Drawing.SystemIcons]::Information
$notify.Visible = $true
$notify.BalloonTipTitle = "Résultat du script"
$notify.BalloonTipText = $message

#Afficher la notif
$notify.ShowBalloonTip(1000000)

#Nettoyer l'icône au bout de 10 secondes
Start-Sleep -Seconds 100
$notify.Dispose()
