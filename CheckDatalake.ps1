
$PSNativeCommandArgumentPassing = "Legacy"

Write-Host "+++++++++++++++++CHECK TRANSFERED FILE FROM VINPEARL DATALAKE++++++++++++++++++++++++"

Write-Host "@Author: Lung Ho"
Write-Host "@Copyright: May-2025"
Write-Host "Contact: +84969772250/Zalo/Viber/Whatsapp"
$yourProperty = Read-Host "~~~~~~~~~~~~Please Input Your Property (MASHA CODE):~~~~~~~~~~~~~~~~~~~~~"
while ($true){

$chooseDate = Read-Host "~~~~~~~~~~Please Type DATE to find yyyymmdd~~~~~~~~~~~~~~~"
& "C:\Program Files (x86)\WinSCP\WinSCP.com" `
  /log="C:\Temp\WinSCP.log" /ini=nul `
  /command `
    "open sftp://MarriottAdmin:Marriott%40%24%232022@103.238.211.31:2222/ -hostkey=`"`"ssh-ed25519 255 VPRcg961ZZB31OO9xX0Dytq8fiT6wd3muBDsIPipldo`"`" -rawsettings GSSAPIFwdTGT=1" `
    "echo '===================CONNECTED TO DATALAKE==========================" `
    "echo '~~~~~~~~~~~ Show DADMR_HANLP_HPHSI/ Checksum ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/Checksum/DADMR_HANLP_HPHSI/$chooseDate" `
    "echo '~~~~~~~~~~~ Show SGNAK_VCASI_PQCSR Checksum ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/Checksum/SGNAK_VCASI_PQCSR/$chooseDate/ " `
    "echo '~~~~~~~~~~~ Show CXRHT_DADNN_DADHA Checksum ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/Checksum/CXRHT_DADNN_DADHA/$chooseDate/ " `
    "echo '~~~~~~~~~~~ Show HANHP Checksum ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/Checksum/HANHP/$chooseDate/ " `
    "echo '~~~~~~~~~~~ Show $yourProperty FinancalTransaction ~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/FINANCIAL_TRANSACTIONS/$yourProperty/$chooseDate/" `
    "echo '~~~~~~~~~~~ Show $yourProperty RoomList ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/RoomList/$yourProperty/$chooseDate/" `
    "echo '~~~~~~~~~~~ Show $yourProperty TransactionCodeList ~~~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/TransactionCodeList/$yourProperty/$chooseDate/" `
    "echo '~~~~~~~~~~~ Show $yourProperty ReservationDailyStatistic ~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/ReservationDailyStatistic/$yourProperty/$chooseDate/" `
    "echo '~~~~~~~~~~~ Show $yourProperty RoomCategoryStatistic ~~~~~~~~~~~~~~~~~~~~~" `
    "ls /fprd/Opera/DATALAKE/RoomCategoryStatistic/$yourProperty/$chooseDate/" `
    "exit"

$winscpResult = $LastExitCode
if ($winscpResult -eq 0)
{
  Write-Host "====================SUCCESS========================================"
  $exit = Read-Host "~~~~~~~~~~Are You Want Exit? (Yes to EXIT) ~~~~~~~~~~~~~"
  if ($exit -eq "Yes"){
      Write-Host "====================GOOD BYE========================================"
      exit $winscpResult
      }
     
}
else
{
  Write-Host "Error"
  exit $winscpResult
}
}

exit $winscpResult
