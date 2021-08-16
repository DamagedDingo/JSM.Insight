
function Get-ObjectHash {
	param (
		[Parameter(ValueFromPipeline, mandatory = $true)]
		[object]$inputObject,

		[Parameter(ValueFromPipeline, mandatory = $false)]
		[ValidateSet(1, 2, 3, 4, 5)]
		[int]$Depth = 2
	)

	# Convert Object to JSON then String (string is required to get Hash)
	$inputObject = $inputObject | ConvertTo-Json -Depth $Depth | Out-String

	$stringAsStream = [System.IO.MemoryStream]::new()
	$writer = [System.IO.StreamWriter]::new($stringAsStream)
	$writer.write($inputObject)
	$writer.Flush()
	$stringAsStream.Position = 0
	$result = Get-FileHash -InputStream $stringAsStream -Algorithm MD5
    
	return $result.Hash
}

function Get-HostExternalMonitors {
	[CmdletBinding()]
	param (
		
	)
	
	begin {
		$Monitors = Get-CimInstance WmiMonitorID -Namespace root\wmi

		class Monitor {
			[string]$ManufacturerName
			[string]$UserFriendlyName
			[string]$SerialNumberID
			[string]$ObjectHash
		}
	}
	
	process {

		$ExternalMonitors = foreach ($Device in $Monitors) {

			if ($Device.UserFriendlyName) {
				$Monitor = [Monitor]::New()

				$Monitor.ManufacturerName = [String]::new($Device.ManufacturerName -ne 0)
				$Monitor.UserFriendlyName = [String]::new($Device.UserFriendlyName -ne 0)
				$Monitor.SerialNumberID = [String]::new($Device.SerialNumberID -ne 0) 
				$Monitor.ObjectHash = Get-ObjectHash -inputObject $Monitor -Depth 2

				$Monitor
			}
		}
	}
	
	end {
		return $ExternalMonitors
	}
}

function Get-HostOS {
	[CmdletBinding()]
	param (
		
	)
	
	begin {
		class OS {
			[string]$Name
			[string]$Manufacturer
			[string]$OSArchitecture
			[string]$Version
			[string]$BuildNumber
			[string]$Codename
			[string]$Kernel
			[string]$ServicePackMajorVersion
			[string]$ServicePackMinorVersion
			[string]$ObjectHash
		}

		$Win32_OperatingSystem = Get-CimInstance Win32_OperatingSystem

	}
	
	process {
		
		$OS = [OS]::New()

		$OS.Name = $Win32_OperatingSystem.Caption
		$OS.Manufacturer = $Win32_OperatingSystem.Manufacturer
		$OS.OSArchitecture = $Win32_OperatingSystem.OSArchitecture
		$OS.BuildNumber = $Win32_OperatingSystem.BuildNumber
		#$OS.Codename = 
		#$OS.Kernel = 
		$OS.ServicePackMajorVersion = $Win32_OperatingSystem.ServicePackMajorVersion
		$OS.ServicePackMinorVersion = $Win32_OperatingSystem.ServicePackMinorVersion

		$OS.ObjectHash = Get-ObjectHash -inputObject $OS
	}
	
	end {
		return $OS
	}
}

function Get-HostCPUs {
	[CmdletBinding()]
	param (
		
	)
	
	begin {
		class CPU {
			[string]$CPUType
			[string]$DeviceID
			[string]$NumberOfCores
			[string]$MaxClockSpeed
			[string]$ObjectHash
		}

		$Processors = Get-CimInstance Win32_Processor | Select-Object *
	}
	
	process {
		
		$CPUs = foreach ($Win32_Processor in $Processors) {
			
			$CPU = [CPU]::New()

			$CPU.CPUType = $Win32_Processor.Name
			$CPU.DeviceID = $Win32_Processor.DeviceID
			$CPU.NumberOfCores = $Win32_Processor.NumberOfCores
			$CPU.MaxClockSpeed = "$($Win32_Processor.MaxClockSpeed) MHz"

			$CPU.ObjectHash = (Get-ObjectHash -inputObject $CPU)

			$CPU
		}

	}
	
	end {
		$CPUs
	}
}

