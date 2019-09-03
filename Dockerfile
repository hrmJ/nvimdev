FROM ubuntu:18.04

ENV DOCKER_USER developer

# Create user with passwordless sudo. This is only acceptable as it is a
# private development environment not exposed to the outside world. Do 
# NOT do this on your host machine or otherwise.
RUN apt-get update && \
    apt-get install -y sudo && \
    adduser --disabled-password --gecos '' "$DOCKER_USER" && \
    adduser "$DOCKER_USER" sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    touch /home/$DOCKER_USER/.sudo_as_admin_successful && \
    rm -rf /var/lib/apt/lists/*

USER "$DOCKER_USER"

WORKDIR "/home/$DOCKER_USER"



RUN yes | sudo unminimize && \
    sudo apt-get install -y man-db bash-completion build-essential curl openssh-client  software-properties-common && \
    sudo rm -rf /var/lib/apt/lists/*

RUN sudo add-apt-repository ppa:neovim-ppa/unstable && \
    sudo apt-get update && \
    sudo apt-get install -y neovim  && \
    sudo rm -rf /var/lib/apt/lists/*

RUN sudo apt-get update && \
    sudo apt-get install -y tmux && \
    sudo rm -rf /var/lib/apt/lists/*

# install NODEJS

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
ENV NVM_DIR /home/$DOCKER_USER/.nvm

RUN . "$NVM_DIR/nvm.sh" && \
    nvm install --lts && \
    nvm alias default stable

## install yarn

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    sudo apt-get update && sudo apt-get install --no-install-recommends yarn


# setup neovim + plugins

COPY nvim/ "/home/$DOCKER_USER/.config/nvim"

RUN sudo apt-get update && \
    sudo apt-get install -y git && \
    sudo rm -rf /var/lib/apt/lists/*


RUN git clone https://github.com/VundleVim/Vundle.vim.git "/home/$DOCKER_USER/.vim/bundle/Vundle.vim"

RUN sudo chown -R "$DOCKER_USER" "/home/$DOCKER_USER/"

RUN nvim +PluginInstall +qall 

RUN sudo apt-get update && \
    sudo apt-get install -y python3-pip && \
    sudo rm -rf /var/lib/apt/lists/*

RUN pip3 install neovim
RUN nvim -c ":call coc#util#install()" +qall

# RUN nvim -c 'CocInstall -sync coc-json coc-html coc-tsserver'
RUN echo "set -o vi" >> "/home/$DOCKER_USER/.bashrc"

COPY scripts "/home/$DOCKER_USER/scripts"

# Install ripgrep
RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
RUN sudo dpkg -i ripgrep_11.0.2_amd64.deb
# RUN fzf's installation script
RUN sudo bash scripts/fzf_install.sh 
RUN curl -LO https://github.com/sharkdp/fd/releases/download/v7.3.0/fd-musl_7.3.0_amd64.deb
RUN sudo dpkg -i fd-musl_7.3.0_amd64.deb
RUN export FZF_DEFAULT_COMMAND="fd . $HOME"
RUN export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
RUN export FZF_ALT_C_COMMAND="fd -t d . $HOME"

#RUN ~/.vim/bundle/fzf.vim/install --bin
#RUN git clone https://github.com/junegunn/fzf.vim ~/.vim/bundle/fzf.vim


# ADDING R-related stufff

# TODO ENV node version!! /for coc-tsserver
