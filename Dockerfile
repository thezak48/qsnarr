FROM cr.hotio.dev/hotio/base@sha256:4378603cfbdff1f02a33caee3e72e8e43d6236f4ac8461997f5ce142c59b3e4a

EXPOSE 8989

RUN apk add --no-cache libintl sqlite-libs icu-libs

ARG VERSION
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://sonarr.servarr.com/v1/update/widowmaker/updatefile?version=${VERSION}&os=linuxmusl&runtime=netcore&arch=x64" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/Sonarr.Update" && \
    echo -e "PackageVersion=Robin PG Sonarr Plox \nPackageAuthor=[thezak48]\nUpdateMethod=Docker\nBranch=widowmaker" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
