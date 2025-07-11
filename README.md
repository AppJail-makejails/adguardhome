# adguardhome

AdGuard Home is a network-wide software for blocking ads &amp; tracking. After you set it up, it'll cover ALL your home devices, and you don't need any client-side software for that. With the rise of Internet-Of-Things and connected devices, it becomes more and more important to be able to control your whole network.

wikipedia.org/wiki/AdGuard

![adguard logo](https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/AdGuard.svg/220px-AdGuard.svg.png)

## How to use this Makejail

```
INCLUDE options/network.makejail
INCLUDE gh+AppJail-makejails/adguardhome

OPTION expose=80
OPTION expose=53 proto:udp
# See below.
#OPTION expose=3000
```

Where `options/network.makejail` are the options that suit your environment, for example:

```
ARG network
ARG interface=adguard

OPTION virtualnet=${network}:${interface} default
OPTION nat
```

Open a shell and run `appjail makejail`:

```sh
appjail makejail -j adguard -- --network dns
```

The main `Makejail` will expose `tcp/80` and `udp/53`, but not `tcp/3000` unless you uncomment it. I recommend that you do not uncomment this line unless you are sure you can configure AdGuard remotely without exposing a security problem.

Another way to configure AdGuard more securely is to use SSH tunneling.

```sh
ssh -L 3000:$jip:3000 $user@$ip
```

Substitute `$jip` for the IP address of the jail, `$user` for the username to access `$ip` and `$ip` for the hostname or IP address of the server.

Of course, if you can access the PC/Server where AdGuard will be jailed and you can use a web browser, it is not necessary to expose that port or use SSH tunneling, just use the jail IP address and port 3000.

### Arguments

* `adguard_tag` (default: `13.5`): see [#tags](#tags).
* `adguard_ajspec` (default: `gh+AppJail-makejails/adguardhome`): Entry point where the `appjail-ajspec(5)` file is located.

### Volumes

| Name             | Owner | Group | Perm | Type | Mountpoint                     |
| ---------------- | ----- | ----- | ---- | ---- | ------------------------------ |
| adguardhome-conf |   -   |   -   | 644  |  -   | usr/local/etc/AdGuardHome.yaml |
| adguardhome-db   |   -   |   -   | 750  |  -   | /var/db/adguardhome            |

## Tags

| Tag        | Arch    | Version        | Type   |
| ---------- | ------- | -------------- | ------ |
| `13.5`     | `amd64` | `13.5-RELEASE` | `thin` |
| `14.3`     | `amd64` | `14.3-RELEASE` | `thin` |
