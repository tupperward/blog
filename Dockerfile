FROM klakegg/hugo:ext-alpine

COPY . /src

EXPOSE 1313

ENTRYPOINT [ "hugo", "server", "-e", "production" ]