
# Instalar hyper-v no windows:
Install-WindowsFeature -Name Hyper-V -ComputerName DESKTOP-BDHBSO9 -IncludeManagementTools -Restart
Get-WindowsFeature -ComputerName DESKTOP-BDHBSO9

# Criar switch interna:
# VMs conseguem acessar as VMs e o Host
New-VMSwitch -name "LAN" -SwitchType internal

# Criar switch externo:
New-VMSwitch -name ExternalSwitch  -NetAdapterName Ethernet -AllowManagementOS $true

# Criar switch privado:
Switch que as VMs só acessam entre elas
New-VMSwitch -name "Privado" -SwitchType private

# Criação de máquina virtual:
New-VM -Name Server1 -Generation 2 -MemoryStartupBytes 2GB -NewVHDPath "D:\Virtual Machines\Server1.vhdx" -NewVHDSizeBytes 100GB

# Setar memoria da máquina virtual:
Set-VMMemory -VMName "Server1" -StartupBytes 4096MB

# Adicionar adaptador de rede de uma máquina virtual:
Add-VMNetworkAdapter -VMName "Server1" -SwitchName "LAN"

# Remover adaptadores de rede de uma máquina virtual:
Remove todos os adpatadores de rede: Remove-VMNetworkAdapter -VMName "Server1"

# Habilitar secure boot na máquina virtual:
Set-VMFirmware -VMName "Server1" -EnableSecureBoot $off

# Setar unidade de disco na máquina virtual:
Set-VMDvdDrive -VMName Server1 -Path 'D:\ISO\Windows Server 2016 PT-BR.iso'

# Ver adaptadores de rede:
Get-NetAdapter

