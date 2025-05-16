# 🔨 Build stage
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy project files
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .

# Build the React app
RUN yarn build

# 🚀 Production stage
FROM nginx:stable-alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy built React app from previous stage
COPY --from=builder /app/build /usr/share/nginx/html

# Copy custom nginx config (optional)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
