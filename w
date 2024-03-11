#!/bin/bash

# Membaca file .bot.db
# Membaca token dan chat_id dari file .bot.db
read token chat_ids <<< $(grep '#bot#' bot/.bot.db | awk '{print $2, $3, $4}')

# Menyimpan chat_ids ke dalam array
IFS=' ' read -r -a chat_id_array <<< "$chat_ids"

# Mengirim pesan ke semua chat_ids
for chat_id in "${chat_id_array[@]}"
do

python3 - <<END
import requests
TOKEN = '$token'
chat_id = '$chat_id'

# Fungsi untuk mengirim pesan ke bot Telegram
def kirim_pesan(pesan):
    url = f'https://api.telegram.org/bot{TOKEN}/sendMessage'
    params = {
        'chat_id': chat_id,
        'text': pesan,
        'parse_mode': 'HTML',  # Menggunakan HTML untuk formatting teks
        'reply_markup': {
            'inline_keyboard': [
                [
                    {'text': 'ALAWI', 'url': 'https://t.me/alawivpn'},
                    {'text': 'MUSLIM', 'url': 'https://t.me/muslimvpn'}
                ]
            ]
        }
    }
    response = requests.post(url, json=params)
    return response.json()

# Contoh penggunaan
pesan = '''
◇━━━━━━━━━━━━━━━━━◇
<code>Trial Premium Vless Account</code>
◇━━━━━━━━━━━━━━━━━◇
<code>User         : Trial-80X7
Domain       : id-ws.vpssantri.my.id
Login Limit  : 1 IP
ISP          : PT Wijaya Trimitra Indonesia
CITY         : Sukabumi
Port TLS     : 443
Port NTLS    : 80, 8080
Port GRPC    : 443
UUID         : 074938b7-e50d-4c30-9dc4-cb0c4a1efe43
AlterId      : 0
Security     : auto
Network      : WS or gRPC
Path vless   : /vless
ServiceName  : /vless-grpc</code>
◇━━━━━━━━━━━━━━━━━◇
<b>Link TLS     :</b>
<code>vless://074938b7-e50d-4c30-9dc4-cb0c4a1efe43@id-ws.vpssantri.my.id:443?path=/vless&security=tls&encryption=none&host=id-ws.vpssantri.my.id&type=ws&sni=id-ws.vpssantri.my.id#Trial-80X7</code>
◇━━━━━━━━━━━━━━━━━◇
<b>Link NTLS    :</b>
<code>vless://074938b7-e50d-4c30-9dc4-cb0c4a1efe43@id-ws.vpssantri.my.id:80?path=/vless&security=none&encryption=none&host=id-ws.vpssantri.my.id&type=ws#Trial-80X7</code>
◇━━━━━━━━━━━━━━━━━◇
<b>Link GRPC    :</b>
<code>vless://074938b7-e50d-4c30-9dc4-cb0c4a1efe43@id-ws.vpssantri.my.id:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=id-ws.vpssantri.my.id#Trial-80X7</code>
◇━━━━━━━━━━━━━━━━━◇
<b>Format OpenClash :</b>
http://id-ws.vpssantri.my.id:89/vless-Trial-80X7.txt
◇━━━━━━━━━━━━━━━━━◇
<code>Expired Until    : 30 Minutes</code>
◇━━━━━━━━━━━━━━━━━◇
<b>ID-WIJAYA-PREMIUM</b>
◇━━━━━━━━━━━━━━━━━◇
'''
kirim_pesan(pesan)
END
done
