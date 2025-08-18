# Documentación del Seeder - Smart Habits

## Descripción General
El seeder de la base de datos para el proyecto **Smart Habits** está diseñado para poblar una base de datos PostgreSQL con datos iniciales, facilitando el desarrollo y pruebas de la aplicación. El seeder fue implementado en Python utilizando el framework **FastAPI** para la gestión de endpoints y **Prisma** como ORM para la definición de modelos y migraciones.

## Tecnologías Utilizadas
- **Python**: Lenguaje principal para el desarrollo del seeder.
- **FastAPI**: Framework para la creación de APIs rápidas y eficientes.
- **PostgreSQL**: Sistema de gestión de bases de datos relacional.
- **Prisma**: ORM utilizado para definir el esquema de la base de datos y facilitar la interacción con PostgreSQL.

## Entidades Principales
A continuación se describen las entidades principales del sistema, según el archivo `schema.prisma`:

### User
Representa a los usuarios de la plataforma.
- `id`: Identificador único (UUID).
- `name`: Nombre del usuario.
- `email`: Correo electrónico (único).
- `password`: Contraseña.
- `age`: Edad.
- `region`: Región geográfica (enum).
- `createdAt`: Fecha de creación.
- `role`: Rol del usuario (`COMMON`, `SUPER`).
- **Relaciones**: `habits`, `recommendations`, `interactions`, `profile`.

### Habit
Define los hábitos disponibles en la plataforma.
- `id`: Identificador único (UUID).
- `name`: Nombre del hábito.
- `category`: Categoría del hábito (enum).
- `description`: Descripción.
- **Relaciones**: `users` (usuarios que tienen este hábito).

### UserHabit
Asocia usuarios con hábitos específicos.
- `id`: Identificador único (UUID).
- `userId`: Referencia al usuario.
- `habitId`: Referencia al hábito.
- `status`: Estado del hábito (enum).
- `scheduledTime`: Hora programada.
- `completedAt`: Fecha de finalización (opcional).

### Recommendation
Recomendaciones personalizadas para los usuarios.
- `id`: Identificador único (UUID).
- `userId`: Referencia al usuario.
- `message`: Mensaje de recomendación.
- `createdAt`: Fecha de creación.
- `shownTime`: Hora en que se mostró.

### Interaction
Registra las interacciones de los usuarios con la plataforma.
- `id`: Identificador único (UUID).
- `userId`: Referencia al usuario.
- `type`: Tipo de interacción (enum).
- `target`: Objetivo de la interacción.
- `timestamp`: Fecha y hora.

### Profile
Perfil ecológico del usuario.
- `id`: Identificador único (UUID).
- `userId`: Referencia al usuario (único).
- `profileType`: Tipo de perfil (enum).
- `assignedAt`: Fecha de asignación.

## Enums
- **Region**: `NORTE`, `CENTRO`, `SUR`, `OCCIDENTE`, `SURESTE`, `CDMX`, `INTERNACIONAL`
- **ProfileType**: `ECO_PRINCIPIANTE`, `ECO_AVANZADO`, `ECO_EXPERTO`
- **HabitCategory**: `ENERGIA`, `AGUA`, `RESIDUOS`, `MOVILIDAD`, `CONSUMO`
- **HabitStatus**: `ACTIVO`, `PAUSADO`, `COMPLETADO`, `CANCELADO`
- **InteractionType**: `CLICK`, `IGNORE`, `COMPLETE`, `SKIP`
- **UserRole**: `COMMON`, `SUPER`

## Uso del Seeder
El seeder puede ejecutarse para poblar la base de datos con datos de ejemplo, facilitando el desarrollo y pruebas. Asegúrate de tener configurada la variable de entorno `DATABASE_URL` con la cadena de conexión a PostgreSQL.


## Notas
- El seeder respeta las relaciones y restricciones definidas en el esquema Prisma.
- Puedes modificar los datos iniciales según las necesidades del proyecto.
