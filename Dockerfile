FROM ubuntu:18.04
ENV DOCKER_USER developer

#install sudo + other utilities
RUN apt-get update && \
    apt-get install -y sudo curl gnupg  software-properties-common && \
    adduser --disabled-password --gecos '' "$DOCKER_USER" && \
    adduser "$DOCKER_USER" sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    touch /home/$DOCKER_USER/.sudo_as_admin_successful && \
    rm -rf /var/lib/apt/lists/*

#change workdir
USER "$DOCKER_USER"
WORKDIR "/home/$DOCKER_USER"

#add repositories for yarn and nvim
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    sudo add-apt-repository ppa:neovim-ppa/unstable 

# install packages from repositories
RUN yes | sudo unminimize && \
    sudo apt-get update && \
    sudo apt-get install -y neovim yarn git python3-pip xclip && \
    sudo rm -rf /var/lib/apt/lists/*
RUN pip3 install neovim

# Install ripgrep
RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
RUN sudo dpkg -i ripgrep_11.0.2_amd64.deb

# setup neovim + plugins
RUN curl  https://install-node.now.sh/lts -o node.sh 
RUN sudo bash node.sh --yes 

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

# Install coc plugins
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
#RUN nvim -c 'CocInstall -sync coc-phpls|q'

COPY launch.sh /usr/local/bin/
RUN mkdir project
RUN sudo chmod +x /usr/local/bin/launch.sh

#PHP development

RUN yarn global add prettier @prettier/plugin-php

RUN sudo apt update && sudo apt install -y php7.2 curl php-cli php-mbstring git unzip php-xml
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

COPY composer "/home/$DOCKER_USER/.composer"
RUN sudo chown -R developer:developer "/home/$DOCKER_USER/.composer"
RUN composer global require felixfbecker/language-server
RUN composer global require friendsofphp/php-cs-fixer
RUN composer global require "squizlabs/php_codesniffer=\*"
RUN sudo chmod +x /home/developer/.composer/vendor/bin/php-cs-fixer
RUN composer global run-script --working-dir="/home/$DOCKER_USER/.composer/vendor/felixfbecker/language-server" parse-stubs
RUN sudo chmod +x /home/developer/.composer/vendor/felixfbecker/language-server

RUN composer global require "phan/phan"
RUN sudo chmod +x /home/developer/.composer/vendor/bin/phan
RUN sudo apt update && sudo apt install -y php-ast
RUN sudo apt update && sudo apt install -y php7.2-dev php-pear
RUN sudo pecl install ast
RUN sudo phpenmod ast
RUN sudo npm install --global prettier @prettier/plugin-php

#COPY without_ale.vim /home/developer/.config/nvim/plugins.vim

WORKDIR "/home/$DOCKER_USER/project"
ENTRYPOINT launch.sh
