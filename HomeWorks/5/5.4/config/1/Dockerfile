FROM archlinux:latest

RUN pacman -Sy --noconfirm && \
    pacman -S --noconfirm ponysay
	
ENTRYPOINT ["/usr/bin/ponysay"]
CMD ["Hey, netology"]