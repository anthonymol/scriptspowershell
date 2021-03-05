$DateNow = Get-Date -Format "yyMMdd"

$fichiersource1 = "C:\Users\a.mollier\Desktop\script\Préprod\Applis_diskC\Titan\Fichiers\prelmt\PR$DateNow-001.xml"
$fichierdestination1 = "C:\Users\a.mollier\Desktop\script\Préprod\Applis_diskE\echanges\DIAPASON\PR$DateNow-001.xml"
$source1 = "PR$FormDate1-001.xml"

$fichiersource2 = "C:\Users\a.mollier\Desktop\script\Préprod\Applis_diskC\Titan\Fichiers\virmt\VIR$DateNow-001.xml"
$fichierdestination2 = "C:\Users\a.mollier\Desktop\script\Préprod\Applis_diskE\echanges\DIAPASON\VIR$DateNow-001.xml"
$source2 = "VIR$FormDate1-001.xml"

$fichierlog = "C:\Users\a.mollier\Desktop\script\Préprod\log.txt"
$FileName = [io.path]::GetFileNameWithoutExtension($fichierlog)
$FileExtension = [io.path]::GetExtension($fichierlog)

#------------------------------------------------------------FICHIER1------------------------------------------------------------------

Copy-Item $fichiersource1 $fichierdestination1
$Contentfichiersource1 = Get-Content -path $fichiersource1
$Contentfichierdestination1 = Get-Content -path $fichierdestination1
(Compare-Object -referenceObject $Contentfichiersource1 -differenceObject $Contentfichierdestination1 -IncludeEqual |
     ForEach-Object {
        if ($_.SideIndicator -ne '==')
        {
            $count1 = "false"

        }

        if ($_.SideIndicator -eq '==') 
        {
            $count1 = "true"
        }
    }
)

$archivefile = "$source1"
$archivename = [io.path]::GetFileNameWithoutExtension($archivefile)
$archiveextension = [io.path]::GetExtension($archivefile)

$count = "true"

$compress = @{
  Path = $fichiersource1
  CompressionLevel = "Fastest"
  DestinationPath = "C:\Users\a.mollier\Desktop\script\Préprod\Archives\$source1.zip"
}

If ($count1 -eq "true") 
{
    echo "--------------------------> export date : $DateNow" "----------------------" "Export source file :"$fichiersource1 "destination files :"$fichierdestination1 ": SUCCEED" >> $fichierlog 
    If ((Test-Path $archivefile) -eq $True) 
            {
                Write-Host "Le Fichier archive existe déjà"
            }
              
            else
            {
                Compress-Archive @compress
                echo "----------------------" "Archive file : SUCCEED" >> $fichierlog "----------------------"
                Remove-Item $fichiersource1
            }
}
elseif ($count1 -eq "false")
{
                echo ">"$DateNow "Export source file :$fichiersource1 and destination files :$fichierdestination1 : FAILED" | out-file $fichierlog| out-file $fichierlog
}


#------------------------------------------------------------FICHIER2------------------------------------------------------------------

Copy-Item $fichiersource2 $fichierdestination2
$Contentfichiersource2 = Get-Content -path $fichiersource2
$Contentfichierdestination2 = Get-Content -path $fichierdestination2
(Compare-Object -referenceObject $Contentfichiersource2 -differenceObject $Contentfichierdestination2 -IncludeEqual |
     ForEach-Object {
        if ($_.SideIndicator -ne '==')
        {
            $count2 = "false"

        }

        if ($_.SideIndicator -eq '==') 
        {
            $count2 = "true"
        }
    }
)

$archivefile = "$source2"
$archivename = [io.path]::GetFileNameWithoutExtension($archivefile)
$archiveextension = [io.path]::GetExtension($archivefile)

$count = "true"

$compress = @{
  Path = $fichiersource2
  CompressionLevel = "Fastest"
  DestinationPath = "C:\Users\a.mollier\Desktop\script\Préprod\Archives\$source2.zip"
}

If ($count2 -eq "true") 
{
    echo "--------------------------> export date : $DateNow" "----------------------" "Export source file :"$fichiersource2 "destination files :"$fichierdestination2 ": SUCCEED" >> $fichierlog 
    If ((Test-Path $archivefile) -eq $True) 
            {
                Write-Host "Le Fichier archive existe déjà"
            }
              
            else
            {
                Compress-Archive @compress
                echo "----------------------" "Archive file : SUCCEED" >> $fichierlog "----------------------"
                Remove-Item $fichiersource2
            }
}
elseif ($count2 -eq "false")
{
                echo ">"$DateNow "Export source file :$fichiersource2 and destination files :$fichierdestination2 : FAILED" | out-file $fichierlog| out-file $fichierlog
}
#------------------------------------------------------------MAIL GENERATE------------------------------------------------------------------

If (($count1 -eq "true") -or ($count2 -eq "true"))
{
    invoke-expression -Command .\mailsucceedxml.ps1
}
If(($count1 -ne "true") -or ($count2 -ne "true"))
{
    invoke-expression -Command .\mailfailurexml.ps1
}