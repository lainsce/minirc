#!/bin/sh
if [ "$1" != --force ]; then
    echo "/!\ Please read the setup script and confirm that it doesn't break your system."
    exit 1
fi

[ -z "$ROOT" ] && ROOT=

echo "=> Installing /sbin/rc, /etc/rccar.conf, /etc/inittab"
install -Dm755 rc "$ROOT"/sbin/rc
if [ -f "$ROOT"/etc/rccar.conf ]; then
    echo "/!\ '$ROOT/etc/rccar.conf' already exists!"
    echo "   Moving it to '$ROOT/etc/rccar.conf.old'."
    mv "$ROOT"/etc/rccar.conf "$ROOT"/etc/rccar.conf.old
fi
install -Dm644 rccar.conf "$ROOT"/etc/rccar.conf
install -Dm644 inittab "$ROOT"/etc/inittab

echo "=> Installing default Tires (daemon files)"
for f in service/*.tire; do
	install -Dm755 $f /etc/rc-car/service/$f
done

echo "=> Installing extras"
cd extra
install -Dm755 shutdown.sh "$ROOT/sbin/shutdown"

echo "=> Linking busybox to /sbin/{init,halt,poweroff,reboot}"
for i in init halt poweroff reboot; do
    ln -sf $(which busybox) "$ROOT"/sbin/$i
done

echo ":: Append 'init=/sbin/init' to your kernel line in your bootloader"
echo "   to replace your current init with rccar"
