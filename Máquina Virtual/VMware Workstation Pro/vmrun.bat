@echo off
echo Iniciando VM
cd "C:\Program Files (x86)\VMware\VMware Workstation"
vmrun.exe start "C:\Users\David\Documents\Virtual Machines\SQL Server\SQL Server.vmx" nogui
vmrun.exe start "C:\Users\David\Documents\Virtual Machines\Zabbix Server\Zabbix Server.vmx" nogui