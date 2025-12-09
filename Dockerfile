FROM hugomods/hugo:base-0.151.0 AS builder

COPY . /src
RUN hugo --minify

FROM nginx:alpine
COPY --from=builder /src/public /usr/share/nginx/html
EXPOSE 80