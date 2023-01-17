# better-cloudflare-ip

Find the preferred Cloudflare Anycast IP for your current network environment

The old version will be out of service soon, and subsequent versions will not be updated if there are no obvious bugs!

## Declaration of use

This project focuses on the study of the relationship between packet loss rate and network speed in anycast technology, for learning purposes only

The prohibited scope guidelines are as follows

a) Relevant agencies warn that the web pages are threatening, and websites with illegal information prompts.

b) Hospital-type websites (hospitals for abortion, skin diseases, venereal diseases, etc.), websites that have not obtained the qualification of the Ministry of Health.

c) The main content of the website contains pornography (video dating, one-night stand dating), illegality (false certificates, selling imitation guns), feudal superstition, private game servers, game cheats, online earning, gender, beauty stickers and animation stickers (too large) , Gambling (including selling gambling tools.), Gambling and other content.

d) There are malicious rogue advertisements on the website (there are links to illegal content videos and illegal web page content links).

e) The website has any acts of destroying or attempting to destroy network security, such as viruses, Trojan horses, malicious codes, phishing, etc., attempting to maliciously scan the website, network-related software and hardware, illegally intrude into the system, and obtain data illegally.

f) Websites with copyright risks in their website content (video, novel, music and other websites).

g) The website contains sales of medicines and health care products, but has not obtained qualifications, or seriously exaggerates the facts of drug efficacy.

h) The main business of the website is to provide illegal websites with services such as payment, trading platforms, guarantees, and acting as an agent for foreign financial management (stock trading, spot trading, and gold speculation).

i) There are a large number of websites with content that affects social harmony and stability (suspicious of attacking the country, attacking leaders, attacking the people, websites with inciting speech).

j) The content of the website contains other content that is not permitted by relevant national laws and regulations.

k) The content of the website contains VPN, network proxy and other content.

l) Websites that interfere with the normal operation of all Cloudflare products through technical or non-technical means.

m) The content of the website is a website that publishes false and untrue news, or violates the legitimate rights and interests of others.

n) Obtaining the content of the website requires login and other methods, and it is impossible to directly view the website that causes the content to be unaudited.

o) Websites that provide download services for movies, software and applications.


## User Data Security Statement

This version does not require users to upload any data to the server, the server only provides IP address pool maintenance and distribution!

## User defined data

Users can customize the IP address segment of ips-v4.txt and ips-v6.txt, if using data update will overwrite the local custom data

The content format of the custom ips-v4.txt is x.x.x.x or x.x.x.x/x CIDR notation, which is extracted by default. The first three digits

The content format of the custom ips-v6.txt is x:x:x:x:x:x:x:x or x:x:x:x:x:x:x:x/x, which is extracted by default : the first three digits

More custom gameplay is waiting for users to discover by themselves

## Windows batch version

Please download the Release version to use, do not use Git Clone to download (garbled characters will appear)

Windows 7 users recommend using the ANSI encoded version

Users of Windows 8 and above versions are recommended to use the UTF-8 encoded version

Note: The ANSI encoding version can be used on all Windows platforms, and the BUG of some Windows systems will cause the console to output garbled characters

Click to download [Windows version] (https://github.com/badafans/better-cloudflare-ip/releases/latest/download/batch.zip)

## Linux version

Completely copy and paste the link below to the console and press Enter. For subsequent operations, just enter ./cf.sh and press Enter.

Currently tested Termux, OpenWrt, Ubuntu, Debian, CentOS, MacOS, Raspbian, Armbian, iSH

``` bash
curl https://raw.githubusercontent.com/behnam86/better-cloudflare-ip/master/shell/cf.sh -o cf.sh && chmod +x cf.sh && ./cf.sh
```

## quote declaration

For Cloudflare ASN https://bgp.he.net/AS13335 , Cloudflare IP Ranges from https://www.cloudflare.com/zh-cn/ips/
