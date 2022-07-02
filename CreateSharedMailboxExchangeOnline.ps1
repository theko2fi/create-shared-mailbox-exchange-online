
$UserCredential = Get-Credential 

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking

$langages = @("user1@domain.com",
"user2@domain.com",
"user3@domain.com",
)

foreach ($i in $langages) {
    $PrimarySmtpAddress = $i
    $CharArray =$i.Split("@")
    $Title = (Get-Culture).TextInfo.ToTitleCase($CharArray[0])
    $Domain = (Get-Culture).TextInfo.ToUpper($CharArray[1]).Substring(0,$CharArray[1].IndexOf(".com"))
    $Name = "$Title ($Domain)"
 
    New-Mailbox -Shared -Name "$Name" -PrimarySmtpAddress "$PrimarySmtpAddress"
    set-mailbox "$PrimarySmtpAddress" -MessageCopyForSentAsEnabled $True
    set-mailbox "$PrimarySmtpAddress" -MessageCopyForSendOnBehalfEnabled $True

} 
 
Remove-PSSession $Session 
