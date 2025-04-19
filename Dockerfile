FROM ubuntu:20.04

ARG ROOT_PASSWORD=password
ARG USER_PASSWORD=user1234
ARG DEBIAN_FRONTEND=noninteractive

ENV LANG C.UTF-8

# Install software packages inside the container
RUN useradd -m -d  /home/user -s /bin/bash user \
    && apt-get update  \
    && apt-get -y install  \
      gcc \
      python3 python3-pip python3-dev git libffi-dev build-essential\
      vim \
      vim-gtk3 \
      sudo \
      zsh \
      gdb \
      gcc-multilib \
   && apt-get clean \
   && echo "user ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/user \
   && echo "root:${ROOT_PASSWORD}" | chpasswd \
   && echo "user:${USER_PASSWORD}" | chpasswd

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade pwntools
RUN sudo git clone https://github.com/longld/peda.git /home/user/peda
RUN sudo echo "source /home/user/peda/peda.py" >> /home/user/.gdbinit

USER user
COPY file/ /home/user/
WORKDIR /home/user

RUN sudo chmod 777 /home/user/*
RUN sudo dpkg --add-architecture i386

WORKDIR /home/user/1.bof
RUN gcc -fno-stack-protector -m32 -no-pie -g -o stack stack.c \
   && sudo chown root:user stack && sudo chmod 4755 stack && sudo chmod 777 exploit.py

WORKDIR /home/user/2.shellcode
RUN gcc -z execstack -fno-stack-protector -m32 -no-pie -g -o stack stack.c \
   && sudo chown root:user stack && sudo chmod 4755 stack && sudo chmod 777 exploit.py

WORKDIR /home/user/3.R2L
RUN gcc -mpreferred-stack-boundary=2 -z norelro -no-pie -fno-pic -g -fcf-protection=none -fno-stack-protector -m32 -o retlib retlib.c \
    && sudo chown root:user retlib \
    && sudo chmod 4755 retlib && sudo chmod 777 exploit.py \
    && sudo chmod +x disable_aslr.sh

WORKDIR /home/user
RUN sudo chmod 755 /home/user/*
RUN sudo chmod 777 /home/user/1.bof

RUN sudo sysctl -w kernel.randomize_va_space=0

ENTRYPOINT ["/home/user/3.R2L/disable_aslr.sh"]

# The command executed by the container after startup
CMD [ "/bin/bash"]
