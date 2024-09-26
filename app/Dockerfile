FROM rust:1.81 AS builder

USER root
RUN apt-get update && apt-get install -y musl-tools

RUN rustup target add x86_64-unknown-linux-musl && \
    cd /usr/src && \
    cargo new aws-tech-test
WORKDIR /usr/src/aws-tech-test
COPY Cargo.toml ./
RUN cargo fetch

COPY src ./src
RUN cargo build --target x86_64-unknown-linux-musl --release

FROM scratch
ENV ROCKET_ADDRESS=0.0.0.0
COPY --from=builder /usr/src/aws-tech-test/target/x86_64-unknown-linux-musl/release/aws-tech-test /aws-tech-test
USER 1000
ENTRYPOINT ["/aws-tech-test"]