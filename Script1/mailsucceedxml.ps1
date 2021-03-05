#CredObj path
$CredObj = ("C:\Users\a.mollier\Desktop\script\Préprod\Email.cred")

 

#Check if CredObj is present
$CredObjCheck = Test-Path -Path $CredObj
If (!($CredObjCheck))
{
    "$Date - INFO: creating cred object"
    
    #If not present get office 365 cred to save and store
    $Credential = Get-Credential -Message "Please enter your Office 365 credential that you will use to send e-mail from $FromEmail. If you are not using the account $FromEmail make sure this account has 'Send As' rights on $FromEmail."
    
    #Export cred obj
    $Credential | Export-CliXml -Path $CredObj
}

Write-Host "Importing Cred object..." -ForegroundColor Yellow
$Cred = (Import-CliXml -Path $CredObj)

$SmtpClient = new-object system.net.mail.smtpClient
$MailMessage = New-Object system.net.mail.mailmessage
        
#Sender
$mailmessage.From = "a.mollier@axido.fr"
#SMTP server to send email
$SmtpClient.Host = "smtp.office365.com"
$SmtpClient.Port = 587
#SMTP SSL
$SMTPClient.EnableSsl = $true
#SMTP credentials
$SMTPClient.Credentials = $cred
#Send e-mail to the users email
$mailmessage.To.add("a.mollier@axido.fr")
#Email subject
$mailmessage.Subject = "CHECK FILES XML"
#Send e-mail with high priority
$MailMessage.Priority = "High"
$mailmessage.Body = "The copy of the XML files SUCCEED"

 

Write-Host "Sending E-mail to $emailaddress" -ForegroundColor Green

 

Try
{
    $smtpclient.Send($mailmessage)
}
Catch
{
    $_ 
}