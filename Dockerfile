# Use the official Rust image as a base
FROM rust:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    gdb-multiarch \
    llvm \
    libclang-dev \
    libstdc++-10-dev \
    binutils-arm-none-eabi \
    gcc-arm-none-eabi \
    gdb-arm-none-eabi \
    openocd

# Create a directory for the project
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install cargo-generate and cargo-binutils
RUN cargo install cargo-generate cargo-binutils

# Setup cargo binutils
RUN rustup component add llvm-tools-preview

# Setup default toolchain
RUN rustup default stable

# Create a new RTIC project
RUN cargo generate --git https://github.com/rtic-rs/app-template.git --name my-rtic-app

# Set the working directory to the newly created RTIC app
WORKDIR /usr/src/app/my-rtic-app

# Build the RTIC app
RUN cargo build

CMD ["bash"]

