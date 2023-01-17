FROM botwayorg/botway:latest

### install packages ###
ENV PKGS "zip unzip git curl npm py3-pip openssl openssl-dev build-base autoconf automake libtool gcc-doc python3-dev neofetch make wget gcc ca-certificates llvm nano vim ruby-full ruby-dev libffi-dev libgcc libssl1.1 zlib"

RUN apk upgrade && \
    apk add --update $PKGS

### nodejs package managers ###
RUN npm i -g npm@latest yarn@latest pnpm@latest

### build ###
WORKDIR /app

RUN wget https://cdn-botway.deno.dev/app/bwui-latest.zip

RUN unzip bwui-latest.zip

RUN pnpm i

ENV PORT 3000

EXPOSE 3000

ENTRYPOINT [ "pnpm", "start" ]
