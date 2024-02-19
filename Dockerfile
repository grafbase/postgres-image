FROM postgres:16
WORKDIR "/root"
RUN apt-get update -y && \
  apt-get install -y wget curl && \
  wget https://github.com/pksunkara/pgx_ulid/releases/download/v0.1.3/pgx_ulid-v0.1.3-pg15-amd64-linux-gnu.deb && \
  dpkg -i pgx_ulid-v0.1.3-pg15-amd64-linux-gnu.deb && \
  rm -rf pgx_ulid-v0.1.3-pg15-amd64-linux-gnu.deb && \
  curl -LO "https://github.com/fboulnois/pg_uuidv7/releases/download/v1.4.0/{pg_uuidv7.tar.gz,SHA256SUMS}" && \
  tar xf pg_uuidv7.tar.gz && \
  sha256sum -c SHA256SUMS && \
  PG_MAJOR=$(pg_config --version | sed 's/^.* \([0-9]\{1,\}\).*$/\1/') && \
  mv "$PG_MAJOR/pg_uuidv7.so" "$(pg_config --pkglibdir)" && \
  mv pg_uuidv7--1.4.sql pg_uuidv7.control "$(pg_config --sharedir)/extension" && \
  apt-get purge -y wget curl && \
  apt-get autoremove -y
EXPOSE 5432
CMD ["postgres"]
