FROM golang:alpine

### install packages ###
ENV PKGS "zip unzip git curl npm py3-pip openssl openssl-dev build-base autoconf automake libtool gcc-doc python3-dev neofetch make wget gcc ca-certificates llvm nano vim ruby-full ruby-dev libffi-dev libgcc libssl1.1 zlib"

RUN apk upgrade && \
    apk add --update $PKGS

### nodejs package managers ###
RUN npm i -g npm@latest yarn@latest pnpm@latest

ARG MONGO_URL NEXT_PUBLIC_FULL EMAIL_FROM SENDGRID_API_KEY NEXT_PUBLIC_BW_SECRET_KEY

COPY main.go .

### build ###
RUN git clone https://github.com/abdfnx/botway && \
    cd botway/app && \
    go run ../scripts/dot/main.go >> .env && \
    pnpm i && \
    pnpm build && \
    cp -rf .next package.json ../..

ENV PORT 3000

EXPOSE 3000

RUN pnpm i

ENTRYPOINT [ "pnpm", "start" ]
