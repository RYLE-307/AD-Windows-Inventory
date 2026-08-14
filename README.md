# AD-Windows-Inventory

PowerShell script for collecting Windows hardware and operating system inventory from computers stored in Active Directory.

The script automatically retrieves Windows computers from Active Directory, connects to them using PowerShell Remoting / WinRM, collects system information through CIM, and exports the results to a CSV file.

## Collected information

- Computer name
- Manufacturer
- Model
- RAM
- Operating system
- OS version
- CPU
- BIOS serial number
- System disk
- Disk size
- Free disk space

## Requirements

- Windows PowerShell
- Active Directory PowerShell module
- PowerShell Remoting / WinRM enabled on target computers
- Administrative or sufficient remote permissions
- Target computers must be reachable from the machine running the script

## Usage

Run the script from PowerShell:

```powershell
.\AD-Windows-Inventory.ps1# AD-Windows-Inventory
PowerShell script for collecting Windows hardware and OS inventory from Active Directory computers using WinRM and CIM.
