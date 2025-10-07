FROM hugomods/hugo:base-0.151.0

COPY . /src

EXPOSE 1313

ENTRYPOINT [ "hugo", "server", "-e", "production", "--bind", "0.0.0.0", "--port", "1313" ]