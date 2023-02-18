

#Criando serviço com systemd

sudo touch /etc/systemd/system/dnat.service
sudo nano /etc/systemd/system/dnat.service

---------------------------------
[Unit]
Description=Start DNATs with VPN

[Service]
ExecStart=/home/david/runnable/automate-vpn-DNAT.sh
Type=oneshot
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
---------------------------------

# Dando permissões para script e serviço do systemd
sudo chmod 744 /home/david/runnable/automate-vpn-DNAT.sh
sudo chmod 664 /etc/systemd/system/dnat.service

# Habilitando serviço dnat
sudo systemctl daemon-reload
sudo systemctl enable dnat.service
