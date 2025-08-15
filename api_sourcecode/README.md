# Documentación de la API Smart Habits

## 1. Enlace del repositorio de la API

Repositorio oficial: [https://github.com/JHOIStack/api-smart-habits](https://github.com/JHOIStack/api-smart-habits)

---

## 2. Operaciones CRUD Básicas

La API Smart Habits implementa las operaciones CRUD (Create, Read, Update, Delete) para gestionar las entidades principales del sistema:

- **GET**: Recupera información de las entidades.
- **POST**: Crea nuevos registros en las entidades.
- **PUT**: Actualiza completamente un registro existente.
- **PATCH**: Actualiza parcialmente un registro existente.
- **DELETE**: Elimina registros de las entidades.

Estas operaciones permiten la gestión eficiente de los datos y la interacción con el sistema de manera estructurada y segura.

---

## 3. Listado de Endpoints de las Entidades

| Entidad         | Endpoint base                | Métodos CRUD disponibles                                                                 |
|-----------------|------------------------------|-----------------------------------------------------------------------------------------|
| Usuarios        | `/api/users`                 | `GET /` (todos), `GET /:id`, `POST /`, `PUT /:id`, `DELETE /:id`                        |
| Hábito          | `/api/habits`                | `GET /` (todos), `GET /:id`, `POST /`, `PUT /:id`, `DELETE /:id`                        |
| Usuario-Hábito  | `/api/user-habits`           | `GET /` (todos), `GET /:id`, `POST /`, `PUT /:id`, `DELETE /:id`                        |
| Perfiles        | `/api/profiles`              | `GET /` (todos), `GET /:id`, `POST /`, `PUT /:id`, `DELETE /:id`                        |
| Recomendaciones | `/api/recommendations`       | `GET /` (todos), `GET /:id`, `POST /`, `PUT /:id`, `DELETE /:id`                        |
| Interacciones   | `/api/interactions`          | `GET /` (todos), `GET /:id`, `POST /`, `PUT /:id`, `DELETE /:id`                        |
| Estadísticas    | `/api/stats`                 | `GET /` (todos), `GET /:id`                                                            |
| Autenticación   | `/api/auth`                  | `POST /login`, `POST /register`, `POST /logout`                                         |

### Ejemplo de rutas para Usuarios

```js

GET    /api/users
GET    /api/users/:id
POST   /api/users
PUT    /api/users/:id
DELETE /api/users/:id
```

### Ejemplo de rutas para Hábitos

```js
GET    /api/habits
GET    /api/habits/:id
POST   /api/habits
PUT    /api/habits/:id
DELETE /api/habits/:id
```

### Ejemplo de rutas para Usuario-Hábito

```js
GET    /api/user-habits
GET    /api/user-habits/:id
POST   /api/user-habits
PUT    /api/user-habits/:id
DELETE /api/user-habits/:id
```

### Ejemplo de rutas para Perfiles

```js
GET    /api/profiles
GET    /api/profiles/:id
POST   /api/profiles
PUT    /api/profiles/:id
DELETE /api/profiles/:id
```

### Ejemplo de rutas para Recomendaciones (ML)

```js
GET    /api/recommendations
GET    /api/recommendations/:id
POST   /api/recommendations
PUT    /api/recommendations/:id
DELETE /api/recommendations/:id
```

### Ejemplo de rutas para Interacciones

```js
GET    /api/interactions
GET    /api/interactions/:id
POST   /api/interactions
PUT    /api/interactions/:id
DELETE /api/interactions/:id
```

### Ejemplo de rutas para Estadísticas

```js
GET    /api/stats
GET    /api/stats/:id
```

### Ejemplo de rutas para Autenticación

```js
POST   /api/auth/login
POST   /api/auth/register
POST   /api/auth/logout
```

---

## 4. Screenshots de los Endpoints CRUD

A continuación se muestran ejemplos visuales de las respuestas de los endpoints CRUD:

### Ejemplo GET Usuario
![GET Usuario](images/Captura%20de%20pantalla%202025-08-15%20a%20la(s)%209.27.16 a.m..png)

### Ejemplo POST Hábito
![POST Hábito](images/Captura%20de%20pantalla%202025-08-15%20a%20la(s)%209.28.23 a.m..png)

### Ejemplo DELETE Hábito
![DELETE Hábito](images/Captura%20de%20pantalla%202025-08-15%20a%20la(s)%209.29.16 a.m..png)

---

## 5. Endpoints que utilizan Machine Learning (ML)

La API incluye endpoints orientados al análisis de datos mediante técnicas de Machine Learning, diseñados para ofrecer recomendaciones y análisis predictivos:

- **/api/ml/recomendaciones/**: Genera recomendaciones personalizadas de hábitos según el historial del usuario.
- **/api/ml/predicciones/**: Predice la probabilidad de éxito en la adopción de nuevos hábitos.

Estos endpoints procesan los datos históricos y comportamientos para mejorar la experiencia del usuario y fomentar hábitos saludables.

---

## 6. Screenshots de los Endpoints ML

### Ejemplo Recomendaciones ML
![ML Recomendaciones](screenshots/ml_recomendaciones.png)

### Ejemplo Predicciones ML
![ML Predicciones](screenshots/ml_predicciones.png)

---

> Para más detalles técnicos y ejemplos de uso, consulta el repositorio oficial.
