﻿
$PSNativeCommandArgumentPassing = "Legacy"
Get-Content "property.env" | ForEach-Object{
$invar=$_.Split(" ").Trim()
Invoke-Expression (Invoke-Command -ScriptBlock{
$($invar[0])+"="+$($invar[1])
})

}
$chooseDate = (Get-Date).AddDays(-1)
$yesterday =$chooseDate.ToString('yyyyMMdd')
$string=

& "C:\Program Files (x86)\WinSCP\WinSCP.com" `
  /log="C:\Temp\WinSCP.log" /ini=nul `
  /command `
    "open sftp://MarriottAdmin:Marriott%40%24%232022@103.238.211.31:2222/ -hostkey=`"`"ssh-ed25519 255 VPRcg961ZZB31OO9xX0Dytq8fiT6wd3muBDsIPipldo`"`" -rawsettings GSSAPIFwdTGT=1" `
    "echo '<br>'" `
    "echo '===================CONNECTED TO DATALAKE========================== '<br>'" `
    "echo '~~~~~~~~~~~ Show DADMR_HANLP_HPHSI/ Checksum ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ '<br>'"  `
    "ls /fprd/Opera/DATALAKE/Checksum/DADMR_HANLP_HPHSI/$yesterday"  `
    "echo '<br>'" `
    "echo '~~~~~~~~~~~ Show SGNAK_VCASI_PQCSR Checksum ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ '<br>'"  `
    "ls /fprd/Opera/DATALAKE/Checksum/SGNAK_VCASI_PQCSR/$yesterday/ " `
    "echo '<br>'" `
    "echo '~~~~~~~~~~~ Show CXRHT_DADNN_DADHA Checksum ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ '<br>'" `
    "ls /fprd/Opera/DATALAKE/Checksum/CXRHT_DADNN_DADHA/$yesterday/ " `
    "echo '<br>'" `
    "echo '~~~~~~~~~~~ Show HANHP Checksum ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'<br>'" `
    "ls /fprd/Opera/DATALAKE/Checksum/HANHP/$yesterday/ " `
    "echo '<br>'" `
    "echo '~~~~~~~~~~~ Show $yourProperty FinancalTransaction ~~~~~~~~~~~~~~~~~~~~~~~ '<br>'" `
    "ls /fprd/Opera/DATALAKE/FINANCIAL_TRANSACTIONS/$yourProperty/$yesterday/" `
    "echo '<br>'" `
    "echo '~~~~~~~~~~~ Show $yourProperty RoomList ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ '<br>'" `
    "ls /fprd/Opera/DATALAKE/RoomList/$yourProperty/$yesterday/" `
    "echo '<br>'" `
    "echo '~~~~~~~~~~~ Show $yourProperty TransactionCodeList ~~~~~~~~~~~~~~~~~~~~~~~'<br>'" `
    "ls /fprd/Opera/DATALAKE/TransactionCodeList/$yourProperty/$yesterday/" `
    "echo '<br>'" `
    "echo '~~~~~~~~~~~ Show $yourProperty ReservationDailyStatistic ~~~~~~~~~~~~~~~~~'<br>'" `
    "ls /fprd/Opera/DATALAKE/ReservationDailyStatistic/$yourProperty/$yesterday/" `
    "echo '<br>'" `
    "echo '~~~~~~~~~~~ Show $yourProperty RoomCategoryStatistic ~~~~~~~~~~~~~~~~~~~~~'<br>'" `
    "ls /fprd/Opera/DATALAKE/RoomCategoryStatistic/$yourProperty/$yesterday/" `
    "echo '<br>'" `
    "exit"

$winscpResult = $LastExitCode
if ($winscpResult -eq 0)
{
Send-MailMessage -SmtpServer "smtp.marriott.com" -Subject "<DATALAKE-$yourProperty> $yesterday Success" -From $fromEmail -To $toEmail -BodyAsHtm -Body "$yourProperty DATA Transfered to Datalake Server'<br>' $string"
      
}
else
{
 Send-MailMessage -SmtpServer "smtp.marriott.com" -Subject "<DATALAKE-$yourProperty> $yesterday FAILED" -From $fromEmail -To $toEmail -BodyAsHtm -Body "Please run SFTP in TaskSchedule in OPRSS Again!!!!! '<br>' $string" 
 exit $winscpResult
}

exit $winscpResult
