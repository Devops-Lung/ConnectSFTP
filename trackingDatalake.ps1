
$PSNativeCommandArgumentPassing = "Legacy"

$chooseDate = (Get-Date).AddDays(-1)
$yesterday =$chooseDate.ToString('yyyyMMdd')

& "C:\Program Files (x86)\WinSCP\WinSCP.com" `
  /log="C:\Temp\WinSCP.log" /ini=nul `
  /command `
    "open sftp://MarriottAdmin:Marriott%40%24%232022@103.238.211.31:2222/ -hostkey=`"`"ssh-ed25519 255 VPRcg961ZZB31OO9xX0Dytq8fiT6wd3muBDsIPipldo`"`" -rawsettings GSSAPIFwdTGT=1" `
    "echo '===================CONNECTED TO DATALAKE==========================" `
    "echo '~~~~~~~~~~~ Show DADMR_HANLP_HPHSI/ Checksum ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/Checksum/DADMR_HANLP_HPHSI/$yesterday" `
    "echo '~~~~~~~~~~~ Show SGNAK_VCASI_PQCSR Checksum ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/Checksum/SGNAK_VCASI_PQCSR/$yesterday/ " `
    "echo '~~~~~~~~~~~ Show CXRHT_DADNN_DADHA Checksum ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/Checksum/CXRHT_DADNN_DADHA/$yesterday/ " `
    "echo '~~~~~~~~~~~ Show HANHP Checksum ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/Checksum/HANHP/$yesterday/ " `
    "echo '~~~~~~~~~~~ Show yourProperty FinancalTransaction ~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/FINANCIAL_TRANSACTIONS/HANHP/$yesterday/" `
    "echo '~~~~~~~~~~~ Show yourProperty RoomList ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/RoomList/HANHP/$yesterday/" `
    "echo '~~~~~~~~~~~ Show yourProperty TransactionCodeList ~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/TransactionCodeList/HANHP/$yesterday/" `
    "echo '~~~~~~~~~~~ Show yourProperty ReservationDailyStatistic ~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/ReservationDailyStatistic/HANHP/$yesterday/" `
    "echo '~~~~~~~~~~~ Show yourProperty RoomCategoryStatistic ~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/RoomCategoryStatistic/HANHP/$yesterday/" `
    "exit"

$winscpResult = $LastExitCode
if ($winscpResult -eq 0)
{
Send-MailMessage -SmtpServer "smtp.marriott.com" -Subject "<DATALAKE> Success" -From "irfd.hanhp@marriott.com" -To "lung.n.ho@fourpoints.com" -Body "All of Data to Datalake Server"
      
}
else
{
 Send-MailMessage -SmtpServer "smtp.marriott.com" -Subject "<DATALAKE> FAILED" -From "irfd.hanhp@marriott.com" -To "lung.n.ho@fourpoints.com" -Body "Please run SFTP in TaskSchedule in OPRSS Again!!!!!" 
 exit $winscpResult
}

exit $winscpResult
