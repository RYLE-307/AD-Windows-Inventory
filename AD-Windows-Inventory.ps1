$computers = Get-ADComputer -Filter * -Properties OperatingSystem |
    Where-Object OperatingSystem -like "*Windows*" |
    Select-Object -ExpandProperty Name

$inventory = Invoke-Command -ComputerName $computers -ScriptBlock {

    $computer = Get-CimInstance Win32_ComputerSystem
    $os       = Get-CimInstance Win32_OperatingSystem
    $cpu      = Get-CimInstance Win32_Processor
    $bios     = Get-CimInstance Win32_BIOS
    $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

    [PSCustomObject]@{
        ComputerName = $env:COMPUTERNAME
        Manufacturer = $computer.Manufacturer
        Model        = $computer.Model
        RAM_GB       = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)
        OS           = $os.Caption
        Version      = $os.Version
        CPU          = ($cpu.Name -join "; ")
        Serial       = $bios.SerialNumber
	Disk     = $disk.DeviceID
         DiskSizeGB  = [math]::Round($disk.Size / 1GB, 2)
        DiskFreeGB  = [math]::Round($disk.FreeSpace / 1GB, 2)
    }
}

$inventory |
    Select-Object ComputerName,
                  Manufacturer,
                  Model,
                  RAM_GB,
                  OS,
                  Version,
                  CPU,
                  Serial,
                  Disk,
                  DiskSizeGB,
                  DiskFreeGB |
    Sort-Object ComputerName |
    Export-Csv ".\inventory.csv" `
        -NoTypeInformation `
        -Encoding UTF8








