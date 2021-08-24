FROM gitpod/workspace-full

USER gitpod

RUN sudo apt-get update

# Tools
RUN sudo apt-get install inotify-tools -y

# Erlang: https://computingforgeeks.com/how-to-install-latest-erlang-on-ubuntu-linux/
RUN wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -
RUN echo "deb https://packages.erlang-solutions.com/ubuntu focal contrib" | sudo tee /etc/apt/sources.list.d/rabbitmq.list
RUN sudo DEBIAN_FRONTEND=noninteractive apt-get install erlang=1:22.2.7+dfsg-1 -y

# Elixir
RUN sudo apt-get install elixir=1.9.1.dfsg-1.3 -y

RUN sudo apt-get clean \
    && sudo rm -rf /var/cache/apt/* \
    && sudo rm -rf /var/lib/apt/lists/* \
    && sudo rm -rf /tmp/*

RUN mix local.hex --force \
    && mix local.rebar --force