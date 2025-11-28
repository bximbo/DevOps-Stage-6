# Build stage
FROM node:16-alpine AS builder
WORKDIR /app
# Copy package files
COPY package.json package-lock.json ./
# Install all dependencies (including dev dependencies for build)
RUN rm -f package-lock.json && npm install --legacy-peer-deps
# Copy source code
COPY . .
# Build the Vue.js application
RUN npm run build

# Stage 2: Serve with http-server
FROM node:18-alpine
WORKDIR /app
RUN npm install -g http-server
# Copy built files
COPY --from=builder /app/dist ./dist 
# Expose port
EXPOSE 8080
# Serve on port 8080
CMD ["http-server", "./dist", "-p", "8080"] 