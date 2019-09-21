FROM ubuntu:18.04
ENV DOCKER_USER developer

RUN apt-get update && \
    apt-get install -y sudo curl gnupg  software-properties-common && \
    adduser --disabled-password --gecos '' "$DOCKER_USER" && \
    adduser "$DOCKER_USER" sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    touch /home/$DOCKER_USER/.sudo_as_admin_successful && \
    rm -rf /var/lib/apt/lists/*

USER "$DOCKER_USER"
WORKDIR "/home/$DOCKER_USER"

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    sudo add-apt-repository ppa:neovim-ppa/unstable 

RUN yes | sudo unminimize && \
    sudo apt-get update && \
    sudo apt-get install -y neovim yarn git python3-pip xclip && \
    sudo rm -rf /var/lib/apt/lists/*
RUN pip3 install neovim

# Install ripgrep
RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
RUN sudo dpkg -i ripgrep_11.0.2_amd64.deb

# setup neovim + plugins
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
COPY nvim/ "/home/$DOCKER_USER/.config/nvim"
RUN sudo chown -R "$DOCKER_USER" "/home/$DOCKER_USER/"
RUN nvim +PlugInstall +qall 
RUN nvim -c ":call coc#util#install()" +qall

# Set the locale
RUN sudo sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sudo locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     

RUN nvim -c 'CocInstall -sync coc-css|q'
RUN nvim -c 'CocInstall -sync coc-html|q'
RUN nvim -c 'CocInstall -sync coc-json|q'
RUN nvim -c 'CocInstall -sync coc-tsserver|q'
RUN nvim -c 'CocInstall -sync coc-snippets|q'
RUN nvim -c 'CocInstall -sync coc-git|q'
RUN nvim -c 'CocInstall -sync coc-prettier|q'
RUN nvim -c 'CocInstall -sync coc-ultisnips|q'
RUN nvim -c 'CocInstall -sync coc-eslint|q'
RUN nvim -c 'CocInstall -sync https://github.com/xabikos/vscode-react|q'

