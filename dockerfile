# --- Etapa 1: Compilación de la app ---
FROM node:24-alpine AS builder

WORKDIR /usr/src/app

COPY package.json yarn.lock* ./
RUN yarn install --ignore-scripts

COPY . .
RUN yarn build

# --- Etapa 2: Imagen ligera de producción en puerto 5173 ---
FROM nginx:alpine AS production

# Copiar los archivos estáticos compilados
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html

# Escribir una configuración limpia de NGINX en el puerto 5173 con soporte SPA
RUN cat <<'EOF' > /etc/nginx/conf.d/default.conf
server {
    listen 5173;
    listen [::]:5173;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html index.htm;
        try_files $uri $uri/ /index.html;
    }
}
EOF

EXPOSE 5173

CMD ["nginx", "-g", "daemon off;"]
