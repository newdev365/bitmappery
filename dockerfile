# --- Etapa 1: Compilación ---
FROM node:24-alpine AS builder

WORKDIR /usr/src/app

# Copiar archivos de dependencias
COPY package.json yarn.lock* ./

# Instalar dependencias para la build
RUN yarn install --ignore-scripts

# Copiar el código y compilar la app
COPY . .
RUN yarn build

# --- Etapa 2: Servidor web de producción ---
FROM nginx:alpine AS production

# Copiar solo la carpeta de salida generada por la build
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html

EXPOSE 5173

CMD ["nginx", "-g", "daemon off;"]
