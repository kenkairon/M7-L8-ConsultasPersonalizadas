# M7-L8-ConsultasPersonalizadas
Educativo y de Aprendizaje Personal
---
## Tabla de Contenidos
- [Tecnologías](#Tecnologías)
- [Configuración Inicial](#configuración-Inicial)
- [Creación del Modelo](#creación-del-modelo)
---
# Tecnologías
- Django: Framework web en Python.
- SQLite:
--- 
# Configuración Inicial 
1. Entorno virtual 
    ```bash 
    python -m venv venv

2. Activar el entorno virtual
    ```bash 
    venv\Scripts\activate

3. Instalar Django
    ```bash 
    pip install django 
        
4. Actualizamos el pip 
    ```bash
    python.exe -m pip install --upgrade pip

5. Crear el proyecto de django conecciondb
    ```bash 
    django-admin startproject conecciondb

6. Guardamos dependencias
    ```bash
    pip freeze > requirements.txt

7. Ingresamos al proyecto conecciondb
    ```bash 
    cd conecciondb

9. Creamos la aplicacion llamada consultaapp
    ```bash     
    python manage.py startapp consultaapp


10. Configuración de /settings.py 
    ```bash 
        INSTALLED_APPS = [
        'django.contrib.admin',
        'django.contrib.auth',
        'django.contrib.contenttypes',
        'django.contrib.sessions',
        'django.contrib.messages',
        'django.contrib.staticfiles',
        'consultasaapp',
        ]

# Creación del Modelo 

11. Creamos una base de datos en postgrest llamada dbexistente y configuramos en el settings.py
    ```bash
    from decouple import config
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql',
            'NAME': config('DATABASE_NAME'),
            'USER': config('DATABASE_USER'),
            'PASSWORD': config('DATABASE_PASSWORD'),
            'HOST': config('DATABASE_HOST'),
            'PORT': config('DATABASE_PORT'),
        }
    }

12. Creamos el .env 
    ```bash
    DATABASE_NAME=dbexistente
    DATABASE_USER=postgres
    DATABASE_PASSWORD=tucontrasenia
    DATABASE_HOST=localhost
    DATABASE_PORT=5432

13. Creamos el Archivo TablasDB.sql
    ```bash
    -- Crear tabla de Usuarios
    CREATE TABLE Usuarios (
        id SERIAL PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        apellido VARCHAR(50) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    
    -- Crear tabla de Productos
    CREATE TABLE Productos (
        id SERIAL PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        descripcion TEXT,
        precio DECIMAL(10, 2) NOT NULL,
        stock INT DEFAULT 0
    );
    
    -- Crear tabla de Pedidos
    CREATE TABLE Pedidos (
        id SERIAL PRIMARY KEY,
        id_usuario INT NOT NULL,
        fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        total DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
    );
    
    -- Agregar datos de ejemplo
    INSERT INTO Usuarios (nombre, apellido, email) VALUES
    ('Juan', 'Pérez', 'juan.perez@example.com'),
    ('Ana', 'Gómez', 'ana.gomez@example.com'),
    ('Luis', 'Martínez', 'luis.martinez@example.com');
    
    INSERT INTO Productos (nombre, descripcion, precio, stock) VALUES
    ('Laptop', 'Laptop de última generación', 1200.50, 10),
    ('Mouse', 'Mouse inalámbrico', 25.00, 100),
    ('Teclado', 'Teclado mecánico', 80.00, 50);
    
    INSERT INTO Pedidos (id_usuario, total) VALUES
    (1, 1225.50),
    (2, 105.00),
    (3, 80.00);

14. Ejecutar el comando para crear el modelo 
    ```bash
    python manage.py inspectdb > models.py
    
15. Se Hace la copia al modelo y se sobrescribe en consultaapp/models.py

16. Genero los templates/consultaapp/my_table.html
    ```bash
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Consultas</title>
    </head>

    <body>
        <h1>Consultas DB</h1>
        <br>
        <h2>Pedidos</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>id_usuario</th>
                    <th>fecha_pedido</th>
                    <th>total</th>
                </tr>
            </thead>
            <tbody>
                {% for pedido in pedidos %}
                <tr>
                    <td>{{ pedido.id }}</td>
                    <td>{{ pedido.fecha_pedido }}</td>
                    <td>{{ pedido.total }}</td>
                </tr>
                {% empty %}
                <tr>
                    <td colspan="3">No hay datos disponibles</td>
                </tr>
                {% endfor %}
            </tbody>
        </table>
        <br>
        <h2>Productos</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>nombre</th>
                    <th>descripcion</th>
                    <th>precio</th>
                    <th>stock</th>
                </tr>
            </thead>
            <tbody>
                {% for producto in productos %}
                <tr>
                    <td>{{ producto.nombre }}</td>
                    <td>{{ producto.descripcion }}</td>
                    <td>{{ producto.precio }}</td>
                    <td>{{ producto.stock }}</td>
                </tr>
                {% empty %}
                <tr>
                    <td colspan="3">No hay datos disponibles</td>
                </tr>
                {% endfor %}
            </tbody>
        </table>
        <br>
        <h2>Usuarios</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>nombre</th>
                    <th>apellido</th>
                    <th>email</th>
                    <th>fecha_registro</th>
                </tr>
            </thead>
            <tbody>
                {% for usuario in usuarios %}
                <tr>
                    <td>{{ usuario.nombre }}</td>
                    <td>{{ usuario.apellido }}</td>
                    <td>{{ usuario.email }}</td>
                    <td>{{ usuario.fecha_registro }}</td>
                </tr>
                {% empty %}
                <tr>
                    <td colspan="3">No hay datos disponibles</td>
                </tr>
                {% endfor %}
            </tbody>
        </table>
    </body>

    </html>

17. en connecciondb/urls.py
    ```bash
    from django.urls import path, include

    urlpatterns = [
        path('', include('consultaapp.urls')),
    ]

18. consultaapp/urls.py
    ```bash
    from django.urls import path
    from . import views

    urlpatterns = [
        path('my_table/', views.my_table_view, name='my_table'),
    ]
19. Se corre el servidor y se revisa las urls http://127.0.0.1:8000/my_table/
    ```bash
    python manage.py runserver