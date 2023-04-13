FROM rust:latest as build

RUN cargo new --bin rust-tutorial
WORKDIR /rust-tutorial

COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

RUN cargo build --release
RUN rm src/*.rs

COPY ./src ./src

RUN rm ./target/release/deps/rust_tutorial*
RUN cargo build --release

FROM debian:buster-slim

COPY --from=build /rust-tutorial/target/release/rust-tutorial .

CMD ["./rust-tutorial"]