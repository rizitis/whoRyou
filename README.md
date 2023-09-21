# whoRyou
print informations about intput package if its installed

# Install
edit /etc/fstab like this:
```
tmpfs            /dev/shm         tmpfs      defaults,noexec,nodev,nosuid,seclabel 0 0size=16G 0   0
```
then command
```
mount -o remount,noexec,nodev,nosuid /dev/shm
```
```
cd /usr/local/bin
wget -O whoRyou https://raw.githubusercontent.com/rizitis/whoRyou/main/whoRyou.sh
chmod +x whoRyou
```
# HOWTO
[youtube video](https://www.youtube.com/watch?v=8Mo0jF6OE9U)
