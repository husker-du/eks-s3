# Stage 1: Build React app
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy app files
COPY package.json yarn.lock ./
COPY public ./public
COPY src ./src

# Install dependencies
RUN yarn install --frozen-lockfile

# Build the app
RUN yarn build

# Stage 2: Serve with Nginx
FROM nginx:stable-alpine

# Copy custom nginx config (optional, see below)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build output to nginx directory
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
