FROM golang:1.21

# Install development tools with compatible versions
# Air for hot reloading
RUN go install github.com/cosmtrek/air@v1.44.0

# Swag for Swagger documentation
RUN go install github.com/swaggo/swag/cmd/swag@v1.16.2

# Delve for debugging
RUN go install github.com/go-delve/delve/cmd/dlv@v1.21.0

# Gopls for language server - use a version compatible with Go 1.21
RUN go install golang.org/x/tools/gopls@v0.14.2

# GolangCI-Lint for linting
RUN go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.54.2

WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy air configuration
COPY .air.toml ./

# Expose ports
EXPOSE 8080

# Command to start air for hot reloading
CMD ["air", "-c", ".air.toml"]
