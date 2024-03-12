# Vérifie si le script est exécuté avec des privilèges d'administrateur
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # Relance le script avec des privilèges d'administrateur
    Start-Process powershell.exe "-File `"$($MyInvocation.MyCommand.Definition)`"" -Verb RunAs
    exit
}
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Renommer l`ordinateur'
$form.Size = New-Object System.Drawing.Size(300,150)
$form.StartPosition = 'CenterScreen'

$label = New-Object System.Windows.Forms.Label
$label.Text = 'Nouveau nom:'
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)

$button = New-Object System.Windows.Forms.Button
$button.Text = 'Renommer'
$button.Location = New-Object System.Drawing.Point(10,70)
$button.Size = New-Object System.Drawing.Size(260,20)

$button.Add_Click({
    $newName = $textBox.Text
    if ([string]::IsNullOrWhiteSpace($newName)) {
        [System.Windows.Forms.MessageBox]::Show('Veuillez entrer un nom valide.', 'Erreur', [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    } else {
        Try {
            Rename-Computer -NewName $newName -Force -ErrorAction Stop
            [System.Windows.Forms.MessageBox]::Show("L'ordinateur a été renommé en '$newName'. Un redémarrage est nécessaire pour appliquer les changements.", 'Succès', [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        } Catch {
            [System.Windows.Forms.MessageBox]::Show("Erreur lors du renommage de l'ordinateur. Détails: $($_.Exception.Message)", 'Erreur', [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        }
    }
})
$form.Controls.Add($button)

$form.ShowDialog()
