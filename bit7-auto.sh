#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install libxcb-xinerama0 -y

cd $HOME

wget "https://dl.walletbuilders.com/download?customer=d4cd836283cc39673f6a843db5c41e3344c34d3ae13f297bfa&filename=bit7-qt-linux.tar.gz" -O bit7-qt-linux.tar.gz

mkdir $HOME/Bit7

tar -xzvf bit7-qt-linux.tar.gz --directory $HOME/Bit7

mkdir $HOME/.bit7

cat << EOF > $HOME/.bit7/bit7.conf
rpcuser=rpc_bit7
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=127.0.0.1
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node3.walletbuilders.com
EOF

cat << EOF > $HOME/Bit7/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./bit7-qt
EOF

chmod +x $HOME/Bit7/start_wallet.sh

cat << EOF > $HOME/Bit7/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
while :
do
./bit7-cli generatetoaddress 1 \$(./bit7-cli getnewaddress)
done
EOF

chmod +x $HOME/Bit7/mine.sh
    
exec $HOME/Bit7/bit7-qt &

sleep 15

exec $HOME/Bit7/bit7-cli -named createwallet wallet_name="" &
    
sleep 15

cd $HOME/Bit7/

clear

exec $HOME/Bit7/mine.sh
