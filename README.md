# Tutorial de New Relic y Docker

## 1. Crear contenedor

A traves de estas instrucciones se puede construir la imagen del contenedor y crear una instancia de ejecución.

```bash
# docker build: Construye una imagen
# -t: Tag
docker build --build-arg PORT=5005 -t new-relic-lab .

# docker images: Lista las imagenes
docker images

# docker run: Ejecuta un contenedor
# -t: TTY
# -d: Detached
# -i: Interactive
# -e: Environment variable
# -v: Volume
# --name: Container name

docker run -td --name new-relic-lab new-relic-lab

# docker ps: Lista los contenedores
docker ps

# docker exec: Inicializa una consola interactiva en un contenedor
docker exec -ti new-relic-lab bash
```

## Correr la imagen

### 1.a. Correr la imagen pasando la llave como variable de entorno

```bash
# Guradar la llave en el archivo .env
docker compose up --build -d
# En desarrollo:
docker compose watch
```

### 1.b. Correr la imagen pasando la llave como variable de entorno

```bash
# the NR license key you retrieved in first section
export NEW_RELIC_LICENSE_KEY=xxxxxxxxxxxx

# run container, pass NR license key as environment variable
docker run -it -p 5005:5005 -e NEW_RELIC_LICENSE_KEY=$NEW_RELIC_LICENSE_KEY --rm --name new-relic-lab new-relic-lab
```

## 2. Ejecutar pruebas de carga sobre el contenedor.

```bash
# Hacer peticiones al api
curl http://localhost:5005

# Hacer peticiones en masa
sudo apt install apache2-utils -y # install Apache Bench
# run 10k tests with 25 concurrent users
ab -n 10000 -c 25 http://localhost:5005/
```

## 3. Workflow de desarrollo

```bash
# python3 en linux; py en windows.

# Crear el entorno la primera vez en Linux
python3 -m venv .venv
# Crear el entorno la primera vez en Windows
py -m venv .venv

# Activar el entorno linux
source .venv/bin/activate
# Activar el entorno virtual windows (Git Bash)
source .venv/Scripts/activate


# Trabajar (requiere: Activar el entorno)
# Instala las dependencias en el entorno
pip3 install -r src/requirements.txt
# pip3 install flask
# pip3 install python-dotenv
# pip3 install gunicorn
# pip3 freeze > requirements.txt

# Ejecuta la aplicación
FLASK_APP=application.py flask run

# Desactivar el entorno (requiere: Activar el entorno)
deactivate
```
