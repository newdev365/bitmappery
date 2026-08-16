# --- Etapa 1: Compilación de la aplicación ---
DESDE el nodo: Constructor AS 24-alpino

WORKDIR/usr/src/app

COPIAR paquete.json yarn.lock* ./
Instalación de hilo EJECUTAR --ignore-scripts

COPIAR . .
RUN construcción de hilo

# --- Etapa 2: Imagen ligera de producción ---
DESDE nginx:alpine AS producción

COPIAR --dede=builder/usr/src/app/dist/usr/share/nginx/html

EXPONENTE 5173

CMD ["nginx", "-g", "demonio apagado";]
