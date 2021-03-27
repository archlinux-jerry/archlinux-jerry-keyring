V=20210327

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 jerryxiao{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/jerryxiao{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

dist:
	git archive --format=tar --prefix=jerryxiao-keyring-$(V)/ $(V) | gzip -9 > jerryxiao-keyring-$(V).tar.gz
	gpg --detach-sign --use-agent jerryxiao-keyring-$(V).tar.gz

upload:
	# scp jerryxiao-keyring-$(V).tar.gz jerryxiao-keyring-$(V).tar.gz.sig nymeria.archlinux.org:/srv/ftp/other/archlinux-keyring/

.PHONY: install uninstall dist upload
