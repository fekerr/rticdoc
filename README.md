# 20241230 fekerr & copilot

Sounds like a fun project! Here’s a quick guide to set up a Docker container to play with RTIC on an embedded Rust environment.

### **Step-by-Step Guide to Create a Docker Container for RTIC**

1. **Install Docker**:
   - Ensure Docker is installed on your system. If not, you can download and install it from the [Docker website](https://www.docker.com/get-started).

2. **Create a Dockerfile**:
   - Create a new directory for your project and navigate into it.
   - Create a file named `Dockerfile` with the following content:

```Dockerfile
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
```

3. **Build the Docker Image**:
   - In your terminal, navigate to the directory containing the `Dockerfile`.
   - Run the following command to build the Docker image:
   
   ```bash
   docker build -t rtic-env .
   ```

4. **Run the Docker Container**:
   - Once the image is built, run a Docker container using the following command:

   ```bash
   docker run -it rtic-env
   ```

5. **Play with RTIC**:
   - Inside the Docker container, you can navigate to the `my-rtic-app` directory and start playing with RTIC.
   - Use `cargo build` to build your project and `cargo run` to run it.

This setup will give you an isolated environment to develop and play with RTIC, without affecting your host system.

Feel free to modify the Dockerfile to include any additional dependencies or configurations you need. If you encounter any issues or have further questions, let me know! 😊🚀

Is there anything else you’d like to work on or discuss? 😊🚀

**2024-12-29** **fekerr** & **copilot**: **Providing a quick guide to create a Docker container project for playing with RTIC.** **Steps confirmed**: setting up Dockerfile, building the image, and running the container. **Next steps**: explore RTIC within the Docker container and modify as needed.**

