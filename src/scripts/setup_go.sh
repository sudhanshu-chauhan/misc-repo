#! /bin/bash

if [ -d /usr/local/go ]
then
	echo "a go version seems to already exist on this machine!"
	echo "exiting..."
	exit 1
fi

echo "downloading go linux package..."
curl $1 -o go.tar.gz

echo "unpacking go linux package..."
sudo mv go.tar.gz /usr/local
cd /usr/local
sudo tar zxvf /usr/local/go.tar.gz
sudo rm /usr/local/go.tar.gz

if [ !-d $HOME/go ]
then
	mkdir $HOME/go
fi

echo "export GOPATH=$HOME/go" >> $HOME/.bashrc
echo "export GOROOT=/usr/local/go" >> $HOME/.bashrc
echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.bashrc

echo "reflecting the go related environment changes"
source $HOME/.bashrc
