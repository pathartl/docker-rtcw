FROM ubuntu:16.04
MAINTAINER Pat Hartl

# Add compatiblity for x86 binaries
RUN dpkg --add-architecture i386

# Refresh package list and install necessary packages
RUN apt-get update
RUN apt-get install -y git gcc:i386 gcc-multilib:i386 g++:i386 g++-multilib:i386 mesa-common-dev:i386 libxxf86dga-dev:i386 libxxf86vm-dev nasm libx11-dev:i386 libxext-dev:i386 libxxf86vm-dev:i386 libdb-dev:i386

# Grab the RTCW source code
RUN git clone https://github.com/id-Software/RTCW-MP.git /root/rtcw-src

# Set the build script to executable
RUN chmod +x /root/rtcw-src/src/unix/cons

# Change some broken configs for the build scripts
RUN sed -i "s/LDFLAGS.*/LDFLAGS \=\> \'-lm\',/" /root/rtcw-src/src/unix/Conscript-dedicated
RUN sed -i "s/\/unix\/asmlib\.a.*/\/unix\/asmlib\.a -ldl\'/" /root/rtcw-src/src/unix/Conscript-dedicated

# Build!
WORKDIR /root/rtcw-src/src/unix/
RUN ./cons -- release
RUN mkdir ~/.wolf
RUN mv release-x86-Linux-/out/wolfded.x86 ~/.wolf
RUN mv release-x86-Linux-/game/unix/qagame.mp.i386.so ~/.wolf

# Clean
RUN rm -R /root/rtcw-src
RUN apt-get remove -y git gcc:i386 gcc-multilib:i386 g++:i386 g++-multilib:i386 mesa-common-dev:i386 libxxf86dga-dev:i386 libxxf86vm-dev nasm libx11-dev:i386 libxext-dev:i386 libxxf86vm-dev:i386 libdb-dev:i386
RUN apt-get autoremove -y

WORKDIR /root/.wolf

EXPOSE 27960/udp 27960

ENTRYPOINT ["/root/.wolf/wolfded.x86"]

CMD ["+set", "dedicated 2", "+exec", "server.cfg", "+set", "net_ip 0.0.0.0"]
