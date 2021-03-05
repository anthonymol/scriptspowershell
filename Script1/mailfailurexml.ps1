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
$mailmessage.Body = "At least an error occured during the export of XML, please refer to the log file in the script directory"

 

Write-Host "Sending E-mail to $emailaddress" -ForegroundColor Green

 

Try
{
    $smtpclient.Send($mailmessage)
}
Catch
{
    $_ 
}