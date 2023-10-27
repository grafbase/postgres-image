FROM postgres:15
WORKDIR "/root"
RUN apt-get update -y && \
  apt-get install -y wget && \
  wget https://github.com/pksunkara/pgx_ulid/releases/download/v0.1.3/pgx_ulid-v0.1.3-pg15-amd64-linux-gnu.deb && \
  dpkg -i pgx_ulid-v0.1.3-pg15-amd64-linux-gnu.deb && \
  rm -rf pgx_ulid-v0.1.3-pg15-amd64-linux-gnu.deb && \
  apt-get purge -y wget && \
  apt-get autoremove -y
EXPOSE 5432
CMD ["postgres"]
