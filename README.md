# Docker image for wifi-pumpkin

A Docker image to run [WiFi-Pumpkin](https://github.com/P0cL4bs/WiFi-Pumpkin/).

## Usage

- Clone the repo and build the docker image:

```bash
git clone https://github.com/hadim/docker-wifi-pumpkin.git
cd docker-wifi-pumpkin/

docker-compose build
```

- Check the name of the Wifi interface you want to use:

```bash
sudo airmon-ng

PHY	Interface	Driver		Chipset
phy0	wlp3s0		iwlwifi		Intel Corporation Wireless 8260 (rev 3a)
```

- Enable monitor mode on the interface (`wlp3s0` here):

```bash
sudo airmon-ng start wlp3s0
```

**Warning:** if you only have one Wifi card, you internet connection will be lost. To enable it again you need to disable monitor mode with `sudo airmon-ng stop wlp3s0mon`.


- Start Pumpkin with:

```bash
docker-compose up pumkin
```

## License

[MIT](./LICENSE).

## Authors

- Hadrien Mary
