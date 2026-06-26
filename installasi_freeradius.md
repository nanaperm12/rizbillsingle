# Dokumentasi Instalasi FreeRADIUS + WireGuard + MySQL

## Topologi

```text
Mikrotik / NAS
       ↓
WireGuard Tunnel
       ↓
VPS Ubuntu
 ├── FreeRADIUS
 ├── MariaDB/MySQL
 └── Billing/API
```

---

# 1. Update VPS

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y nano curl wget unzip
```

---

# 2. Install WireGuard

```bash
sudo apt install -y wireguard
```

---

# 3. Generate Key WireGuard

```bash
cd ~

wg genkey | tee server_private.key | wg pubkey > server_public.key
```

Lihat key:

```bash
cat server_private.key
cat server_public.key
```

---

# 4. Konfigurasi WireGuard VPS

Buat file:

```bash
sudo nano /etc/wireguard/wg0.conf
```

Isi:

```ini
[Interface]
Address = 10.10.10.1/24
ListenPort = 51820
PrivateKey = ISI_PRIVATE_KEY_VPS

PostUp = iptables -A INPUT -p udp --dport 51820 -j ACCEPT
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT
PostUp = iptables -A FORWARD -o wg0 -j ACCEPT

PostDown = iptables -D INPUT -p udp --dport 51820 -j ACCEPT
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT
PostDown = iptables -D FORWARD -o wg0 -j ACCEPT
```

---

# 5. Enable IP Forward

```bash
sudo nano /etc/sysctl.conf
```

Aktifkan:

```conf
net.ipv4.ip_forward=1
```

Apply:

```bash
sudo sysctl -p
```

---

# 6. Jalankan WireGuard

```bash
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0
sudo wg
```

---

# 7. Firewall WireGuard

```bash
sudo ufw allow 51820/udp
```

---

# 8. Konfigurasi Mikrotik WireGuard

## Buat Interface

```bash
/interface wireguard add \
name=wg-radius \
listen-port=13231
```

## Tambahkan IP

```bash
/ip address add \
address=10.10.10.2/24 \
interface=wg-radius
```

## Lihat Public Key

```bash
/interface wireguard print detail
```

## Tambahkan Peer VPS

```bash
/interface wireguard peers add \
interface=wg-radius \
public-key="SERVER_PUBLIC_KEY" \
endpoint-address=IP_PUBLIC_VPS \
endpoint-port=51820 \
allowed-address=10.10.10.0/24 \
persistent-keepalive=25
```

---

# 9. Tambahkan Peer Mikrotik di VPS

Edit:

```bash
sudo nano /etc/wireguard/wg0.conf
```

Tambahkan:

```ini
[Peer]
PublicKey = PUBLIC_KEY_MIKROTIK
AllowedIPs = 10.10.10.2/32
```

Restart:

```bash
sudo systemctl restart wg-quick@wg0
```

---

# 10. Test Tunnel

## VPS → Mikrotik

```bash
ping 10.10.10.2
```

## Mikrotik → VPS

```bash
ping 10.10.10.1
```

---

# 11. Install FreeRADIUS

```bash
sudo apt install -y freeradius freeradius-utils
```

Enable service:

```bash
sudo systemctl enable freeradius
sudo systemctl start freeradius
```

---

# 12. Install MariaDB

```bash
sudo apt install -y mariadb-server
```

Enable:

```bash
sudo systemctl enable mariadb
sudo systemctl start mariadb
```

---

# 13. Secure MariaDB

```bash
sudo mysql_secure_installation
```

---

# 14. Buat Database Radius

```bash
sudo mysql
```

```sql
CREATE DATABASE radius;

CREATE USER 'radius'@'localhost'
IDENTIFIED BY 'radius123';

GRANT ALL PRIVILEGES ON radius.* TO 'radius'@'localhost';

FLUSH PRIVILEGES;

EXIT;
```

---

# 15. Install SQL Module FreeRADIUS

```bash
sudo apt install -y freeradius-mysql
```

---

# 16. Import Schema Radius

```bash
sudo mysql -u root -p radius < \
/etc/freeradius/3.0/mods-config/sql/main/mysql/schema.sql
```

---

# 17. Konfigurasi SQL FreeRADIUS

Edit:

```bash
sudo nano /etc/freeradius/3.0/mods-available/sql
```

Ubah:

```conf
driver = "rlm_sql_mysql"

dialect = "mysql"

server = "localhost"
port = 3306
login = "radius"
password = "radius123"

radius_db = "radius"
```

---

# 18. Enable SQL Module

```bash
sudo ln -s \
/etc/freeradius/3.0/mods-available/sql \
/etc/freeradius/3.0/mods-enabled/
```

---

# 19. Aktifkan SQL di Site Default

Edit:

```bash
sudo nano /etc/freeradius/3.0/sites-enabled/default
```

Tambahkan `sql` pada:

```conf
authorize {
```

dan:

```conf
accounting {
```

---

# 20. Tambahkan NAS Mikrotik

Edit:

```bash
sudo nano /etc/freeradius/3.0/clients.conf
```

Isi:

```conf
client mikrotik {
    ipaddr = 10.10.10.2
    secret = radiusku123
    shortname = mikrotik
}
```

---

# 21. Tambahkan User Radius

Login database:

```bash
sudo mysql -u root -p
```

Gunakan database:

```sql
USE radius;
```

Tambah user:

```sql
INSERT INTO radcheck
(username, attribute, op, value)
VALUES
('nana', 'Cleartext-Password', ':=', '123456');
```

---

# 22. Gunakan Profile Hotspot Mikrotik

```sql
INSERT INTO radreply
(username, attribute, op, value)
VALUES
('nana', 'Mikrotik-Group', ':=', 'paket-10m');
```

---

# 23. Restart FreeRADIUS

```bash
sudo systemctl restart freeradius
```

---

# 24. Konfigurasi Radius di Mikrotik

```bash
/radius add \
service=hotspot \
address=10.10.10.1 \
secret=radiusku123 \
authentication-port=1812 \
accounting-port=1813
```

Enable hotspot radius:

```bash
/ip hotspot profile set [find] use-radius=yes
```

---

# 25. Testing Radius

Debug:

```bash
sudo systemctl stop freeradius
sudo freeradius -X
```

Test:

```bash
radtest nana 123456 localhost 0 testing123
```

Jika berhasil:

```text
Access-Accept
```

---

# 26. Hardening VPS

Tutup public radius:

```bash
sudo ufw deny 1812/udp
sudo ufw deny 1813/udp
```

Allow hanya WireGuard:

```bash
sudo ufw allow in on wg0 to any port 1812 proto udp
sudo ufw allow in on wg0 to any port 1813 proto udp
```

---

# 27. Monitoring

## Radius Log

```bash
sudo journalctl -u freeradius -f
```

## WireGuard Status

```bash
sudo wg
```

## Online User

```sql
SELECT username, framedipaddress, acctstarttime
FROM radacct
WHERE acctstoptime IS NULL;
```

---

# 28. Struktur Database Penting

| Tabel | Fungsi |
|---|---|
| radcheck | username/password |
| radreply | profile/rate limit |
| radacct | accounting |
| radpostauth | log login |
| nas | daftar NAS |

---

# 29. Arsitektur Final

```text
Customer
    ↓
Mikrotik NAS
    ↓
WireGuard Tunnel
    ↓
FreeRADIUS VPS
    ↓
MariaDB
    ↓
Billing Web/API
```