function Get-HostNetworkInterface {
	[CmdletBinding()]
	param (
		
	)
	
	begin {
		class NetworkAdaptor {
			[string]$Name
			[string]$DeviceID
			[string]$MACaddress
			[string]$IP4
			[string]$IP6
			[string]$Subnet4
			[string]$Subnet6
			[string]$Gateway
			[string]$DHCP
			[string]$AddressSpace
			[string]$ObjectHash
			[string]$HostObjectHash
			[string]$DeviceObjectHash
			[string]$VirtualGuestObjectHash
		}

		$NetworkAdapterConfiguration = Get-CimInstance Win32_NetworkAdapterConfiguration -Property * | Where-Object { ( $_.IPEnabled -eq 'true' ) -and ( $_.Description -notlike '*Virtual*' ) }
	}
	
	process {

		$NetworkAdaptors = foreach ($Adaptor in $NetworkAdapterConfiguration) {

			$NetworkAdaptor = [NetworkAdaptor]::New()

			$NetworkAdaptor.Name = ($Adaptor.IPAddress[0])
			#$NetworkAdaptor.DeviceID = 
			$NetworkAdaptor.MACaddress = ($Adaptor.MACAddress)
			$NetworkAdaptor.IP4 = ($Adaptor.IPAddress[0])
			$NetworkAdaptor.IP6 = ($Adaptor.IPAddress[1])
			$NetworkAdaptor.Subnet4 = ($Adaptor.IPSubnet)
			#$NetworkAdaptor.Subnet6 = $Adaptor.IPSubnet
			$NetworkAdaptor.Gateway = ($Adaptor.DefaultIPGateway)
			$NetworkAdaptor.DHCP = ($Adaptor.DHCPServer)
			# $NetworkAdaptor.AddressSpace = $Adaptor


			$NetworkAdaptor.ObjectHash = (Get-ObjectHash -inputObject $NetworkAdaptor)

			#$NetworkAdaptor.HostObjectHash = $Adaptor
			#$NetworkAdaptor.DeviceObjectHash = $Adaptor
			#$NINetworkAdaptorC.VirtualGuestObjectHash = $Adaptor

			$NetworkAdaptor
		}
	}
	
	end {
		$NetworkAdaptors
	}
}

function Get-HostStorageDevices {
	[CmdletBinding()]
	param (
		
	)
	
	begin {
		class Storage {
			[string]$Name
			[string]$Status
			[string]$DeviceID
			[string]$SizeGB
			[string]$SerialNumber
			[string]$FirmwareRevision
			[string]$InterfaceType
			[string]$Manufacturer
			[string]$MediaType
			[string]$Model
			[string]$ReferencedFileSystems
			[string]$ObjectHash
		}

		# $Win32_DiskDrive = Get-CimInstance Win32_DiskDrive  | Where-Object { $_.InterfaceType -ne 'USB' } | Select-Object *
		$AllDisks = Get-Disk | Where-Object { $_.BusType -ne 'USB' } | Select-Object *
	}

	process {
		
		$Disks = foreach ($DiskDrive in $AllDisks) {
			
			$Storage = [Storage]::New()

			$Storage.name = $DiskDrive.FriendlyName
			$Storage.status = $DiskDrive.OperationalStatus
			$Storage.DeviceID = $DiskDrive.UniqueId
			#$Storage.Description = $DiskDrive.Caption
			$Storage.SizeGB = [Math]::Round($DiskDrive.Size / 1GB)
			$Storage.SerialNumber = $DiskDrive.SerialNumber
			$Storage.FirmwareRevision = $DiskDrive.FirmwareVersion
			$Storage.InterfaceType = $DiskDrive.BusType
			$Storage.Manufacturer = $DiskDrive.Manufacturer
			$Storage.MediaType = $DiskDrive.MediaType
			$Storage.Model = $DiskDrive.Model
			#$Storage.ReferencedFileSystems = $DiskDrive.
			$Storage.ObjectHash = Get-ObjectHash -inputObject $Storage

			$Storage

		}

	}
	
	end {
		return $Disks
	}
}

function Get-Hypervisor {
	[CmdletBinding()]
	param (
		
	)
	
	begin {
		class HyperV {
			[string]$PhysicalHostName
			[string]$PhysicalHostNameFullyQualified
			[string]$HostingSystemOsMajor
			[string]$VirtualMachineName
			#[array]$VMs
		}
	}
	
	process {

		$HyperV = [HyperV]::New()

		if (Test-Path 'HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters') {
			
			$Guest_Parameters = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters\' -ErrorAction SilentlyContinue

			$HyperV.VirtualMachineName = $Guest_Parameters | Select-Object VirtualMachineName
			$HyperV.PhysicalHostName = $Guest_Parameters | Select-Object PhysicalHostName
			$HyperV.PhysicalHostNameFullyQualified = $Guest_Parameters | Select-Object PhysicalHostNameFullyQualified
			$HyperV.HostingSystemOsMajor = $Guest_Parameters | Select-Object HostingSystemOsMajor

		}
	}
	
	end {
		$HyperV
	}
}

