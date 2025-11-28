# Build stage
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY go.mod .
COPY main.go .
COPY tracing.go .
COPY user.go .
RUN go mod tidy
RUN go build -o auth-api .

# Runtime stage
FROM alpine:latest

WORKDIR /app

# Copy the binary from builder
COPY --from=builder /app/auth-api .

# Expose port
EXPOSE 8081

# Run the application
CMD ["./auth-api"]