function Get-HostPrinter {
	[CmdletBinding()]
	param (
		
	)
	
	begin {
		class Printer {
			[string]$name
			[string]$ServerName
			[string]$PortName
			[string]$Location
			[string]$ObjectHash
		}

		$Win32_Printer = Get-CimInstance Win32_Printer | Select-Object * | Where-Object { $_.name -notlike '*Onenote*' }
	}
	
	process {

		$Printers = foreach ($p in $Win32_Printer) {
			
			$Printer = [Printer]::New()

			if ($p.name -like '\\*') {
				$Printer.Name = $p.name.split('\') | Select-Object -l 1
			}
			else {
				$Printer.Name = $p.name
			}

			if ($p.ServerName -like '\\*') {
				$Printer.ServerName = $p.ServerName.split('\') | Select-Object -l 1
			}
			else {
				$Printer.ServerName = $p.ServerName
			}

			$Printer.Location = $p.Location
			$Printer.PortName = $p.PortName

			$Printer.ObjectHash = Get-ObjectHash -inputObject $Printer
			$Printer
		}
	}
	
	end {
		$Printers
	}
}

function Get-HostInfo {
	[CmdletBinding()]
	param (
		
	)
	
	begin {
		class HostInfo {
			[string]$Hostname
			[string]$SAMAccountName
			[string]$Domain
			[string]$Status
			[string]$FQDN
			[datetime]$LastBootUpTime
			[array]$Hypervisor
			[string]$SystemUpTime
			[string]$Timezone
			[string]$RamGB
			[string]$Model
			[string]$SerialNumber
			[string]$UUID
			[string]$Vendor
			[array]$ExternalMonitors
			[string]$LastLoggedOnUserSID
			[array]$Windows_OS
			[array]$Printer
			[array]$Storage
			[string]$Windows_ProductKey
			[string]$CPUcount
			[array]$CPUs
			[array]$NetworkInterfaces
			[array]$FileSystemsLink
			[string]$VM_Host
			[string]$VM_name
			[string]$ObjectHash
		}
	}
	
	process {

		$HostInfo = [HostInfo]::New()

		# WMI calls (once only). Maybe this could be moved to it's own function..
		$Win32_OperatingSystem = Get-CimInstance Win32_OperatingSystem
		$Win32_ComputerSystem = Get-CimInstance Win32_ComputerSystem
		$Win32_TimeZone = Get-CimInstance Win32_TimeZone
		
		$SoftwareLicensingService = Get-CimInstance SoftwareLicensingService
		$Win32_PhysicalMemory = Get-CimInstance Win32_PhysicalMemory
		$Win32_ComputerSystemProduct = Get-CimInstance Win32_ComputerSystemProduct
		$win32_bios = Get-CimInstance win32_bios

		# Build HostInfo Object
		$Hostinfo.Hostname = $env:computername
		$HostInfo.FQDN = [System.Net.Dns]::GetHostByName(($env:computerName)).Hostname
		$HostInfo.Model = $Win32_ComputerSystem.Model
		$HostInfo.Vendor = $win32_bios.Manufacturer
		$HostInfo.SerialNumber = $win32_bios.SerialNumber
		$HostInfo.LastBootUpTime = $Win32_OperatingSystem.LastBootUpTime
		$systemUpTime = (Get-Date) - (Get-Date $Win32_OperatingSystem.LastBootUpTime) 
		$HostInfo.SystemUpTime = "$($systemUpTime.Days):$($systemUpTime.Hours):$($systemUpTime.Minutes):$($systemUpTime.Seconds)"
		$Hostinfo.SAMAccountName = $Win32_ComputerSystem.username
		$HostInfo.LastLoggedOnUserSID = (Get-ItemProperty -Path 'HKLM:\Software\Microsoft\windows\currentVersion\Authentication\LogonUI' -Name LastLoggedOnUserSid | Select-Object -ExpandProperty LastLoggedOnUserSid)
		$Hostinfo.domain = $Win32_ComputerSystem.domain
		$Hostinfo.Timezone = $Win32_TimeZone.StandardName
		$HostInfo.RamGB = "$(($Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb) GB"
		$HostInfo.UUID = $Win32_ComputerSystemProduct.UUID
		#Links
		
		$HostInfo.CPUs = Get-HostCPUs
		$HostInfo.CPUcount = $($HostInfo.CPUs).count
		$HostInfo.Storage = Get-HostStorageDevices
		$Hostinfo.Hypervisor = Get-Hypervisor
		$Hostinfo.NetworkInterfaces = Get-HostNetworkInterface
		$Hostinfo.Windows_OS = Get-HostOS
		# Embedded Windows Key (uefi) may not match one in windows. 
		$Hostinfo.Windows_ProductKey = $SoftwareLicensingService.OA3xOriginalProductKey
		
		# Only run if workstation (1 = Workstation, 2 = Domain Controller, 3 = Server)
		if ($Win32_OperatingSystem.ProductType -eq 1) {
			$Hostinfo.Printer = Get-HostPrinter
			$HostInfo.ExternalMonitors = Get-HostExternalMonitors
		}

		$HostInfo.ObjectHash = Get-ObjectHash -inputObject $HostInfo
	}
	
	end {
		$HostInfo | ConvertTo-Json -Depth 20
	}
}

# Suggest writing to JSON and using another script to use main module and push in to jira. 
