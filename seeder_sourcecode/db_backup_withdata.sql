--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: HabitCategory; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."HabitCategory" AS ENUM (
    'ENERGIA',
    'AGUA',
    'RESIDUOS',
    'MOVILIDAD',
    'CONSUMO'
);


--
-- Name: HabitStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."HabitStatus" AS ENUM (
    'ACTIVO',
    'PAUSADO',
    'COMPLETADO',
    'CANCELADO'
);


--
-- Name: InteractionType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."InteractionType" AS ENUM (
    'CLICK',
    'IGNORE',
    'COMPLETE',
    'SKIP'
);


--
-- Name: ProfileType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ProfileType" AS ENUM (
    'ECO_PRINCIPIANTE',
    'ECO_AVANZADO',
    'ECO_EXPERTO'
);


--
-- Name: Region; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."Region" AS ENUM (
    'NORTE',
    'CENTRO',
    'SUR',
    'OCCIDENTE',
    'SURESTE',
    'CDMX',
    'INTERNACIONAL'
);


--
-- Name: UserRole; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."UserRole" AS ENUM (
    'COMMON',
    'SUPER'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Habit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Habit" (
    id text NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    category public."HabitCategory" NOT NULL
);


--
-- Name: Interaction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Interaction" (
    id text NOT NULL,
    "userId" text NOT NULL,
    target text NOT NULL,
    "timestamp" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type public."InteractionType" NOT NULL
);


--
-- Name: Profile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Profile" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "assignedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "profileType" public."ProfileType" NOT NULL
);


--
-- Name: Recommendation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Recommendation" (
    id text NOT NULL,
    "userId" text NOT NULL,
    message text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "shownTime" text NOT NULL
);


--
-- Name: User; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."User" (
    id text NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    age integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    region public."Region",
    password text NOT NULL,
    role public."UserRole" DEFAULT 'COMMON'::public."UserRole" NOT NULL
);


--
-- Name: UserHabit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserHabit" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "habitId" text NOT NULL,
    "scheduledTime" text NOT NULL,
    "completedAt" timestamp(3) without time zone,
    status public."HabitStatus" NOT NULL
);


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- Data for Name: Habit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Habit" (id, name, description, category) FROM stdin;
01d8c3a8-16a0-4c8d-a355-f1875055c5c3	Ducha rápida (5 min)	Reduce tu tiempo en la ducha para ahorrar agua.	AGUA
97699023-9fbe-4e66-aafb-00d0699540b3	Usar cortinas térmicas	Aíslan y reducen uso de calefacción o aire.	ENERGIA
eb27f377-5cd0-4c0f-9d6f-17f7574b67b0	Educar sobre consumo responsable	Comparte información con amigos/familia.	CONSUMO
5b7a9b30-5f96-4831-854f-2009f004873e	Cerrar llave al enjabonar platos	Solo abrir al enjuagar.	AGUA
2e46c2df-062c-4d37-9ce7-bca11437615b	Limpiar focos y lámparas	Mejora la eficiencia de la iluminación.	ENERGIA
3e3d4d7d-206f-4456-8168-f8c63ce843d0	Limpiar aceras con barredera en lugar de agua	Prioriza métodos secos.	AGUA
c5fe89fa-9a66-4061-bdba-8b6a12d6028c	Realizar mantenimiento de electrodomésticos	Asegura funcionamiento eficiente.	ENERGIA
81cf46b6-7b6a-4be6-9fd4-44b1f8b9cc95	Mantener neumáticos inflados	Mejora la eficiencia del combustible.	MOVILIDAD
8dec7108-0225-4e1e-bdcd-6e1fbb09d995	Evitar vuelos cortos	Prefiere trenes para distancias menores a 500 km.	MOVILIDAD
fe0bd9ad-1cba-4540-b745-69a6b6fa6d94	Usar lavadora y lavavajillas con carga completa	Optimiza cada ciclo de lavado.	AGUA
892f48fa-43a7-4e62-93a4-729b8e838310	Evitar compras impulsivas	Haz listas y espera 24h antes de comprar.	CONSUMO
53adc63a-7963-438c-a048-14af005811fa	Secar ropa al sol	Evita la secadora eléctrica siempre que sea posible.	ENERGIA
873f3209-5852-400e-ba68-e212b1d6ed1a	Elegir productos de segunda mano	Alarga la vida útil de objetos.	CONSUMO
7be443aa-728b-4020-86e4-48a4a3261d89	Usar patinete eléctrico	Alternativa sostenible para trayectos medios.	MOVILIDAD
ac2e19a4-93c4-4e82-ba69-598998e4b265	Evitar productos con microplásticos	Dañan los ecosistemas acuáticos.	CONSUMO
7333ca48-3e98-4747-850c-c83d91bc8c02	Evitar acelerar al arrancar	Arranque suave ahorra combustible.	MOVILIDAD
f0c90e82-babf-4137-a059-d7e635ecca9d	Instalar grifos con aireador	Reducen el caudal sin perder presión.	AGUA
6d2592f3-8333-491b-a2f3-2ef82eb63591	Crear compostera casera	Usa restos de comida para abono.	RESIDUOS
6f5a527d-7a19-4a05-9870-5dd8d6aba4a2	Usar modos eco en electrodomésticos	Lava ropa o platos con programas de bajo consumo.	ENERGIA
60dc45f1-75e9-4925-a559-f2b04aed16a5	Revisar inventario antes de comprar	Evita duplicar productos.	CONSUMO
b69f6a6e-afc5-4498-b153-96a7bed7123a	Instalar paneles solares	Genera energía renovable en casa si es viable.	ENERGIA
fd391506-c119-467a-9b85-1a14d06a4117	Reparar ropa rota	Coser en lugar de tirar.	RESIDUOS
d1e304ee-92e8-4b7f-87bd-1b2b72906a1b	Organizar carpool en el trabajo	Coordina viajes con colegas.	MOVILIDAD
40ade030-1bee-4360-91d6-c596ee16145d	Donar libros usados	Promueve la reutilización.	CONSUMO
6e06df87-2688-4c1f-bb81-4f9672a5908f	Evitar vuelos cortos	Prefiere trenes para distancias menores a 500 km.	MOVILIDAD
d7db67e5-6e82-4eec-8305-3d60b2f323e3	Reutilizar agua de cocción	Por ejemplo, para regar o hacer sopas.	AGUA
f458c790-95d8-4bce-915e-bc27a56c9586	Instalar detectores de movimiento	Evita luces encendidas innecesariamente.	ENERGIA
7a089b92-94f0-4b83-9290-b493e3669e33	Compartir coche (carpooling)	Reduce tráfico y contaminación.	MOVILIDAD
04f7beb8-944a-4dc3-b8b3-e6a08ed53db3	Evitar productos desechables (cubiertos, platos)	Prefiere opciones reutilizables.	RESIDUOS
503df901-9864-4f1f-9625-cc14d853a313	Elegir productos de segunda mano	Alarga la vida útil de objetos.	CONSUMO
164456a2-1c8b-4593-ae7d-35c022e19a34	Caminar al mercado	Evita uso del coche para distancias cortas.	MOVILIDAD
1fbc570b-31e9-45de-987a-2b62de923c0c	Teletrabajar cuando sea posible	Reduce desplazamientos innecesarios.	MOVILIDAD
33843cf4-8bde-402c-97ef-1a79757207e2	Reutilizar frascos y envases	Dales una segunda vida como almacenamiento.	RESIDUOS
be7fa636-09b2-4e8a-998d-9fa0548ad05d	Utilizar apps de recetas de aprovechamiento	Evita tirar comida aprovechable.	RESIDUOS
08f74cba-515b-4321-8ef1-e84781516538	Calentar agua con energía solar	Instala un calentador solar para duchas.	ENERGIA
2a535fe7-e302-478e-bf18-0fd9c78627cd	Crear un sistema de reciclaje en casa	Organiza contenedores por tipo de material.	RESIDUOS
719b95cf-1964-4536-aa17-8aaec04ea1ab	Probar dieta vegetariana un día a la semana	Reduce impacto ambiental.	CONSUMO
1a758ad0-33f1-42e8-a697-e7d60b9a3db9	Evitar el sobreenvasado	Rechaza productos con múltiples capas de plástico.	CONSUMO
73f9d797-d073-45e1-b11f-196a8c04bc5c	Limpiar aceras con barredera en lugar de agua	Prioriza métodos secos.	AGUA
1d969d45-6e5d-40d1-92f6-c6d538e9b248	Educar a niños en el ahorro de agua	Fomenta hábitos desde pequeños.	AGUA
1638a6ae-94cd-43ab-85c4-789103648111	No imprimir boletos de transporte	Usa versión digital.	RESIDUOS
dd772762-8f5f-4f3a-832d-4f256100ac15	Evitar vuelos cortos	Prefiere trenes para distancias menores a 500 km.	MOVILIDAD
6fb70cf9-b435-4289-b62b-b49f147ba320	Apagar modem/router por la noche	Ahorra energía mientras duermes.	ENERGIA
2892a127-743c-4438-9994-e9fb55fa4ce3	Usar electrodomésticos eficientes (A+++)	Prioriza dispositivos con certificación energética A+++.	ENERGIA
563f19c0-65a5-4866-93fd-a77b82544ab1	Elegir productos con empaques biodegradables	Prioriza cartón, vidrio o bambú.	RESIDUOS
c7aad547-7941-4181-b518-18a04ee7b6c3	Evitar productos desechables (cubiertos, platos)	Prefiere opciones reutilizables.	RESIDUOS
a2ee62d9-83cf-498c-bb8f-8115e41f772a	Compartir coche (carpooling)	Reduce tráfico y contaminación.	MOVILIDAD
735da0ce-a32b-4e1f-b184-7a77a051d51c	Reutilizar papel de envoltura	Para futuros regalos o manualidades.	RESIDUOS
389df2ed-cf00-4ce6-b3a2-c7e4461a5b0e	Instalar detectores de movimiento	Evita luces encendidas innecesariamente.	ENERGIA
6f3c99b5-7853-493d-b70a-480471da47e6	Promover ciclovías en tu comunidad	Fomenta el transporte sostenible.	MOVILIDAD
85abf778-0dd3-4441-9df0-6ddf7c6062e9	Reutilizar papel de envoltura	Para futuros regalos o manualidades.	RESIDUOS
ce6ddcae-1567-48d1-9c70-ccdbc48ea5af	Usar focos LED	Reemplaza bombillas por opciones más eficientes.	ENERGIA
397f82f3-668c-4811-a734-2c8993b47d58	Evitar acelerar al arrancar	Arranque suave ahorra combustible.	MOVILIDAD
d8c68e97-c9e3-4d83-8b78-a771d2da53a9	Reparar antes de comprar nuevo	Extiende la vida de tus pertenencias.	CONSUMO
15d17687-dd5f-49a4-85ea-ca45d1f272f7	Ventilar la casa eficientemente	Abre ventanas solo 10 min para renovar aire sin perder calor/frío.	ENERGIA
480f973f-ea04-4e5e-a4e1-64e8514ba13f	Usar lavadora y lavavajillas con carga completa	Optimiza cada ciclo de lavado.	AGUA
2b205ec4-486b-4a0e-96d0-a41f43133aa2	Realizar mantenimiento de electrodomésticos	Asegura funcionamiento eficiente.	ENERGIA
a186c03e-7723-4633-a10a-43c0d5a37a41	Instalar toldos o persianas en verano	Disminuyen la necesidad de aire acondicionado.	ENERGIA
e9c2f6b5-0f90-438f-816c-0a0fd3a95365	Cerrar llave al enjabonar platos	Solo abrir al enjuagar.	AGUA
0e153857-73cb-4ef3-b9a9-e2da61999c34	Reciclar aceite de cocina	Llévalo a puntos de reciclaje (nunca al desagüe).	RESIDUOS
498c7d29-4711-4a47-a73d-19d537ed4353	Usar botellas y tazas reutilizables	Evita plásticos desechables.	CONSUMO
1d7c955c-d60a-4445-accf-e5cab0075c6a	Evitar usar auto para recados cortos	Agrupa salidas en un solo viaje.	MOVILIDAD
1aa95c2d-df3b-405b-b699-480a936dd845	Reparar ropa rota	Coser en lugar de tirar.	RESIDUOS
bee47ae1-f2f9-4fe8-83cf-e3cb977c6fb2	Usar focos LED	Reemplaza bombillas por opciones más eficientes.	ENERGIA
2fa53bcf-7f6b-4d0c-a7c0-593f0159134a	Viajar ligero	Menos peso en el coche = menos consumo de combustible.	MOVILIDAD
9a648b95-3e20-455d-8108-0e3cdab01251	Revisar inventario antes de comprar	Evita duplicar productos.	CONSUMO
cd9fc71e-4da6-4aac-8f3a-638b1873c47d	Reducir consumo de carne	La producción animal tiene alta huella ecológica.	CONSUMO
33f01b32-0b99-4db2-8112-424494121aca	Organizar carpool en el trabajo	Coordina viajes con colegas.	MOVILIDAD
3cd4678e-09f3-417a-b74f-fae2a8e6180f	Usar servilletas de tela	Sustituye las de papel.	RESIDUOS
89eca878-bbb2-464f-9771-edb039c86270	Reciclar aceite de cocina	Llévalo a puntos de reciclaje (nunca al desagüe).	RESIDUOS
6e2739c7-bf3e-48f1-b9f8-1b55248231a5	Realizar mantenimiento de electrodomésticos	Asegura funcionamiento eficiente.	ENERGIA
913c65c7-a6cb-4416-b935-cf94ffb85d09	Usar lavadora y lavavajillas con carga completa	Optimiza cada ciclo de lavado.	AGUA
d6e66029-078a-4334-a495-755353631b8b	Usar sistemas de riego por goteo	Son un 50% más eficientes que el riego tradicional.	AGUA
be55113c-4449-434d-8fb6-4c122fcb478a	Evitar recibos impresos	Pide facturas digitales.	RESIDUOS
4289c84b-76d8-4ad2-adb8-753c1122e77b	Reciclar electrónicos en puntos autorizados	Evita la contaminación por metales pesados.	RESIDUOS
cc478ce6-47b5-49bf-a62e-9aa9807d4d83	Compostar café y té usado	Son excelentes para el compost.	RESIDUOS
c844c0a9-7526-4a17-bf3a-e48a71ef22fe	Cocinar con ollas a presión	Reduce tiempo y energía al preparar alimentos.	ENERGIA
2a59a167-90cc-4d82-b0e9-8531149cbe22	No descongelar alimentos bajo el grifo	Usa el refrigerador o microondas.	AGUA
757c60bc-663e-4ef5-a480-617b6381e8eb	Lavar ropa con agua fría	Evita consumo energético por calentamiento de agua.	ENERGIA
af2e0448-f675-4062-9e62-1ca1ce809694	Desconectar aparatos	Desconecta cargadores y electrodomésticos que no uses.	ENERGIA
3a840607-09cb-49d7-b256-be7bf688fd16	Compartir coche (carpooling)	Reduce tráfico y contaminación.	MOVILIDAD
40454f9f-cd88-4309-9620-671cc173c417	Comprar alimentos de temporada	Son más baratos y sostenibles.	CONSUMO
a47190da-8c96-4b19-a73e-d5af5e2c33a6	Evitar aceleraciones bruscas	Conducir suavemente ahorra hasta un 20% de combustible.	MOVILIDAD
090baa24-b00b-4084-bb49-cb53ad8f2327	Utilizar apps de recetas de aprovechamiento	Evita tirar comida aprovechable.	RESIDUOS
77ab14c8-7ddf-473d-9785-e6c0544c8a85	Elegir vehículos eléctricos o híbridos	Contaminan menos que los de combustión.	MOVILIDAD
5d729efc-116e-43a0-b9bc-e4b4e65222fd	No imprimir boletos de transporte	Usa versión digital.	RESIDUOS
3b7d1bdb-17c0-4a2a-ae52-009722bbddc8	Instalar detectores de movimiento	Evita luces encendidas innecesariamente.	ENERGIA
4ac948e2-dc61-4192-a899-10116049d06c	Donar libros usados	Promueve la reutilización.	CONSUMO
c143d066-cc68-4a9f-b3ce-5f6936b29b33	Instalar inodoros de doble descarga	Permiten usar solo el agua necesaria.	AGUA
4a46a24e-f1bc-437d-9b76-43133544af21	Reciclar aceite de cocina	Llévalo a puntos de reciclaje (nunca al desagüe).	RESIDUOS
8a0bd398-5d51-4c5f-be18-74a8001ec425	Apagar luces innecesarias	Apaga las luces cuando salgas de una habitación.	ENERGIA
b434cafc-e6bc-4e8d-a0c3-aea861fd2f89	Evitar productos desechables (cubiertos, platos)	Prefiere opciones reutilizables.	RESIDUOS
9590a225-9007-42ca-9431-6e54eb24e4b9	Apagar luces innecesarias	Apaga las luces cuando salgas de una habitación.	ENERGIA
b6bc6efa-5c99-4b38-88b8-6598f5f21469	Usar electrodomésticos eficientes (A+++)	Prioriza dispositivos con certificación energética A+++.	ENERGIA
67ae945d-412d-4551-a560-ca841d52b1d1	Programar apagado automático de dispositivos	Configura tu computadora o TV para que se apaguen solos.	ENERGIA
51ab9df1-c025-4960-aba6-2ff0587ebd13	Compartir o alquilar herramientas poco usadas	Reduce consumo y residuos.	RESIDUOS
913ed5b5-e107-4526-b026-de7652de5545	Usar servilletas de tela	Sustituye las de papel.	RESIDUOS
92625cd7-c3cf-410b-be57-79f7a843f043	Usar balde en lugar de manguera para lavar autos	Ahorra hasta 300 litros por lavada.	AGUA
b7fc1120-e7e3-45a4-8bff-5a74ecd4df77	Crear un sistema de reciclaje en casa	Organiza contenedores por tipo de material.	RESIDUOS
68a445d0-986f-4b73-9489-c2b10975b74b	Educar sobre consumo responsable	Comparte información con amigos/familia.	CONSUMO
bf6275e3-2ae3-4835-86c7-169a28dd68c3	Instalar paneles solares	Genera energía renovable en casa si es viable.	ENERGIA
\.


--
-- Data for Name: Interaction; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Interaction" (id, "userId", target, "timestamp", type) FROM stdin;
7d02fee9-9415-43f6-b0bb-fe2e98eb4db6	70931e79-3d99-4b89-9d61-1df877e2a477	2280520d-709e-4222-8183-f6fd635cdbac	2025-05-31 08:53:02.058	COMPLETE
84d791ba-4b55-4cbc-8542-7f5fb1414c36	11f16c31-6440-41ee-8de8-45994231c1b1	2ee57ca4-0cc0-4a90-8423-64f22e617a40	2025-05-25 06:58:57.81	IGNORE
68f2762b-b924-4338-a15e-101934c54e94	76a664a4-f686-4144-ab24-b73c5e1db0d1	e9ccde33-aedf-428f-92b4-f48264522047	2025-04-11 16:01:07.793	COMPLETE
d21a19b1-b80d-4897-97e8-068a2ede0be8	f173ce5a-db72-4470-822f-23dfd80f69a2	59f7c36d-2caa-4aa4-88e7-1ddf714225fe	2025-01-31 20:07:26.446	SKIP
93e097c0-19c0-4831-af7c-50d3c930b59b	c0011e62-6757-47a0-95c0-cd56c3dc18c8	f875bbb9-c7d4-4516-a8fa-de57d122353a	2025-06-22 09:11:23.239	IGNORE
50a0be6d-5929-4610-b0a6-1989c4857869	af78e980-6d06-4cef-858d-674a7d0599b6	5123d4d2-a2a5-4b38-bdaf-761e865e7927	2025-04-01 16:06:07.904	SKIP
371e477a-537d-4aeb-99e4-1bbe81fd9bf6	9b9bc092-95fe-436a-b168-6a23874139a3	096b5ed7-7bec-4cf3-b2d9-99aff2486535	2025-02-25 14:30:57.07	IGNORE
16238b47-f568-49b6-bf8a-4d355285bc78	f2b22ef5-8c66-42c6-86fb-020165c66931	90bec4dd-bb13-4b62-8ee8-df6fbc8b1506	2025-05-31 19:01:33.795	IGNORE
f1e42100-c24b-4f0c-853c-c51ab41ec2ef	addb7aff-6ce8-4f1d-93bb-973339eb84cb	57292bd6-d425-4ad8-9904-54a49c258223	2025-04-02 12:12:23.23	CLICK
8bcec970-6245-4af7-91d3-c896654d4941	8d92d664-c512-4941-a2f1-67d00b466f1c	5bcd4ad6-14ac-496a-a9ea-943a38143941	2025-05-30 00:32:07.434	IGNORE
08901378-8131-40a4-ba9c-49c66cffb929	68040bde-d2ba-453c-9a4c-b182412ec0ab	e2196b6b-196f-4654-983c-58b851b5b482	2025-06-17 23:24:15.604	CLICK
5dfe2d3f-c3a5-4ebd-a016-17dc8d33c60e	56201644-9405-4c2e-954b-9b018d54f70e	3f5376ff-fcd9-4588-b0ad-31b27e4d546d	2025-05-17 04:03:37.74	CLICK
2895846f-99b7-4420-bab8-98f4b1fdb826	b71d9a0f-f721-4d41-a72e-24dfd092b1a9	7f6c8b62-fa78-4ef9-be5f-76706c2d9293	2025-03-21 00:59:30.826	CLICK
aa888c21-c618-45e7-ba5d-bbd95722e9c8	1f6fa398-426d-4df7-9abd-9fd065711296	84db1722-55c8-471e-b95d-bbbfa27e1188	2025-07-24 04:03:17.809	SKIP
2559e6eb-8351-4734-87ad-16d1d5a688a4	acff4c16-632f-4e9e-942e-5bd52b7efdad	8e4d3a3a-7c17-4b0d-9443-e1aaae032a95	2025-07-22 02:48:01.01	CLICK
c9d80cf9-e81a-4e05-8e23-624f88274beb	3021c1cd-8e20-4a6e-a64f-97bbd933c5a1	704f2289-9d48-4a3d-a54d-4bbaeaa3191f	2025-07-16 18:39:18.544	COMPLETE
504e8964-e92c-45d0-bbab-b27aa4893607	eebd6522-8c92-4b75-b2ac-117888f45c07	423e0f6f-afab-41ec-b730-5150a0cea5dc	2025-02-12 02:23:47.974	IGNORE
286b62af-b553-43aa-b17e-4c3afe20d894	f2b22ef5-8c66-42c6-86fb-020165c66931	2221c5e8-0c8e-4514-87ef-2f0c38f19ab1	2025-02-05 07:49:05.43	IGNORE
c08e4851-5fd7-456a-9d3f-b95ddd0603b6	d45f77bd-83c3-40b0-800e-5a4e75125b18	1a9516dc-dabb-45db-8acd-4c9b1909a897	2025-07-25 22:06:44.243	CLICK
67de5f6a-b882-40d2-9798-7689f0a167d7	49415e3a-20ce-4182-9494-890a0662f3b8	cbc94dbc-a350-4d05-87cd-22936eac1bcf	2025-02-17 14:45:30.634	CLICK
ce84e656-3585-4838-82af-bda8b7383e78	850dc0c6-7e82-4726-aa43-ea9b4b39755c	3cdd6f74-31b9-4809-a02d-f30118bfbb69	2025-04-01 21:25:57.167	CLICK
e7bf02e0-5068-470b-99ad-5eb55750c302	2a37c6b4-5f78-448b-91d4-ae7d86c014a3	56ab4dfa-8380-4b76-bddf-8da4aa3643da	2025-02-28 07:53:13.861	SKIP
897adf4f-07af-4652-abf3-54bb6dbed3db	8d92d664-c512-4941-a2f1-67d00b466f1c	5bcd4ad6-14ac-496a-a9ea-943a38143941	2025-04-27 17:54:37.231	IGNORE
25c1953b-7532-475f-86f2-baef04aa17ab	acdf07ba-8748-43f5-a49b-11d7d42e18d4	08f306a6-da3f-47b2-8d9c-ef7d6d330361	2025-05-13 06:07:09.186	CLICK
654770c2-8f2e-40c9-afcd-6055a14a8bf6	8d92d664-c512-4941-a2f1-67d00b466f1c	8e0d0a93-74b9-46bd-a7bb-a3faf7fd6292	2025-06-15 20:52:32.876	COMPLETE
05e6f426-44a9-41a0-9ae2-d497e99a4df7	f173ce5a-db72-4470-822f-23dfd80f69a2	1f66db9d-d5f9-4e6b-b051-1eb133d7c825	2025-07-29 06:29:19.278	SKIP
440e6595-c4e1-4d2a-98f3-c025b88f1ccc	addb7aff-6ce8-4f1d-93bb-973339eb84cb	57292bd6-d425-4ad8-9904-54a49c258223	2025-02-07 22:53:00.07	SKIP
f331d9bc-2f80-41ad-aea7-032e5c723470	c0011e62-6757-47a0-95c0-cd56c3dc18c8	f875bbb9-c7d4-4516-a8fa-de57d122353a	2025-07-15 17:15:14.916	IGNORE
c26d592a-394f-4c83-b437-228bbfbd6db5	11f16c31-6440-41ee-8de8-45994231c1b1	2ee57ca4-0cc0-4a90-8423-64f22e617a40	2025-04-24 23:12:29.01	IGNORE
a9918e52-f493-49dc-a098-3e1756975d93	3021c1cd-8e20-4a6e-a64f-97bbd933c5a1	704f2289-9d48-4a3d-a54d-4bbaeaa3191f	2025-05-13 23:04:49.229	COMPLETE
933525d4-3316-43c2-a231-b0863f41cb16	9aa0637f-3f77-49ac-938b-0fb75becd0ce	183676a5-585b-4a73-8fa2-fc2ab2bfdd3b	2025-05-25 00:57:31.299	IGNORE
72050c59-4c51-4c14-be50-8e05b0cb3c29	68040bde-d2ba-453c-9a4c-b182412ec0ab	e2196b6b-196f-4654-983c-58b851b5b482	2025-02-14 17:08:15.622	COMPLETE
540f5eaf-24eb-4473-acd3-a94efb9b5b63	d4efcbfc-3929-4ec4-affd-8339d36380fe	ae3aac82-47eb-4616-b9af-9f09b61425ae	2025-03-19 22:17:51.887	IGNORE
00b7313c-b611-45dc-bbf8-12716f330302	68f2ce35-6a69-4214-912c-2afb5a2c390c	6db95631-21b2-478c-97d3-d0256361863e	2025-07-23 20:49:36.622	IGNORE
eb70de13-66e4-4b27-a69b-4f9fd1fd6169	b17490b4-b072-4269-af64-7cd2ba191257	978d9571-8b5b-4569-ad98-e0221f3dab8c	2025-04-14 07:22:16.165	CLICK
3e27d821-c00f-4305-9534-6238b2a9de6e	76a664a4-f686-4144-ab24-b73c5e1db0d1	dc0ca2ef-3afc-43c3-8ac1-3c2ac7fef94c	2025-07-10 15:17:15.243	CLICK
3e7df98e-d89e-4c05-a294-2e802a087a15	b17490b4-b072-4269-af64-7cd2ba191257	978d9571-8b5b-4569-ad98-e0221f3dab8c	2025-01-30 13:27:21.556	CLICK
16c3337c-339d-4187-b9d5-382adccf6b88	566b1ab4-c44c-4064-915d-17fd293fd8fe	184bde8f-cb40-41dc-bf0f-768836a69d3e	2025-07-09 21:51:30.268	SKIP
f713162b-e6aa-4bb6-bb76-94b52d9bd068	9aa0637f-3f77-49ac-938b-0fb75becd0ce	183676a5-585b-4a73-8fa2-fc2ab2bfdd3b	2025-06-16 07:47:21.651	SKIP
ef49e420-dd0e-41b7-af23-374e2a7e6d97	8646f09e-19f4-43b4-adbe-bbc8f81aecaf	433c3bc9-a015-40e9-9c6b-3ad048173d62	2025-05-05 19:42:55.411	IGNORE
d518edd7-dae8-4c81-9ad4-d10ba4da6830	49415e3a-20ce-4182-9494-890a0662f3b8	cbc94dbc-a350-4d05-87cd-22936eac1bcf	2025-05-29 12:38:07.879	IGNORE
c3f74e7c-3fbe-4f38-8a11-73028e5d1d6f	27742407-202e-4138-9060-14bc97dcae32	9982de8b-8c22-4f36-a2bf-3c390cd42cc9	2025-07-19 12:32:11.894	SKIP
a68c5392-b6b2-4a6e-97a6-690041720c69	07a158aa-17e6-4253-99c3-55b8adb2b8af	87ba3c63-933d-4499-acc2-c6641e9507ef	2025-01-15 04:29:04.677	CLICK
51cc94dc-3891-49f7-9173-c324c3b480a5	4a63c183-780d-4c35-894f-313cc22e4d97	ff3ee26d-4515-4a8a-8d4d-85d73cf11de8	2025-01-05 23:36:04.501	IGNORE
0d135199-24d7-49ce-8e67-a310818d6e92	1f6fa398-426d-4df7-9abd-9fd065711296	84db1722-55c8-471e-b95d-bbbfa27e1188	2025-01-01 07:52:38.67	SKIP
fd4929bd-2f0f-4a3a-9b2c-ddb8275a7a71	348859f3-1a1b-4271-afba-d9c4ced20677	bf23d233-c249-4df1-af64-cb013a761d3e	2025-05-09 09:06:58.839	IGNORE
b3c33ba1-429f-440b-8235-cd947a8ca6e5	07a158aa-17e6-4253-99c3-55b8adb2b8af	87ba3c63-933d-4499-acc2-c6641e9507ef	2025-01-05 01:18:08.164	COMPLETE
8397d088-a0c1-4822-83f5-7c223e6beda8	146455a8-9108-4573-b07e-112230b46a64	dcf57974-94ad-4243-9e49-2ec82009d8fc	2025-07-28 09:45:18.854	SKIP
448b9ac6-4515-4cd5-bbbb-8a51a5e3db7b	2a37c6b4-5f78-448b-91d4-ae7d86c014a3	56ab4dfa-8380-4b76-bddf-8da4aa3643da	2025-01-22 01:05:58.554	SKIP
facdef02-c030-44de-a41d-b37d6d1334e7	eebd6522-8c92-4b75-b2ac-117888f45c07	ad9aa995-52ad-43f6-8b77-196b303bec4e	2025-03-06 05:20:42.153	COMPLETE
e0f36492-d21e-4565-9195-2a615eb1e90e	3c8ecfc5-693f-434c-97e9-85bfa5b7b65f	a992dcb6-8411-4cd3-91c3-49ddb33a84f7	2025-03-20 23:42:38.516	IGNORE
fa20fb2d-4a7f-4522-915c-778979cd6558	566b1ab4-c44c-4064-915d-17fd293fd8fe	184bde8f-cb40-41dc-bf0f-768836a69d3e	2025-01-07 22:57:27.101	COMPLETE
582a5b7b-d638-4499-b1a5-8ae5970b4629	1f6fa398-426d-4df7-9abd-9fd065711296	84db1722-55c8-471e-b95d-bbbfa27e1188	2025-01-08 06:53:51.689	IGNORE
\.


--
-- Data for Name: Profile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Profile" (id, "userId", "assignedAt", "profileType") FROM stdin;
1f4f9cd9-f7cd-48e7-84e1-0f3796f9e399	07a158aa-17e6-4253-99c3-55b8adb2b8af	2025-08-15 15:26:40.09	ECO_EXPERTO
1e2dd45c-6510-4c3f-80ea-1e24821cba41	09e1c88c-3c59-4b6c-b4f8-c8b3661e9734	2025-08-15 15:26:40.09	ECO_AVANZADO
c0ac9fc2-069d-4a45-acaf-e90de555d814	a17fe986-04f7-4803-a31c-714b5b2aa114	2025-08-15 15:26:40.09	ECO_EXPERTO
042b3689-4717-456f-a402-a725d05de1df	566b1ab4-c44c-4064-915d-17fd293fd8fe	2025-08-15 15:26:40.09	ECO_AVANZADO
f268803c-0a8a-4a70-9319-66c901739677	76a664a4-f686-4144-ab24-b73c5e1db0d1	2025-08-15 15:26:40.09	ECO_AVANZADO
a35ebe2f-ac12-4b4e-95c9-628e3d89977c	2e88c7a5-a7ec-4f96-942e-040432c4096e	2025-08-15 15:26:40.09	ECO_AVANZADO
e3137c0b-63a7-4589-8d78-202e50cc2c4f	7c694e61-7593-4915-9313-19faf7c25ce8	2025-08-15 15:26:40.09	ECO_EXPERTO
5d9236c7-d6f7-4e41-b8d6-0a4a95abe66b	7398e721-7e7c-4fb0-b336-1e57d037d3a2	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
d34afbc4-9a12-4924-9c35-fa8f7196352b	fa53c5ef-5279-4c03-9c38-182e449b0a6e	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
a4c61ee4-864a-4f19-a330-17b712bcae93	25ea81f4-284c-436b-97c9-3dab308c5d38	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
0813b77c-70cc-4044-8860-4b549744e51c	80ba1c5d-5853-4805-af7b-948a86336c85	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
6441c181-c318-44ee-8dc3-f62d02c8cfa3	450f776b-f333-45b6-9fa9-01ea966b2650	2025-08-15 15:26:40.09	ECO_AVANZADO
c0588570-b5a6-43c1-b2f6-a019238b819f	31fbf48b-2c1d-442f-b7fb-9bd4bc7228f2	2025-08-15 15:26:40.09	ECO_EXPERTO
1fa6f4ea-d143-4687-9352-a68e23034258	9aa0637f-3f77-49ac-938b-0fb75becd0ce	2025-08-15 15:26:40.09	ECO_AVANZADO
28c614b5-f4e3-4f56-bfdb-423cbfd56636	3a8f361f-6aed-4290-be3d-5a2c4f26d6c3	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
c86c9e71-8706-45f9-bd63-767fd50e656f	7d382649-5c6a-4b86-a941-eee8373e7e37	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
3b5391d5-fd64-4cdc-8dbf-8f4eeda261fe	c0f83971-4552-4a09-ab3e-30326d7636ae	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
ed7d7dbd-3084-46f1-a2c8-4641377a201c	850dc0c6-7e82-4726-aa43-ea9b4b39755c	2025-08-15 15:26:40.09	ECO_AVANZADO
2b18d841-c9bc-4427-a74a-10fd94b5c437	f9d7941a-a236-41c3-a248-bc1443744b90	2025-08-15 15:26:40.09	ECO_EXPERTO
763aa570-449d-4153-bdb1-b28e2723e040	dc52d013-ebc6-41d2-9e61-e955dfa73832	2025-08-15 15:26:40.09	ECO_EXPERTO
143881fb-2a2f-4a66-b24f-12be4327c228	d4efcbfc-3929-4ec4-affd-8339d36380fe	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
6c28a6b3-71ca-4435-ac47-be8262cfd93a	2dd413cd-f04c-4ad3-8285-baa2ac950201	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
d6f73816-761e-45a2-9840-c1aa04ea69d9	56201644-9405-4c2e-954b-9b018d54f70e	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
291b501b-684a-4fbf-b0ec-e26b1ae89360	ef28a16d-590b-4cf3-b361-2b8b1a315d84	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
ad70e595-4bdf-43c7-8f29-0645df19d438	acdf07ba-8748-43f5-a49b-11d7d42e18d4	2025-08-15 15:26:40.09	ECO_EXPERTO
e06ddb38-aafc-4c60-b688-fb65e3ec6a88	450f07af-fe20-4fc2-9ffd-cffb5472da92	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
ea8655e4-2790-472c-ac8a-ee5a71618601	8d92d664-c512-4941-a2f1-67d00b466f1c	2025-08-15 15:26:40.09	ECO_EXPERTO
c31665e2-4ed8-413d-b9b3-80417d46bf21	68f2ce35-6a69-4214-912c-2afb5a2c390c	2025-08-15 15:26:40.09	ECO_EXPERTO
976267ea-0dda-4563-9cdb-0e9c04f3333c	a2aebe09-baa9-4ce6-8dfe-42f8e67149f7	2025-08-15 15:26:40.09	ECO_EXPERTO
5be9862d-0e25-4b69-bdb9-d8e147081242	2a9c0b7d-cfba-4b4f-b4b0-86ce8ff0549b	2025-08-15 15:26:40.09	ECO_AVANZADO
8174ba7a-599b-4712-a28c-5d6535073f63	19d79485-3c03-4bc5-be76-8d53d577bec8	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
c48213e1-2bb4-47db-8693-553e8bf68d97	02f0a16d-51d8-42cb-af77-ae8c5bb8decb	2025-08-15 15:26:40.09	ECO_EXPERTO
46ea67cf-6601-4bac-90da-8a0b75cad761	090abdf7-69a6-4a1c-b5f7-43e0dbedd16c	2025-08-15 15:26:40.09	ECO_AVANZADO
9c6e8ca8-ef53-49aa-95f8-c4da52227e8b	b17490b4-b072-4269-af64-7cd2ba191257	2025-08-15 15:26:40.09	ECO_AVANZADO
9afbcab7-0432-4c27-a842-e064994ab0d4	f4e1c4f2-3ab1-4c8b-9290-91984cd5f08c	2025-08-15 15:26:40.09	ECO_AVANZADO
759fe637-85e4-4647-85cd-eceac835bf39	ff44e113-5641-46f4-877d-6ad37245de3e	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
af47674c-7429-494f-b40f-406ad967417d	348859f3-1a1b-4271-afba-d9c4ced20677	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
952b4112-4bb4-42d6-abfe-a5f633a3e9fe	ffbefed1-7883-4ff3-9663-873e2f3523d8	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
55a6c8e7-111b-45d6-866a-e107f8705688	b5d96efc-26b0-48c1-92c5-bd6fd4da8916	2025-08-15 15:26:40.09	ECO_EXPERTO
b4140845-5500-4dda-8682-d0af0209885b	adddbc81-54c2-43a4-a867-a4f401b09837	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
8e820658-c2cb-4aab-b5f3-1fb501bd61fc	d45f77bd-83c3-40b0-800e-5a4e75125b18	2025-08-15 15:26:40.09	ECO_AVANZADO
ea6ca4b4-70e8-48c6-8b75-afbeae93d13b	7c0863f9-2095-4d71-bde4-0f7ff8d7d579	2025-08-15 15:26:40.09	ECO_AVANZADO
44fac079-8874-4b3b-bf16-242d03286e02	0cef0cd5-3646-4d8a-a1d6-aae18db552a8	2025-08-15 15:26:40.09	ECO_PRINCIPIANTE
3863ebd4-aa03-4842-a9e9-973ae6741d7e	67bb89ad-20d6-4085-ad7f-f2d2bbfec157	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
96e7fb2e-3f45-4ab7-b086-cd57f3e1320b	3c8ecfc5-693f-434c-97e9-85bfa5b7b65f	2025-08-15 15:26:40.091	ECO_AVANZADO
29164c06-aff0-478b-8612-4641efaf6971	2a37c6b4-5f78-448b-91d4-ae7d86c014a3	2025-08-15 15:26:40.091	ECO_EXPERTO
bb2bfb71-27ea-47cb-ac67-93c1840e7b1d	78c5e624-8657-42a8-b3aa-165320d83b37	2025-08-15 15:26:40.091	ECO_AVANZADO
05b8307d-2123-47f1-96c0-602fa208845a	cf845157-b14d-4374-834e-dd9761d31b7b	2025-08-15 15:26:40.091	ECO_AVANZADO
ee912027-320e-4707-ad1b-9f53cdddb113	8646f09e-19f4-43b4-adbe-bbc8f81aecaf	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
9977f5d9-57d2-4270-8e87-50acf2528233	2cc9cf09-964f-441e-8751-d8969ccb2764	2025-08-15 15:26:40.091	ECO_EXPERTO
305727e1-c881-4e7a-9a32-bb54787f0071	b82af3ea-28ce-4244-a109-328e4fc06aab	2025-08-15 15:26:40.091	ECO_AVANZADO
3c21798e-dc4f-405f-8e1c-aa302e0ff63b	327ebe21-a586-4dae-9037-163a7c33320f	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
01294cdf-5051-47a2-8813-c7f126c79f63	5787a18e-0468-4b0d-ad49-a6ff0e7a2a5e	2025-08-15 15:26:40.091	ECO_EXPERTO
24705156-7a8d-44ca-9dc4-e7a615d546dd	c805a7fe-c3be-450f-96e7-b70e966a4d95	2025-08-15 15:26:40.091	ECO_AVANZADO
e3cb25ea-1b95-47a0-a3f8-a15c8784ab92	70931e79-3d99-4b89-9d61-1df877e2a477	2025-08-15 15:26:40.091	ECO_EXPERTO
1fb1c34d-5145-426b-b1ab-2a7ead1b4b4d	acff4c16-632f-4e9e-942e-5bd52b7efdad	2025-08-15 15:26:40.091	ECO_EXPERTO
4ca56ded-644a-41f9-9985-963193e68192	4176b2d6-8aa6-4b9d-b248-73e177495bf0	2025-08-15 15:26:40.091	ECO_EXPERTO
d4af0879-ede9-45ef-9cdc-df3260b0bb03	69a7e08e-bd64-4e23-8e57-e2ab6914a01a	2025-08-15 15:26:40.091	ECO_AVANZADO
99f75584-7eb8-4a5e-a5d6-8796134445fc	6c586ea7-283d-4f72-95af-90917d213646	2025-08-15 15:26:40.091	ECO_EXPERTO
6514264a-4021-4e3d-a664-931aae7be9fc	9b9bc092-95fe-436a-b168-6a23874139a3	2025-08-15 15:26:40.091	ECO_AVANZADO
0de71b8d-e50a-423f-b169-0c8cd90a635e	eebd6522-8c92-4b75-b2ac-117888f45c07	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
9ba9084b-475c-4818-94fc-0ed5feaa0490	663889ef-ce84-4a27-b04f-b8d094aede9e	2025-08-15 15:26:40.091	ECO_AVANZADO
69933f7e-3303-4bb4-9507-c5d11a919eab	e21c2c72-95e0-45fc-b1cd-d8a11d9a070e	2025-08-15 15:26:40.091	ECO_AVANZADO
93adfa50-8b28-4460-bccc-a088e06faced	68040bde-d2ba-453c-9a4c-b182412ec0ab	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
fb4a0251-86b8-4159-b625-3f8651642485	ae757d52-4b9c-47b9-9d66-6e7fe35a5723	2025-08-15 15:26:40.091	ECO_AVANZADO
74337f90-1b05-4989-835a-fe0b68eae726	cc114cdd-3100-4a02-b02b-0fb66a5002e4	2025-08-15 15:26:40.091	ECO_AVANZADO
4326148b-f2b9-4f4f-9303-d89d4056265d	af78e980-6d06-4cef-858d-674a7d0599b6	2025-08-15 15:26:40.091	ECO_EXPERTO
f1327293-1429-4a00-870e-05f0ff7b65f9	cf65f9bf-fd9a-4c33-8611-9b0ad26c7cb8	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
e132df19-fac0-4e1c-ab35-6f13d41a08ab	d408932d-4d13-44a8-a0a2-110e9a1257d0	2025-08-15 15:26:40.091	ECO_EXPERTO
70f91607-fa10-466b-b09f-65e33c28a531	1e0102ac-003f-4238-a83f-a232d73f36ca	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
4aee2f22-d808-4782-befe-f3c4d7e3b7e5	0f5e6db5-55c8-4090-8110-3583c7061d3d	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
c4fa96fd-acf5-4fd8-af8c-0b62a19b30f3	59b8d0df-df23-4034-847d-46d2fa87f4a5	2025-08-15 15:26:40.091	ECO_AVANZADO
09e69e7d-8f9b-48b5-88da-18b310b049ec	1f6fa398-426d-4df7-9abd-9fd065711296	2025-08-15 15:26:40.091	ECO_EXPERTO
d0073865-c2c0-4810-9381-ca4a2fd2b240	27742407-202e-4138-9060-14bc97dcae32	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
b0a972db-9093-4902-a22c-129f2da8ac6f	aadb26b1-fb13-4763-b834-612f4ae94167	2025-08-15 15:26:40.091	ECO_EXPERTO
6b63fff5-b111-4aab-ac08-215f18529536	cf299fa8-6b3f-4512-b377-0195a970bf89	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
c115e85b-d42c-46c2-a900-366d706cb282	f173ce5a-db72-4470-822f-23dfd80f69a2	2025-08-15 15:26:40.091	ECO_AVANZADO
c82086c6-1c2c-4fa5-b399-d080aaa12f90	addb7aff-6ce8-4f1d-93bb-973339eb84cb	2025-08-15 15:26:40.091	ECO_AVANZADO
5f6e2891-9339-43a0-8330-5fe48812e0e5	b71d9a0f-f721-4d41-a72e-24dfd092b1a9	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
86f698c1-ff66-4297-970e-33844dce0be1	4b66958b-5d27-4fff-b24d-8feb9ddfb281	2025-08-15 15:26:40.091	ECO_AVANZADO
cb2a854c-7962-4249-a9f0-e58393ccb5d1	e6301ffb-5fb3-44a9-9667-cd20918bd62e	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
7a311b75-1498-4688-9d44-7d1e5cafc610	49415e3a-20ce-4182-9494-890a0662f3b8	2025-08-15 15:26:40.091	ECO_EXPERTO
29d707fc-5a1f-4038-8107-7bc40a2570f3	51809b00-0738-4179-8f30-647c2b6fe6a6	2025-08-15 15:26:40.091	ECO_AVANZADO
b52e785a-7087-4138-b085-0ac86ed34b3c	3cb168c8-0a31-40b4-bb74-1221658cd6be	2025-08-15 15:26:40.091	ECO_EXPERTO
46ee130a-6b57-41a1-aba0-f42644dc9672	3021c1cd-8e20-4a6e-a64f-97bbd933c5a1	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
c20ba2bd-c584-4b21-989c-833d075ba1fa	146455a8-9108-4573-b07e-112230b46a64	2025-08-15 15:26:40.091	ECO_EXPERTO
255f9810-4d05-4aef-96e3-5e7145cd963b	3da3968a-b294-4344-806b-3887bd52db3c	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
97f47463-4c94-477d-86d5-31fb3767a0c3	1318d3f4-84b9-40d9-9ea3-88bd13e88605	2025-08-15 15:26:40.091	ECO_AVANZADO
b63ab790-ab48-4e31-9854-9a0624fec736	0f5b75c3-4ad1-41dc-a172-0999d3c561b3	2025-08-15 15:26:40.091	ECO_EXPERTO
05e109fa-bb5a-461a-a119-05e1b7eb45b4	482f8a8a-0859-4ff9-861f-8157dffc48cd	2025-08-15 15:26:40.091	ECO_AVANZADO
7b28d6f4-0f21-4026-b181-787a074f9ad9	2da991c1-c44c-4891-8363-3cfdf3cfeacf	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
9986f712-e75b-4cad-8b50-a70cde475693	4cae9e0b-d9a4-4aa6-aa93-4caf2970d782	2025-08-15 15:26:40.091	ECO_AVANZADO
a91f34ba-7935-49b6-afb9-7a2d370f32e4	c0011e62-6757-47a0-95c0-cd56c3dc18c8	2025-08-15 15:26:40.091	ECO_EXPERTO
d2f83b8a-fca3-4a9d-9dda-dea9423416f4	11f16c31-6440-41ee-8de8-45994231c1b1	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
78ee3a65-4574-4599-ba92-f6c8cf036c9b	46d0e032-16f1-4ac3-8f72-bbb55ff78af1	2025-08-15 15:26:40.091	ECO_AVANZADO
593f1662-9fe6-4520-a3d8-c2b42078c8e7	f2b22ef5-8c66-42c6-86fb-020165c66931	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
3df2c3f6-5890-46c4-af53-1f2815ef1e0b	8873c9f7-2922-459d-b305-17235215272b	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
a48f454d-9681-4309-8dd5-e5896d747177	d9816c90-2dbe-4145-89bc-dee429826d66	2025-08-15 15:26:40.091	ECO_AVANZADO
10879eca-1c6c-4f97-bc84-4e46b6415480	a60306a6-2aca-4709-a151-558c0cc96afc	2025-08-15 15:26:40.091	ECO_AVANZADO
b07a9a89-b92c-445b-a99b-069270e41fb2	4a63c183-780d-4c35-894f-313cc22e4d97	2025-08-15 15:26:40.091	ECO_PRINCIPIANTE
\.


--
-- Data for Name: Recommendation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Recommendation" (id, "userId", message, "createdAt", "shownTime") FROM stdin;
c5106c51-c716-49c9-80ed-23901e5bb365	adddbc81-54c2-43a4-a867-a4f401b09837	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
3d9c2729-73df-4441-9b47-c7ddded7241a	80ba1c5d-5853-4805-af7b-948a86336c85	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
4da67a7e-d455-4d3e-bacc-b41b023e0cc4	d9816c90-2dbe-4145-89bc-dee429826d66	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
90ac5f54-2ec4-48b7-8fda-7be6dfd5a9a6	1e0102ac-003f-4238-a83f-a232d73f36ca	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
e4fedce8-aba6-40fd-85d1-7801f348ad7b	3a8f361f-6aed-4290-be3d-5a2c4f26d6c3	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
4c3be5f8-1df7-40a6-ae9d-4df2dabf3dcf	fa53c5ef-5279-4c03-9c38-182e449b0a6e	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
9982de8b-8c22-4f36-a2bf-3c390cd42cc9	27742407-202e-4138-9060-14bc97dcae32	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
bf23d233-c249-4df1-af64-cb013a761d3e	348859f3-1a1b-4271-afba-d9c4ced20677	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
863bcb87-77b2-4891-89a8-67dfd4d0408f	3a8f361f-6aed-4290-be3d-5a2c4f26d6c3	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
1f66db9d-d5f9-4e6b-b051-1eb133d7c825	f173ce5a-db72-4470-822f-23dfd80f69a2	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
f62ac203-6043-4123-b4a1-15554c75852b	b5d96efc-26b0-48c1-92c5-bd6fd4da8916	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
57292bd6-d425-4ad8-9904-54a49c258223	addb7aff-6ce8-4f1d-93bb-973339eb84cb	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
8e4d3a3a-7c17-4b0d-9443-e1aaae032a95	acff4c16-632f-4e9e-942e-5bd52b7efdad	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
184bde8f-cb40-41dc-bf0f-768836a69d3e	566b1ab4-c44c-4064-915d-17fd293fd8fe	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
cfa2ad5c-092d-4a42-a9f8-64bdb66070a5	25ea81f4-284c-436b-97c9-3dab308c5d38	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
3529d9a6-5008-4dcc-9410-de094d90f393	19d79485-3c03-4bc5-be76-8d53d577bec8	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
f6b16a66-d816-4a4d-a8ba-ce456a2931c8	7398e721-7e7c-4fb0-b336-1e57d037d3a2	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
29407f90-e74a-4a0a-b5de-2bf017544dd9	9b9bc092-95fe-436a-b168-6a23874139a3	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
1bf4765e-1c19-41db-84d0-9ca05a69783d	3a8f361f-6aed-4290-be3d-5a2c4f26d6c3	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
d7c18299-28d5-464d-807e-95bc1eefb90b	4cae9e0b-d9a4-4aa6-aa93-4caf2970d782	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
dcf57974-94ad-4243-9e49-2ec82009d8fc	146455a8-9108-4573-b07e-112230b46a64	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
e9ccde33-aedf-428f-92b4-f48264522047	76a664a4-f686-4144-ab24-b73c5e1db0d1	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
5123d4d2-a2a5-4b38-bdaf-761e865e7927	af78e980-6d06-4cef-858d-674a7d0599b6	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
423e0f6f-afab-41ec-b730-5150a0cea5dc	eebd6522-8c92-4b75-b2ac-117888f45c07	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
7f6c8b62-fa78-4ef9-be5f-76706c2d9293	b71d9a0f-f721-4d41-a72e-24dfd092b1a9	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
dc0ca2ef-3afc-43c3-8ac1-3c2ac7fef94c	76a664a4-f686-4144-ab24-b73c5e1db0d1	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
56ab4dfa-8380-4b76-bddf-8da4aa3643da	2a37c6b4-5f78-448b-91d4-ae7d86c014a3	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
a68aa85b-da11-4511-9479-3e72b2a21fd5	8873c9f7-2922-459d-b305-17235215272b	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
b628ae57-3338-447e-bab1-acbd00b666f7	5787a18e-0468-4b0d-ad49-a6ff0e7a2a5e	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
b1b20bca-2044-4727-9ab8-7f7bbba7444a	1e0102ac-003f-4238-a83f-a232d73f36ca	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
be4bfab1-1667-4ec3-9c97-cd3ae67b2dd6	9b9bc092-95fe-436a-b168-6a23874139a3	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
1437740c-80c9-4e18-a296-05bfcd8a9e9e	78c5e624-8657-42a8-b3aa-165320d83b37	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
3f5376ff-fcd9-4588-b0ad-31b27e4d546d	56201644-9405-4c2e-954b-9b018d54f70e	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
f95aa146-fb70-4d6f-b576-d8838588ef5c	80ba1c5d-5853-4805-af7b-948a86336c85	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
704f2289-9d48-4a3d-a54d-4bbaeaa3191f	3021c1cd-8e20-4a6e-a64f-97bbd933c5a1	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
2280520d-709e-4222-8183-f6fd635cdbac	70931e79-3d99-4b89-9d61-1df877e2a477	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
2120cbc5-8ac6-4724-b469-4af39d43a874	2a9c0b7d-cfba-4b4f-b4b0-86ce8ff0549b	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
31f82498-0807-4332-909f-6d13af621880	ae757d52-4b9c-47b9-9d66-6e7fe35a5723	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
6217825b-604b-4507-8a15-81060c601b58	76a664a4-f686-4144-ab24-b73c5e1db0d1	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
2ee57ca4-0cc0-4a90-8423-64f22e617a40	11f16c31-6440-41ee-8de8-45994231c1b1	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
3e9c9737-05f6-4ccb-b674-7d82b95774ce	acff4c16-632f-4e9e-942e-5bd52b7efdad	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
1293f9de-7080-4b5a-b935-9cece9461c68	7c694e61-7593-4915-9313-19faf7c25ce8	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
cccbcbdc-c35d-4e69-945e-07c2441ed869	adddbc81-54c2-43a4-a867-a4f401b09837	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
c1cdd797-7053-43ed-b4e6-51bfded39e25	1f6fa398-426d-4df7-9abd-9fd065711296	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
08d55d64-2cb2-4a36-812a-e05d47abb661	4b66958b-5d27-4fff-b24d-8feb9ddfb281	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
32ab65f6-2a60-4a82-8c08-68bdb9785097	7d382649-5c6a-4b86-a941-eee8373e7e37	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
845663ce-9628-43b6-8d5b-f22ba6efd788	25ea81f4-284c-436b-97c9-3dab308c5d38	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
433c3bc9-a015-40e9-9c6b-3ad048173d62	8646f09e-19f4-43b4-adbe-bbc8f81aecaf	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
5c2465a8-bab5-4172-8f35-5e34e9372e2d	8873c9f7-2922-459d-b305-17235215272b	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
6db95631-21b2-478c-97d3-d0256361863e	68f2ce35-6a69-4214-912c-2afb5a2c390c	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
d1e789eb-53ce-43e7-a30b-70360bc772f1	a60306a6-2aca-4709-a151-558c0cc96afc	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
ab747460-8350-4def-a021-3738fb267581	49415e3a-20ce-4182-9494-890a0662f3b8	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
48aeeb7f-755f-4ca6-b90f-22f4eff7810f	0cef0cd5-3646-4d8a-a1d6-aae18db552a8	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
ae3aac82-47eb-4616-b9af-9f09b61425ae	d4efcbfc-3929-4ec4-affd-8339d36380fe	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
f07be3e2-7f23-40b1-bfc0-8e4b580f814f	eebd6522-8c92-4b75-b2ac-117888f45c07	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
7da4d4e8-6147-4267-b010-90a511b0cec9	8873c9f7-2922-459d-b305-17235215272b	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
84457037-dee5-4160-9b32-82f23538482b	5787a18e-0468-4b0d-ad49-a6ff0e7a2a5e	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
a5812b98-9c44-4618-9d0c-3fdd25dbbcc4	19d79485-3c03-4bc5-be76-8d53d577bec8	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
88f355e6-fb2f-45c9-b7e5-013c42e85a9d	d45f77bd-83c3-40b0-800e-5a4e75125b18	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
2221c5e8-0c8e-4514-87ef-2f0c38f19ab1	f2b22ef5-8c66-42c6-86fb-020165c66931	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
b250d476-0fab-4608-a5c1-6a797446a0fd	0cef0cd5-3646-4d8a-a1d6-aae18db552a8	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
729ef5dc-2df0-4968-b086-1562151d8e9d	acff4c16-632f-4e9e-942e-5bd52b7efdad	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
43e0d33d-2730-4921-812e-ed5668ed88f0	d408932d-4d13-44a8-a0a2-110e9a1257d0	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
6d389bf3-32bc-4b8c-92c0-962a8be45a08	b71d9a0f-f721-4d41-a72e-24dfd092b1a9	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
4971858a-9ff0-4eac-83d3-bfda419cf45e	450f07af-fe20-4fc2-9ffd-cffb5472da92	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
40b8bd46-a811-4aa0-8d89-0f6f0a6b62ed	51809b00-0738-4179-8f30-647c2b6fe6a6	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
87ba3c63-933d-4499-acc2-c6641e9507ef	07a158aa-17e6-4253-99c3-55b8adb2b8af	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
55d34bd3-9079-470d-b96d-e36faee1b8cb	d9816c90-2dbe-4145-89bc-dee429826d66	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
08f306a6-da3f-47b2-8d9c-ef7d6d330361	acdf07ba-8748-43f5-a49b-11d7d42e18d4	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
90bec4dd-bb13-4b62-8ee8-df6fbc8b1506	f2b22ef5-8c66-42c6-86fb-020165c66931	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
84db1722-55c8-471e-b95d-bbbfa27e1188	1f6fa398-426d-4df7-9abd-9fd065711296	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
096b5ed7-7bec-4cf3-b2d9-99aff2486535	9b9bc092-95fe-436a-b168-6a23874139a3	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
32deb427-4010-4d9d-baff-fd2a10494c5a	02f0a16d-51d8-42cb-af77-ae8c5bb8decb	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
2aae425b-504f-47c0-aa40-749eb1846f71	78c5e624-8657-42a8-b3aa-165320d83b37	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
773c4fce-e58a-4d07-822d-e1173bef39fe	cf65f9bf-fd9a-4c33-8611-9b0ad26c7cb8	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
d92942e6-a209-4ab6-b13b-5a05ab46239f	0cef0cd5-3646-4d8a-a1d6-aae18db552a8	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
1a9516dc-dabb-45db-8acd-4c9b1909a897	d45f77bd-83c3-40b0-800e-5a4e75125b18	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
8742ac52-7804-462d-9e0c-f90cbc7deab1	8646f09e-19f4-43b4-adbe-bbc8f81aecaf	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
57a1a43b-608e-4224-a7ae-af29323027a3	f9d7941a-a236-41c3-a248-bc1443744b90	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
3cdd6f74-31b9-4809-a02d-f30118bfbb69	850dc0c6-7e82-4726-aa43-ea9b4b39755c	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
c29e683b-60e8-4307-8380-d1118dd16b4b	25ea81f4-284c-436b-97c9-3dab308c5d38	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
24aab65d-9553-4cf6-9cc9-b8fae8c0a242	25ea81f4-284c-436b-97c9-3dab308c5d38	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
478528a5-136f-435c-96e4-e1b69524bd14	d9816c90-2dbe-4145-89bc-dee429826d66	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
ad9aa995-52ad-43f6-8b77-196b303bec4e	eebd6522-8c92-4b75-b2ac-117888f45c07	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
a992dcb6-8411-4cd3-91c3-49ddb33a84f7	3c8ecfc5-693f-434c-97e9-85bfa5b7b65f	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
978d9571-8b5b-4569-ad98-e0221f3dab8c	b17490b4-b072-4269-af64-7cd2ba191257	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
5bcd4ad6-14ac-496a-a9ea-943a38143941	8d92d664-c512-4941-a2f1-67d00b466f1c	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
cbc94dbc-a350-4d05-87cd-22936eac1bcf	49415e3a-20ce-4182-9494-890a0662f3b8	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
ff3ee26d-4515-4a8a-8d4d-85d73cf11de8	4a63c183-780d-4c35-894f-313cc22e4d97	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
e2196b6b-196f-4654-983c-58b851b5b482	68040bde-d2ba-453c-9a4c-b182412ec0ab	Hora de apagar las luces	2025-08-15 15:26:40.1	09:26
59f7c36d-2caa-4aa4-88e7-1ddf714225fe	f173ce5a-db72-4470-822f-23dfd80f69a2	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
183676a5-585b-4a73-8fa2-fc2ab2bfdd3b	9aa0637f-3f77-49ac-938b-0fb75becd0ce	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
e967e032-24c3-45b1-bd46-86377b7dd543	ae757d52-4b9c-47b9-9d66-6e7fe35a5723	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
f875bbb9-c7d4-4516-a8fa-de57d122353a	c0011e62-6757-47a0-95c0-cd56c3dc18c8	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
8e0d0a93-74b9-46bd-a7bb-a3faf7fd6292	8d92d664-c512-4941-a2f1-67d00b466f1c	Evita usar bolsas de plastico hoy	2025-08-15 15:26:40.1	09:26
cd944c0a-b85a-43e8-9eed-c9ab0e29715b	3a8f361f-6aed-4290-be3d-5a2c4f26d6c3	Desconecta los aparatos que no uses	2025-08-15 15:26:40.1	09:26
01db0742-0118-4a95-8b0a-1d71fc0f34ee	f9d7941a-a236-41c3-a248-bc1443744b90	Hora de caminar en lugar de usar el coche	2025-08-15 15:26:40.1	09:26
746d285c-9d4c-4055-830a-b07d43199ab2	327ebe21-a586-4dae-9037-163a7c33320f	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
9a3655f8-4029-4e59-be58-c186d3f416bd	f2b22ef5-8c66-42c6-86fb-020165c66931	Recuerda llevar tu bolsa reutilizable	2025-08-15 15:26:40.1	09:26
16a4b291-1f51-4895-8864-ebebb550c98b	02f0a16d-51d8-42cb-af77-ae8c5bb8decb	Recuerda cerrar la llave del agua	2025-08-15 15:26:40.1	09:26
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."User" (id, name, email, age, "createdAt", region, password, role) FROM stdin;
11f16c31-6440-41ee-8de8-45994231c1b1	Hilda	hilda58143@mail.com	18	2025-08-15 15:26:34.442	CDMX	$2b$10$9zip0W1O5.KFAtUTIYnaVedPqvo0T7ECKaRh7.2piiwK.UDWr8KWO	COMMON
d408932d-4d13-44a8-a0a2-110e9a1257d0	Lourdes	lourdes98862@zoho.com	37	2025-08-15 15:26:34.498	CDMX	$2b$10$an5MoS46QqnsnimXAY3yVeu3BH7Dg4JPTOX.jFOnyGlelOm6Zen.W	COMMON
27742407-202e-4138-9060-14bc97dcae32	Viviana	viviana99434@empresa.com.mx	34	2025-08-15 15:26:34.555	CDMX	$2b$10$y0cEVxe9nxztGDYO2KvZ6uS78TxHzEM8L6bf7zGWnJ.SXI0iqFz.C	COMMON
b71d9a0f-f721-4d41-a72e-24dfd092b1a9	Norma	norma94424@icloud.com	21	2025-08-15 15:26:34.612	SURESTE	$2b$10$Wnf0BnPXZEdBeX.Ysv/6BOUDtyQhZbF.8KPsW154ZUfMwpDQAYyfu	COMMON
d9816c90-2dbe-4145-89bc-dee429826d66	Amalia	amalia43402@prodigy.net.mx	23	2025-08-15 15:26:34.668	CENTRO	$2b$10$SHxOr2vwfu7azRCR2JsEsOlKuivgqDeTunCXE1/GhuXyOHrtqvJqa	COMMON
3da3968a-b294-4344-806b-3887bd52db3c	Blanca	blanca65823@unam.mx	31	2025-08-15 15:26:34.726	SURESTE	$2b$10$FLHunzlhtMVB/GT.xBAFmuPzgS4fgkNCQeiEwkicYqZUYrgOtxjiq	COMMON
fa53c5ef-5279-4c03-9c38-182e449b0a6e	Lisandro	lisandro21880@zoho.com	64	2025-08-15 15:26:34.785	SURESTE	$2b$10$A/xXFyWTCIlQ1KtVMo44Yu5aP3G8itpaIepE7eaFceryLKqNqyH/m	COMMON
d4efcbfc-3929-4ec4-affd-8339d36380fe	Fabiola	fabiola72677@icloud.com	44	2025-08-15 15:26:34.842	OCCIDENTE	$2b$10$jMScIBDIF5RFAGFul/6v6epONmY2jcPEefp5fz0LDH4evwnzGcWkG	COMMON
1e0102ac-003f-4238-a83f-a232d73f36ca	Jessica	jessica46564@consultores.com	32	2025-08-15 15:26:34.898	SURESTE	$2b$10$rDFp.foz4sUCWAY4.L9khOzLF3N..OHyhPhCfXAJlye/13Dk63wva	COMMON
3cb168c8-0a31-40b4-bb74-1221658cd6be	María	maria63488@udg.mx	64	2025-08-15 15:26:34.955	SURESTE	$2b$10$fiIFM4prFWckAM2zyTYwgejxkVeuYpPizi7OK3kFXfFG/Oo4PS7Ie	COMMON
348859f3-1a1b-4271-afba-d9c4ced20677	Marisol	marisol48884@yahoo.com.mx	24	2025-08-15 15:26:35.013	OCCIDENTE	$2b$10$uQuColUiuj1KXWeDhtBsjeA.LEcmOfvjBMCc9KDBkSG8RURrUUXK.	COMMON
4a63c183-780d-4c35-894f-313cc22e4d97	Jack	jack24538@unam.mx	60	2025-08-15 15:26:35.069	SURESTE	$2b$10$ME6dBUOqEajyFEQeLQ3ckesuIE5xJcfuHdAHGhLQl6aAPibUGxTR.	COMMON
31fbf48b-2c1d-442f-b7fb-9bd4bc7228f2	Elvira	elvira43222@udg.mx	14	2025-08-15 15:26:35.125	OCCIDENTE	$2b$10$1BSaFM0I9IzpF5jbjaTCZ.gbLlZoKpORANK/uf8K7xE2ESw49xh7y	COMMON
0cef0cd5-3646-4d8a-a1d6-aae18db552a8	Cristina	cristina82663@mxmail.com	38	2025-08-15 15:26:35.181	CDMX	$2b$10$eeYMCACnppRFd805VS3avOIJwHKUIwV8X5TyBiAJJssbamCv1APpS	COMMON
cf845157-b14d-4374-834e-dd9761d31b7b	Yael	yael14996@outlook.com	39	2025-08-15 15:26:35.24	OCCIDENTE	$2b$10$NDLeGRbmJVQ6uryCw8kcV.YnuCrTHTw82GI20JSgoS/OM9rInuX06	COMMON
6c586ea7-283d-4f72-95af-90917d213646	Erika	erika262@unam.mx	23	2025-08-15 15:26:35.296	OCCIDENTE	$2b$10$pam51kTcyHM6QA6NlBl9xednZqfoZ9g8ko6qyrzt42915akP7DmQa	COMMON
2dd413cd-f04c-4ad3-8285-baa2ac950201	Eleuterio	eleuterio52763@udg.mx	16	2025-08-15 15:26:35.353	OCCIDENTE	$2b$10$2RXIExVQliEsgL.EqKjKauS5sv.sdWTeltqyMQAfq2DND4N6.5bdS	COMMON
7398e721-7e7c-4fb0-b336-1e57d037d3a2	Velia	velia84033@prodigy.net.mx	66	2025-08-15 15:26:35.411	CENTRO	$2b$10$hEVdgLcBG4cit3rQBW6NRuUci5CYrfBFlbS/8cOHc8ed2sGdjcZP.	COMMON
7c694e61-7593-4915-9313-19faf7c25ce8	Clifford	clifford53185@icloud.com	14	2025-08-15 15:26:35.467	SURESTE	$2b$10$c784.ApFbHvomvx.OEkTB.ApwQUrM4eNfyJIFpIAqeU6mIq7FJFNm	COMMON
69a7e08e-bd64-4e23-8e57-e2ab6914a01a	Benito	benito45687@yahoo.com.mx	35	2025-08-15 15:26:35.524	SURESTE	$2b$10$PtDQ2YkH5lscp5NLCQS6FOjHO.G53Ju0hz44shpaxurQSVyQirKAq	COMMON
56201644-9405-4c2e-954b-9b018d54f70e	Elaine	elaine56516@consultores.com	32	2025-08-15 15:26:35.581	CDMX	$2b$10$3eLvhEIbYt/dkTUA2xi7mei/WH0JBxMX6a/4VKEojw9J0O4jhgrCC	COMMON
ef28a16d-590b-4cf3-b361-2b8b1a315d84	Rigoberto	rigoberto4342@prodigy.net.mx	28	2025-08-15 15:26:35.642	NORTE	$2b$10$HceodO9g.mBE0mGdeitJ0u/BIBQPF3.lwT2ms.qJj1td4/lnReZUu	COMMON
a2aebe09-baa9-4ce6-8dfe-42f8e67149f7	Ulises	ulises43917@prodigy.net.mx	70	2025-08-15 15:26:35.699	INTERNACIONAL	$2b$10$QANvM.HCS3ZZ4r5p2OpbIOxO8WE2.zv6U9H..pN5SJyzIlrmnVpFO	COMMON
ff44e113-5641-46f4-877d-6ad37245de3e	Remigio	remigio20567@prodigy.net.mx	24	2025-08-15 15:26:35.755	NORTE	$2b$10$9GIhvYPs1fJ1cUVfUtUpU.nmu4Hik4xcE2zasWIJpmVfeKfJUHfPG	COMMON
1f6fa398-426d-4df7-9abd-9fd065711296	Martha	martha98694@empresarial.com	31	2025-08-15 15:26:35.812	INTERNACIONAL	$2b$10$TjlKIdgu1k9t/vDtpWny1.g//DNa1kInCAvMYwlBjmT/qO10HiM36	COMMON
e6301ffb-5fb3-44a9-9667-cd20918bd62e	Mónica	monica77367@zoho.com	45	2025-08-15 15:26:35.868	CDMX	$2b$10$lIjfqVknuKwcquJ9m8GhzubdQtg1lBoOeXqYH3y7REJ5l895VNJpm	COMMON
76a664a4-f686-4144-ab24-b73c5e1db0d1	Selene	selene50335@uv.mx	66	2025-08-15 15:26:35.925	NORTE	$2b$10$lZyQa6cdE22WZqTU3hWkNOghPmdxyOOsaVoYejH44Ofq6p.hkYyse	COMMON
cf299fa8-6b3f-4512-b377-0195a970bf89	Magín	magin36479@consultores.com	17	2025-08-15 15:26:35.982	OCCIDENTE	$2b$10$ebdAIPDP0i29aOYwXgUJuu3isLHOeDJXKi3YF9jDw6yOxN5VQwn4.	COMMON
9aa0637f-3f77-49ac-938b-0fb75becd0ce	Luciano	luciano86207@uv.mx	50	2025-08-15 15:26:36.039	CENTRO	$2b$10$jnMYVmTnNpyQKVxzyy3Mee8nU6JMHai9TRoas4FidlNZtTIpMPz0u	COMMON
46d0e032-16f1-4ac3-8f72-bbb55ff78af1	Gerardo	gerardo76331@yahoo.com	35	2025-08-15 15:26:36.095	CENTRO	$2b$10$QRXqVYpXynXyYfItfoGReuW9opWVyZgHalCoatbwWR5Bk7xoqltTu	COMMON
80ba1c5d-5853-4805-af7b-948a86336c85	Zenón	zenon68138@ipn.mx	35	2025-08-15 15:26:36.151	SURESTE	$2b$10$j1t28U6/Udwq7UTFUEk/HuQBmz1zHMCd4/GLjgFNghSbttfjEnA0C	COMMON
addb7aff-6ce8-4f1d-93bb-973339eb84cb	Consuelo	consuelo71286@ipn.mx	45	2025-08-15 15:26:36.208	CDMX	$2b$10$wgKgiEvcmZetnk4O0EPkS.tGLEwJSsSc655qsmX.mNA.DDQ87aarm	COMMON
02f0a16d-51d8-42cb-af77-ae8c5bb8decb	María Isabel	mariaisabel42404@zoho.com	70	2025-08-15 15:26:36.264	INTERNACIONAL	$2b$10$IuVc6W9.fwlrml8HlsDtvuXO1b658wX6.yyxGMehh6y7Mu0amu.kK	COMMON
5787a18e-0468-4b0d-ad49-a6ff0e7a2a5e	Gary	gary51381@icloud.com	44	2025-08-15 15:26:36.321	CDMX	$2b$10$lMgTDE3to.R0e7rooh7Xi.kCRfU3d.0Hr/.Mc7DGHIQUJvtuvco2m	COMMON
4cae9e0b-d9a4-4aa6-aa93-4caf2970d782	Jacinto	jacinto86681@empresa.com.mx	62	2025-08-15 15:26:36.377	CDMX	$2b$10$T4Fu.T9kgnJXuLssOrsn7.Fi9dcesIHn5Et8kSCgvO98PdRlZ0pUK	COMMON
7c0863f9-2095-4d71-bde4-0f7ff8d7d579	Adalberto	adalberto74718@yahoo.com.mx	29	2025-08-15 15:26:36.435	CDMX	$2b$10$IoknG4NoHpHgC4JZMcepIeSyizzTSrC6TS2e6bcZgBoiX0UyGrDme	COMMON
566b1ab4-c44c-4064-915d-17fd293fd8fe	Ariel	ariel57994@gmail.com	64	2025-08-15 15:26:36.491	CDMX	$2b$10$nwNAhs3d6XV7Pjqxc/wPOOOC6JhkRyau6rPBqkLGftUCt5KIpg/de	COMMON
3a8f361f-6aed-4290-be3d-5a2c4f26d6c3	Irineo	irineo54799@live.com	52	2025-08-15 15:26:36.547	CENTRO	$2b$10$qQ3Z4aqN4GdlJytk77qxfePAJK23Ctzuc3lNTG8MizGsLBPdDGjL.	COMMON
aadb26b1-fb13-4763-b834-612f4ae94167	Delio	delio94950@tec.mx	34	2025-08-15 15:26:36.604	CDMX	$2b$10$EQCs5XnzyFBIv2OH.h8U3OfgoV/gU2z5ezZKbBccm.3UKflth.Sya	COMMON
cc114cdd-3100-4a02-b02b-0fb66a5002e4	Marisol	marisol42673@gmail.com	27	2025-08-15 15:26:36.661	SURESTE	$2b$10$UfdUAzK.JnIYXRGVNwBEg./HdnO/..sTUS/veVoJjeT2ArgeGoX6K	COMMON
3021c1cd-8e20-4a6e-a64f-97bbd933c5a1	Brian	brian77079@consultores.com	21	2025-08-15 15:26:36.717	SURESTE	$2b$10$QYdegSOpLJUSZTvjFPgmj.DTE9J/9F/JQNyhqSVRM9BTKIMb/IQLa	COMMON
ae757d52-4b9c-47b9-9d66-6e7fe35a5723	Juana	juana44465@yahoo.com.mx	30	2025-08-15 15:26:36.773	CDMX	$2b$10$RbtKAjzUQsY6EAoMHSSLF.OMv008T7HXpKt7PPGfCI9MawrWqMtxO	COMMON
2e88c7a5-a7ec-4f96-942e-040432c4096e	Zaida	zaida97070@empresa.com.mx	58	2025-08-15 15:26:36.831	CENTRO	$2b$10$tq09.g04h9LpIW2BbeBqbeQSrgiUtAUwb9OF/2XwzJ8dtO.23jDmy	COMMON
c0011e62-6757-47a0-95c0-cd56c3dc18c8	Johana	johana7307@uv.mx	49	2025-08-15 15:26:36.888	CDMX	$2b$10$cNWKKH5HT7vHtIylY13y8.vWZZPoKr/1aCuuZ9PvGH78wullN.z7S	COMMON
146455a8-9108-4573-b07e-112230b46a64	Fred	fred52906@tec.mx	17	2025-08-15 15:26:36.943	OCCIDENTE	$2b$10$Iq0vdnWFDPx3NxlAZ6Due.zQ4Bupx2qgXIFRQLYsOIV95Ogeh5Dti	COMMON
ffbefed1-7883-4ff3-9663-873e2f3523d8	Ursula	ursula46165@prodigy.net.mx	26	2025-08-15 15:26:37	INTERNACIONAL	$2b$10$UbzhIQrYC9psTuGOuUvzyer/I2IkSNoNEntja8RSRgWR2b/p4FssG	COMMON
c0f83971-4552-4a09-ab3e-30326d7636ae	Nadia	nadia70144@ipn.mx	55	2025-08-15 15:26:37.057	CDMX	$2b$10$oMlTg/.stHA6vn5OZT7iiOP6EEA17TV9veNogb4ArMCdLA.hxJvdi	COMMON
450f07af-fe20-4fc2-9ffd-cffb5472da92	Zoe	zoe40330@zoho.com	39	2025-08-15 15:26:37.113	SURESTE	$2b$10$n6SI9mUeyo8TSa99loQV3emkEr8RdkGcLo7QlAdiwwjoNT/RyEWGm	COMMON
482f8a8a-0859-4ff9-861f-8157dffc48cd	Annette	annette40746@uv.mx	52	2025-08-15 15:26:37.169	SURESTE	$2b$10$BfyYoW.FyUzzC9oiCnay1ui3t/ST6w7jgkCE8SJez/Ca4TGCCMYhe	COMMON
327ebe21-a586-4dae-9037-163a7c33320f	Daniel	daniel82715@yahoo.com.mx	15	2025-08-15 15:26:37.227	CDMX	$2b$10$R.KFQ79vRUfv9i8sX0RcRuECQ1aBzNLAKX5bhuawGLqTwnzdY1C4y	COMMON
acff4c16-632f-4e9e-942e-5bd52b7efdad	Gervasio	gervasio136@udg.mx	57	2025-08-15 15:26:37.283	SUR	$2b$10$x7lErVwTwhs..xpQkc.0IeYFueFw0ZULe31MCcRmUzivLEuAJnNBu	COMMON
cf65f9bf-fd9a-4c33-8611-9b0ad26c7cb8	Scott	scott15815@tec.mx	62	2025-08-15 15:26:37.34	CENTRO	$2b$10$QJhzs/RJUpd.fB3afsyzueByVolGaW7dnXpNVvqXsLMJSI2THcR6W	COMMON
b17490b4-b072-4269-af64-7cd2ba191257	Pilar	pilar45406@live.com	22	2025-08-15 15:26:37.396	CENTRO	$2b$10$HEXppK9oA/zRUsOJaXcIJeXmHOHFI54VwXqBgjVhuzUYAcHBqzrXS	COMMON
dc52d013-ebc6-41d2-9e61-e955dfa73832	Carolina	carolina63309@zoho.com	25	2025-08-15 15:26:37.453	NORTE	$2b$10$pu5v1DUodiIqhqunXP6OhO1Kj7COC6VcAUr2GVTiTi3bUYL5UFK4a	COMMON
07a158aa-17e6-4253-99c3-55b8adb2b8af	Emerico	emerico2245@empresa.com.mx	49	2025-08-15 15:26:37.509	CDMX	$2b$10$wErtCW0szwg7t9JAWXeEeu8UyqvEDcIdD9DheHUD5JHYrOXVGVFLa	COMMON
f173ce5a-db72-4470-822f-23dfd80f69a2	Magín	magin74682@live.com	22	2025-08-15 15:26:37.565	CDMX	$2b$10$E/.T6O8urijYMWs4gDNBU.XLPgqkReX6wfTb8z09F5GCt4N9yQ7au	COMMON
68f2ce35-6a69-4214-912c-2afb5a2c390c	Artemio	artemio1637@live.com	68	2025-08-15 15:26:37.624	CDMX	$2b$10$XM8kjN4wj7lSe3DrUyI7D.o6kcNTSusGEhyNe.bVUUT9nRQAqyVPK	COMMON
850dc0c6-7e82-4726-aa43-ea9b4b39755c	Mireya	mireya62574@prodigy.net.mx	39	2025-08-15 15:26:37.681	CDMX	$2b$10$wdblQwDb1aoPMvnVKgANRu5S7ZfNVyVMCKMrOEPxJtjGQ6hQjZBLO	COMMON
0f5e6db5-55c8-4090-8110-3583c7061d3d	William	william79182@live.com	30	2025-08-15 15:26:37.738	OCCIDENTE	$2b$10$oS41W0PNvj0bASGh3aAItevXuzmkwAPpD5wI4u9xjxVy5ajMHN7gm	COMMON
af78e980-6d06-4cef-858d-674a7d0599b6	Logan	logan62917@icloud.com	47	2025-08-15 15:26:37.795	CENTRO	$2b$10$OfNEDGpsztsOFLQltSMnq.dxSw7btQpZ7PK5lSmtTQNlKRK1YYUei	COMMON
78c5e624-8657-42a8-b3aa-165320d83b37	Randy	randy76117@mail.com	59	2025-08-15 15:26:37.852	CENTRO	$2b$10$sVMjKtaAeHXrV7.nvgPs/eNy2kJjjmL3StUzLbHlMEml7nTb3i9Ja	COMMON
adddbc81-54c2-43a4-a867-a4f401b09837	Natalia	natalia31420@yahoo.com	70	2025-08-15 15:26:37.908	SUR	$2b$10$lq1GggqT0vKR78YFzO7cjuNzxHf0pyxP4OUibPE0TbUqulypJRbRe	COMMON
25ea81f4-284c-436b-97c9-3dab308c5d38	Crispín	crispin3811@mxmail.com	46	2025-08-15 15:26:37.965	NORTE	$2b$10$oHjwGBzMvYVpz3iq8QMf7.qcOEuYc8ICts8NFIq4voVNDQkrOnZX2	COMMON
a17fe986-04f7-4803-a31c-714b5b2aa114	Alonso	alonso95518@uabc.edu.mx	29	2025-08-15 15:26:38.022	OCCIDENTE	$2b$10$tlPFOKunK2Soy2wHdKr0y.LGGpKxxX8Rsmx25GOooU7SIl3i4JRES	COMMON
8d92d664-c512-4941-a2f1-67d00b466f1c	Tiburcio	tiburcio20407@gmail.com	54	2025-08-15 15:26:38.079	NORTE	$2b$10$OOVB9yTuET2GnW7PYrY4t.8Er7ppx6NkASQYGF0SwGd/Sgc0vM5SW	COMMON
70931e79-3d99-4b89-9d61-1df877e2a477	Franco	franco66488@itesm.mx	19	2025-08-15 15:26:38.135	CENTRO	$2b$10$WxQ5htS8gphM35e9z1gqKucCp1yyDz/poRwAH2VH3g8bXaICYod4S	COMMON
09e1c88c-3c59-4b6c-b4f8-c8b3661e9734	Martha	martha35425@yahoo.com.mx	33	2025-08-15 15:26:38.191	INTERNACIONAL	$2b$10$zZ2QzEqPGJrVdzIqW6HG3O.ozhVEOfWVHPMelsS7A7FxrRGdgJ/Z.	COMMON
3c8ecfc5-693f-434c-97e9-85bfa5b7b65f	Harold	harold4@yahoo.com	70	2025-08-15 15:26:38.249	SURESTE	$2b$10$Tk5Xh6z7yIVO3goIJ3c80O7di0RbNsfOtEmZwxvbrj2w8.OzrKrsW	COMMON
2da991c1-c44c-4891-8363-3cfdf3cfeacf	Úrsula	ursula41199@aol.com	47	2025-08-15 15:26:38.305	NORTE	$2b$10$iQ0Yhx/w6J3VNXQmzjFuNO.IG0iWvodMIWBbkD7ffNJHXLViAUMBe	COMMON
19d79485-3c03-4bc5-be76-8d53d577bec8	Rosaura	rosaura30448@zoho.com	68	2025-08-15 15:26:38.363	CDMX	$2b$10$08ku2XKpcs9vk0pdHcStruCIwB2ns9h38Mu5Y.ssL0vmBQrOOMF.O	COMMON
7d382649-5c6a-4b86-a941-eee8373e7e37	Federico	federico96756@live.com	32	2025-08-15 15:26:38.419	SURESTE	$2b$10$q.miTooFTpZP4R4FX.kIi.xkc9UIaSp3gLxX5H5J4aKq5PQ3ZtW/K	COMMON
1318d3f4-84b9-40d9-9ea3-88bd13e88605	Zenia	zenia86248@udg.mx	33	2025-08-15 15:26:38.475	SUR	$2b$10$5v2588i1vWOuM1UxUqdxiuFN/N88Q.R97Pq6c2gCS.RTSHuW7sAxi	COMMON
f9d7941a-a236-41c3-a248-bc1443744b90	Harry	harry47740@aol.com	12	2025-08-15 15:26:38.531	SURESTE	$2b$10$UKjcg.HdQQ4aVF4P8sZiUuMrNGGYr.RDstfrVT1KQS5B59z6TdH/i	COMMON
2a9c0b7d-cfba-4b4f-b4b0-86ce8ff0549b	Timothy	timothy92826@consultores.com	27	2025-08-15 15:26:38.587	CDMX	$2b$10$AciK3Xrw23Dl0/R54MEqd.BV0z2Z80qqQE4xLaH5VlTo1OPgY0lVK	COMMON
b82af3ea-28ce-4244-a109-328e4fc06aab	Abril	abril11873@zoho.com	64	2025-08-15 15:26:38.645	INTERNACIONAL	$2b$10$esO37okf3V68ICrIZlS.D.7p3AjPoJWUrEw1i70c6yzNzN0/kI2DC	COMMON
f2b22ef5-8c66-42c6-86fb-020165c66931	Norberto	norberto78948@consultores.com	44	2025-08-15 15:26:38.701	CENTRO	$2b$10$e5aGUaDQTDbOOJ8TOpqLaexTEpbrN.MBI5fx9mIC076dWDhWL80B.	COMMON
2cc9cf09-964f-441e-8751-d8969ccb2764	Tatiana	tatiana31356@zoho.com	33	2025-08-15 15:26:38.758	INTERNACIONAL	$2b$10$f1qf0JQARpYjrwr39PVKmOJggzC5OrCryGoyIdGC/NiyxmOBEDO/C	COMMON
eebd6522-8c92-4b75-b2ac-117888f45c07	Gabriel	gabriel13738@ipn.mx	48	2025-08-15 15:26:38.815	CENTRO	$2b$10$C4Dck0pJM2Bv2mDn97zjJ.tPVZ28i1y93ny8ZOJlrX3EQNHLMdcCS	COMMON
d45f77bd-83c3-40b0-800e-5a4e75125b18	Georgina	georgina94113@mail.com	14	2025-08-15 15:26:38.871	INTERNACIONAL	$2b$10$c/nAZNNtqtaNxwfF9trtVOao0j7KXNlfZ7qVXqAIN2QnSuQ464IC.	COMMON
9b9bc092-95fe-436a-b168-6a23874139a3	Zaqueo	zaqueo54237@live.com.mx	50	2025-08-15 15:26:38.928	NORTE	$2b$10$4mmJH26JTLZ6S9x4HEbfGOWMQu04bhwnFzhORq0ZlMpCjNTa0h6H2	COMMON
090abdf7-69a6-4a1c-b5f7-43e0dbedd16c	Berenice	berenice18956@zoho.com	65	2025-08-15 15:26:38.984	SURESTE	$2b$10$aUvQ7mo3KMQX17O5RI.iteSY4BPUZEufTLskfIf.RGdHoHRSCvrF2	COMMON
68040bde-d2ba-453c-9a4c-b182412ec0ab	Omar	omar16638@outlook.com	15	2025-08-15 15:26:39.042	SURESTE	$2b$10$2oQ0VjWNAey/zwP31ZNCJ.s3vcsErKli24aWgTT.fs2XCLojLsRxS	COMMON
b5d96efc-26b0-48c1-92c5-bd6fd4da8916	Kevin	kevin22485@tec.mx	47	2025-08-15 15:26:39.098	CDMX	$2b$10$dBPBQz4xbZ5ls4I7XJhDJO5.5nRczfHI/d0zhpR8dTdAogeEpzJmW	COMMON
2a37c6b4-5f78-448b-91d4-ae7d86c014a3	Norberto	norberto31551@uabc.edu.mx	31	2025-08-15 15:26:39.154	SURESTE	$2b$10$zSCL1b1K.CYyAEd7F7lYguEF/apqTI15GK7f4R.btn4buQ4s7Jy.e	COMMON
59b8d0df-df23-4034-847d-46d2fa87f4a5	Mayra	mayra2457@icloud.com	24	2025-08-15 15:26:39.212	NORTE	$2b$10$4NAKiQGfa1N6UorY61KEY.LJoeknHj9Ln0uLbU59Ejh8yDTgX1Eqq	COMMON
4176b2d6-8aa6-4b9d-b248-73e177495bf0	Natalia	natalia89466@empresarial.com	40	2025-08-15 15:26:39.268	OCCIDENTE	$2b$10$mc8tutzcXncNSobEGIPQ8OB5O/EQy3o031kmHHigEJZhabJuK1fdO	COMMON
0f5b75c3-4ad1-41dc-a172-0999d3c561b3	Selene	selene40356@ipn.mx	69	2025-08-15 15:26:39.324	SURESTE	$2b$10$WT5.AnDz/E16XmNszH49fOJw1KbbLo5J41Hpkh/8NT0CPNRrp2gpG	COMMON
a60306a6-2aca-4709-a151-558c0cc96afc	Berenice	berenice92091@hotmail.com	27	2025-08-15 15:26:39.381	CENTRO	$2b$10$q.xdcek0eoTYglKQSDc00O38MDUXgb4FgDhmY8I5DhcHnYZ2pPwc.	COMMON
c805a7fe-c3be-450f-96e7-b70e966a4d95	Alondra	alondra64056@uabc.edu.mx	56	2025-08-15 15:26:39.438	INTERNACIONAL	$2b$10$k2fBtvl3rEoXRyCXN/veVObNr619a8W0s9sc8JN47BsvgMqOeH0B.	COMMON
8646f09e-19f4-43b4-adbe-bbc8f81aecaf	Nayeli	nayeli34984@uv.mx	42	2025-08-15 15:26:39.494	NORTE	$2b$10$ot37JG7wEmtgMfmoR85MrOTJYfIVNF8NfWXNLdA8kNxcbnBnC8d2C	COMMON
450f776b-f333-45b6-9fa9-01ea966b2650	Scott	scott46039@yahoo.com.mx	55	2025-08-15 15:26:39.552	CENTRO	$2b$10$UElAzip76Mvva/7cwGyh5.XIL4rFfUaEAM7rVxgmWwEdFrwze4Ewa	COMMON
8873c9f7-2922-459d-b305-17235215272b	Oriana	oriana31213@hotmail.com	40	2025-08-15 15:26:39.609	CDMX	$2b$10$of0kXO4lPOg7m17j0POn6eLh3kaf8Sq2Y14nmawiYfV7Njbpt6YlG	COMMON
f4e1c4f2-3ab1-4c8b-9290-91984cd5f08c	Vianey	vianey79483@tec.mx	15	2025-08-15 15:26:39.666	CDMX	$2b$10$zdWeLHlTSW/bdDnvS6ssH.z5vulyFCLcEp93ev6kYk409pF3/0Dg.	COMMON
49415e3a-20ce-4182-9494-890a0662f3b8	Ubaldo	ubaldo1394@hotmail.com	51	2025-08-15 15:26:39.723	SURESTE	$2b$10$J6O/21og..2rf06RzoCJiuZJp21A71q4r4Znv/gJd7YRBSNmCVE7u	COMMON
663889ef-ce84-4a27-b04f-b8d094aede9e	Celso	celso62132@prodigy.net.mx	64	2025-08-15 15:26:39.779	CDMX	$2b$10$fhT25BCXVweG2.rZ1iDKsOrpEScw/ZANlMQBXxkkbaptPnTKy0tbW	COMMON
acdf07ba-8748-43f5-a49b-11d7d42e18d4	Pauline	pauline62598@consultores.com	55	2025-08-15 15:26:39.835	SUR	$2b$10$aI2LbX0bDa8IFKkV8BkAEek0yOgAEgeHvLZdXpB3PML0jx44STW3G	COMMON
67bb89ad-20d6-4085-ad7f-f2d2bbfec157	María	maria90947@hotmail.com	17	2025-08-15 15:26:39.892	SUR	$2b$10$Upbuxs0RnNrZtq6mYyMTyOOzkJHG9PXokPjEAstfYjsYCypkhmo3q	COMMON
51809b00-0738-4179-8f30-647c2b6fe6a6	Zachary	zachary13459@consultores.com	28	2025-08-15 15:26:39.949	SUR	$2b$10$UL2gkyV6ag9sbWX8ZTA9yu5miwzBxJ8KtgYVHbNT3wH5rBF0F7Tga	COMMON
4b66958b-5d27-4fff-b24d-8feb9ddfb281	Everardo	everardo68777@empresarial.com	52	2025-08-15 15:26:40.006	CDMX	$2b$10$2cReiBcz/vnlJ1AgSM3WFO1Rux5tJZw/gMBkeA4gIvI0RQ4RjjuEG	COMMON
e21c2c72-95e0-45fc-b1cd-d8a11d9a070e	Marcelina	marcelina67270@empresa.com.mx	23	2025-08-15 15:26:40.062	NORTE	$2b$10$VLuowCiTSlHGm8o3FG2gBOx.CLQ7V5SEIFbaov.WXgiCpGB/fKT7a	COMMON
\.


--
-- Data for Name: UserHabit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."UserHabit" (id, "userId", "habitId", "scheduledTime", "completedAt", status) FROM stdin;
3b8e5b51-3b2b-451f-906c-938b327b9720	11f16c31-6440-41ee-8de8-45994231c1b1	73f9d797-d073-45e1-b11f-196a8c04bc5c	19:00	\N	PAUSADO
a513eb86-7772-499c-bb98-c49f434d2360	3da3968a-b294-4344-806b-3887bd52db3c	3a840607-09cb-49d7-b256-be7bf688fd16	14:00	\N	COMPLETADO
4fe6ce07-88ed-4914-b7a5-2ae427f09bba	f2b22ef5-8c66-42c6-86fb-020165c66931	873f3209-5852-400e-ba68-e212b1d6ed1a	7:00	\N	COMPLETADO
343b1094-bffd-4031-b83e-8a99ef038d43	d4efcbfc-3929-4ec4-affd-8339d36380fe	77ab14c8-7ddf-473d-9785-e6c0544c8a85	16:00	\N	PAUSADO
742ed61d-4cfe-4b37-9556-494faeb2778f	70931e79-3d99-4b89-9d61-1df877e2a477	4ac948e2-dc61-4192-a899-10116049d06c	17:00	\N	CANCELADO
1f0eceaa-f705-4819-b265-3a64dac9d98a	6c586ea7-283d-4f72-95af-90917d213646	5d729efc-116e-43a0-b9bc-e4b4e65222fd	19:00	\N	PAUSADO
759472d6-e06c-4cb2-9d25-b68d51a898cd	3a8f361f-6aed-4290-be3d-5a2c4f26d6c3	2e46c2df-062c-4d37-9ce7-bca11437615b	18:00	\N	PAUSADO
04b0352d-f38c-4114-a509-5efeadd40d36	4a63c183-780d-4c35-894f-313cc22e4d97	4ac948e2-dc61-4192-a899-10116049d06c	19:00	\N	COMPLETADO
888cbe55-f298-469c-890d-431e9c6dc517	68040bde-d2ba-453c-9a4c-b182412ec0ab	d1e304ee-92e8-4b7f-87bd-1b2b72906a1b	11:00	\N	COMPLETADO
744857e4-69f2-4967-8cc7-adfff06c28b1	cf299fa8-6b3f-4512-b377-0195a970bf89	3b7d1bdb-17c0-4a2a-ae52-009722bbddc8	11:00	\N	ACTIVO
6b36200c-f08c-4f77-ab37-4a599247e594	9aa0637f-3f77-49ac-938b-0fb75becd0ce	1d969d45-6e5d-40d1-92f6-c6d538e9b248	19:00	\N	CANCELADO
47233ce5-dcee-479b-bf72-2f511ca75405	a17fe986-04f7-4803-a31c-714b5b2aa114	97699023-9fbe-4e66-aafb-00d0699540b3	15:00	\N	COMPLETADO
a807057f-28a2-437a-ba7c-914a90356858	0cef0cd5-3646-4d8a-a1d6-aae18db552a8	b6bc6efa-5c99-4b38-88b8-6598f5f21469	14:00	\N	CANCELADO
f4f6b4d4-b9fb-4460-b06b-a6979e6b2a2d	b17490b4-b072-4269-af64-7cd2ba191257	503df901-9864-4f1f-9625-cc14d853a313	10:00	\N	CANCELADO
679ed2a2-b271-4fdd-9a92-4064cc388f94	ff44e113-5641-46f4-877d-6ad37245de3e	40454f9f-cd88-4309-9620-671cc173c417	21:00	\N	COMPLETADO
3e10a8c4-b86e-4376-99e6-961c04b155d1	f4e1c4f2-3ab1-4c8b-9290-91984cd5f08c	873f3209-5852-400e-ba68-e212b1d6ed1a	15:00	\N	PAUSADO
352cc76b-7fce-4a82-9837-68a42d7d87b7	348859f3-1a1b-4271-afba-d9c4ced20677	d1e304ee-92e8-4b7f-87bd-1b2b72906a1b	21:00	\N	COMPLETADO
8a958ce4-6d8f-4a03-9f4c-d78c79c7a265	3da3968a-b294-4344-806b-3887bd52db3c	dd772762-8f5f-4f3a-832d-4f256100ac15	8:00	\N	COMPLETADO
f66066ba-cda0-4334-8d42-4ef10506355d	cc114cdd-3100-4a02-b02b-0fb66a5002e4	913c65c7-a6cb-4416-b935-cf94ffb85d09	21:00	\N	ACTIVO
ad8e4c5c-8e53-4f90-b20a-4e86a16fef7e	0cef0cd5-3646-4d8a-a1d6-aae18db552a8	a186c03e-7723-4633-a10a-43c0d5a37a41	9:00	\N	PAUSADO
a4ce9147-53db-429c-afc7-98fee39425f7	ef28a16d-590b-4cf3-b361-2b8b1a315d84	913c65c7-a6cb-4416-b935-cf94ffb85d09	17:00	\N	ACTIVO
dcd112b9-4d81-4d4e-bfdb-ad4fa432c520	addb7aff-6ce8-4f1d-93bb-973339eb84cb	67ae945d-412d-4551-a560-ca841d52b1d1	9:00	\N	CANCELADO
8779c652-0fea-4222-8cc6-9e70b556bfd2	59b8d0df-df23-4034-847d-46d2fa87f4a5	f458c790-95d8-4bce-915e-bc27a56c9586	8:00	\N	CANCELADO
cf7f1898-da46-4d93-b9e0-899423282486	25ea81f4-284c-436b-97c9-3dab308c5d38	73f9d797-d073-45e1-b11f-196a8c04bc5c	21:00	\N	COMPLETADO
9b28a473-f7c2-4fc2-bc60-0efc8f09ef5d	76a664a4-f686-4144-ab24-b73c5e1db0d1	735da0ce-a32b-4e1f-b184-7a77a051d51c	9:00	\N	ACTIVO
d5419030-c51b-433b-891a-bbf99c07382f	f4e1c4f2-3ab1-4c8b-9290-91984cd5f08c	6e2739c7-bf3e-48f1-b9f8-1b55248231a5	21:00	\N	ACTIVO
4b3144d3-87db-47d6-9fb0-8c260ad6d3ef	addb7aff-6ce8-4f1d-93bb-973339eb84cb	3b7d1bdb-17c0-4a2a-ae52-009722bbddc8	17:00	\N	CANCELADO
0ba702e8-e031-48ae-b77a-abf5b0f4d2d7	11f16c31-6440-41ee-8de8-45994231c1b1	60dc45f1-75e9-4925-a559-f2b04aed16a5	6:00	\N	CANCELADO
5f913f7c-b084-4e96-9661-877227d2d8e4	3021c1cd-8e20-4a6e-a64f-97bbd933c5a1	389df2ed-cf00-4ce6-b3a2-c7e4461a5b0e	6:00	\N	PAUSADO
04596cc9-d73a-4cd0-8748-6b4728be1266	d4efcbfc-3929-4ec4-affd-8339d36380fe	89eca878-bbb2-464f-9771-edb039c86270	18:00	\N	ACTIVO
ebef83b7-e677-460d-88cf-3401510b2e90	c0f83971-4552-4a09-ab3e-30326d7636ae	a47190da-8c96-4b19-a73e-d5af5e2c33a6	20:00	\N	PAUSADO
6f452f54-4298-43f2-9992-d5360a4a0aa1	8873c9f7-2922-459d-b305-17235215272b	40ade030-1bee-4360-91d6-c596ee16145d	11:00	\N	COMPLETADO
eb597ec7-647d-4a5a-800e-952291c0af58	146455a8-9108-4573-b07e-112230b46a64	fe0bd9ad-1cba-4540-b745-69a6b6fa6d94	7:00	\N	PAUSADO
2d208758-7519-4093-a711-425ec0fe1738	d408932d-4d13-44a8-a0a2-110e9a1257d0	cd9fc71e-4da6-4aac-8f3a-638b1873c47d	6:00	\N	CANCELADO
2c1648c8-ea5a-4692-9631-f81918ae6e57	b17490b4-b072-4269-af64-7cd2ba191257	5d729efc-116e-43a0-b9bc-e4b4e65222fd	12:00	\N	ACTIVO
42043a38-eaad-4bf8-8f5a-6de86717122b	7c0863f9-2095-4d71-bde4-0f7ff8d7d579	08f74cba-515b-4321-8ef1-e84781516538	20:00	\N	PAUSADO
a6c4489b-3672-4d98-8680-9691b005a338	9b9bc092-95fe-436a-b168-6a23874139a3	873f3209-5852-400e-ba68-e212b1d6ed1a	15:00	\N	PAUSADO
0072cd30-07c4-4333-8817-fbbc547dcaf1	f2b22ef5-8c66-42c6-86fb-020165c66931	913ed5b5-e107-4526-b026-de7652de5545	19:00	\N	COMPLETADO
e2007db6-95a9-4ede-9cfe-051bf7d5a066	450f776b-f333-45b6-9fa9-01ea966b2650	be55113c-4449-434d-8fb6-4c122fcb478a	17:00	\N	PAUSADO
b577dbb7-8712-4650-bebd-5006d47fcd1c	cf845157-b14d-4374-834e-dd9761d31b7b	fd391506-c119-467a-9b85-1a14d06a4117	18:00	\N	ACTIVO
5eea4573-ca74-460a-aa94-9e50ff911778	482f8a8a-0859-4ff9-861f-8157dffc48cd	2fa53bcf-7f6b-4d0c-a7c0-593f0159134a	6:00	\N	PAUSADO
ad36c1fe-9c99-4fa6-b5ac-987cdcd0b42a	b5d96efc-26b0-48c1-92c5-bd6fd4da8916	ac2e19a4-93c4-4e82-ba69-598998e4b265	21:00	\N	COMPLETADO
266c3cff-c022-4514-b048-7df4aa33e1a7	7398e721-7e7c-4fb0-b336-1e57d037d3a2	cd9fc71e-4da6-4aac-8f3a-638b1873c47d	19:00	\N	CANCELADO
e9ec1026-c5ad-4ffb-8bec-951bf09845bb	49415e3a-20ce-4182-9494-890a0662f3b8	77ab14c8-7ddf-473d-9785-e6c0544c8a85	11:00	\N	ACTIVO
c8df94fa-3aca-48fb-9760-ba66cf9a31de	f173ce5a-db72-4470-822f-23dfd80f69a2	51ab9df1-c025-4960-aba6-2ff0587ebd13	18:00	\N	PAUSADO
a271861c-5c2b-48a4-a1f8-48fce0de851b	eebd6522-8c92-4b75-b2ac-117888f45c07	b6bc6efa-5c99-4b38-88b8-6598f5f21469	9:00	\N	COMPLETADO
f03480fa-a857-4a6c-924b-d35872815fb5	70931e79-3d99-4b89-9d61-1df877e2a477	1fbc570b-31e9-45de-987a-2b62de923c0c	14:00	\N	COMPLETADO
60ef8c47-7f40-462f-ac48-b1050090f31b	566b1ab4-c44c-4064-915d-17fd293fd8fe	389df2ed-cf00-4ce6-b3a2-c7e4461a5b0e	9:00	\N	PAUSADO
5c96bfc6-c87d-4ad0-81f1-a333355b1387	70931e79-3d99-4b89-9d61-1df877e2a477	913ed5b5-e107-4526-b026-de7652de5545	17:00	\N	PAUSADO
6a8a4ebb-9892-4194-a103-9ee134c8c74c	27742407-202e-4138-9060-14bc97dcae32	d7db67e5-6e82-4eec-8305-3d60b2f323e3	7:00	\N	PAUSADO
0e420274-af63-4f45-a959-b145be0fb8f3	cf845157-b14d-4374-834e-dd9761d31b7b	f0c90e82-babf-4137-a059-d7e635ecca9d	14:00	\N	ACTIVO
31ad10b6-68cd-41ab-a51c-c6da38c077e9	fa53c5ef-5279-4c03-9c38-182e449b0a6e	73f9d797-d073-45e1-b11f-196a8c04bc5c	6:00	\N	COMPLETADO
17551612-93ec-4604-b497-686294cf86f8	146455a8-9108-4573-b07e-112230b46a64	735da0ce-a32b-4e1f-b184-7a77a051d51c	9:00	\N	PAUSADO
9c681d5d-4fc4-476c-a7e3-316d9a038d1d	9aa0637f-3f77-49ac-938b-0fb75becd0ce	d7db67e5-6e82-4eec-8305-3d60b2f323e3	7:00	\N	ACTIVO
3d9fa033-245b-471a-8921-7984361d3669	6c586ea7-283d-4f72-95af-90917d213646	33843cf4-8bde-402c-97ef-1a79757207e2	21:00	\N	CANCELADO
7d31b612-7763-4960-b9ab-98218a4e914b	27742407-202e-4138-9060-14bc97dcae32	913ed5b5-e107-4526-b026-de7652de5545	10:00	\N	PAUSADO
5a88b049-fd59-4b82-aefa-ab615e64e0a3	e6301ffb-5fb3-44a9-9667-cd20918bd62e	33843cf4-8bde-402c-97ef-1a79757207e2	14:00	\N	PAUSADO
ed3acd46-07ca-4883-b61f-160bfa25d2be	dc52d013-ebc6-41d2-9e61-e955dfa73832	40ade030-1bee-4360-91d6-c596ee16145d	19:00	\N	ACTIVO
493c3bd8-9c9e-4a5c-86b8-69f93b1f7fc8	acdf07ba-8748-43f5-a49b-11d7d42e18d4	b6bc6efa-5c99-4b38-88b8-6598f5f21469	12:00	\N	ACTIVO
7147f2ac-9b7f-45e4-bf59-9f0d044cd0a6	02f0a16d-51d8-42cb-af77-ae8c5bb8decb	9590a225-9007-42ca-9431-6e54eb24e4b9	8:00	\N	PAUSADO
57aa39ec-e1d4-4b85-a132-9e1dd1e6e417	7398e721-7e7c-4fb0-b336-1e57d037d3a2	a2ee62d9-83cf-498c-bb8f-8115e41f772a	7:00	\N	ACTIVO
c25bc4f2-d1d6-4498-b010-ad4630864fa2	b71d9a0f-f721-4d41-a72e-24dfd092b1a9	a186c03e-7723-4633-a10a-43c0d5a37a41	11:00	\N	COMPLETADO
7d1b3bdd-f993-4dca-8f44-a4285fcf79d1	67bb89ad-20d6-4085-ad7f-f2d2bbfec157	6fb70cf9-b435-4289-b62b-b49f147ba320	9:00	\N	ACTIVO
cc9dce9d-2ee5-4f82-83d0-a13b588064cc	76a664a4-f686-4144-ab24-b73c5e1db0d1	eb27f377-5cd0-4c0f-9d6f-17f7574b67b0	17:00	\N	CANCELADO
6966b1fb-bbd5-46a0-9472-c81e44cab813	70931e79-3d99-4b89-9d61-1df877e2a477	d8c68e97-c9e3-4d83-8b78-a771d2da53a9	17:00	\N	COMPLETADO
5e75bb82-683b-490a-9f2a-e2baacb25595	090abdf7-69a6-4a1c-b5f7-43e0dbedd16c	d8c68e97-c9e3-4d83-8b78-a771d2da53a9	14:00	\N	ACTIVO
79b0b8da-f41b-4add-9ced-fbf267ed14c1	2a9c0b7d-cfba-4b4f-b4b0-86ce8ff0549b	33843cf4-8bde-402c-97ef-1a79757207e2	8:00	\N	CANCELADO
2393922a-9a14-4747-bf2c-0243800e5d83	0f5e6db5-55c8-4090-8110-3583c7061d3d	2a535fe7-e302-478e-bf18-0fd9c78627cd	10:00	\N	ACTIVO
bb10528b-f365-4c98-8804-eecc6692d8d4	d408932d-4d13-44a8-a0a2-110e9a1257d0	04f7beb8-944a-4dc3-b8b3-e6a08ed53db3	11:00	\N	ACTIVO
b9fe0063-1a8a-4328-ac9b-ce1847600670	450f776b-f333-45b6-9fa9-01ea966b2650	be7fa636-09b2-4e8a-998d-9fa0548ad05d	21:00	\N	ACTIVO
69caaeb3-e8f7-4b26-bb52-7d647b7162fe	4b66958b-5d27-4fff-b24d-8feb9ddfb281	08f74cba-515b-4321-8ef1-e84781516538	12:00	\N	CANCELADO
a7754720-59d0-49b2-af38-a55897daae70	dc52d013-ebc6-41d2-9e61-e955dfa73832	090baa24-b00b-4084-bb49-cb53ad8f2327	15:00	\N	COMPLETADO
065013a5-ea6f-4368-ab57-401c868ffccf	9b9bc092-95fe-436a-b168-6a23874139a3	090baa24-b00b-4084-bb49-cb53ad8f2327	16:00	\N	PAUSADO
a132e31a-55f2-4415-a2a5-706fe5dfecbb	adddbc81-54c2-43a4-a867-a4f401b09837	fd391506-c119-467a-9b85-1a14d06a4117	20:00	\N	CANCELADO
30cbc2a2-c44d-4350-bfe4-7fc600616595	146455a8-9108-4573-b07e-112230b46a64	dd772762-8f5f-4f3a-832d-4f256100ac15	22:00	\N	COMPLETADO
2dac9424-a7cd-4a4d-8a71-0cea9745c42f	4cae9e0b-d9a4-4aa6-aa93-4caf2970d782	15d17687-dd5f-49a4-85ea-ca45d1f272f7	7:00	\N	PAUSADO
c04b4b88-4fdf-400b-bd80-19b28951a858	0f5e6db5-55c8-4090-8110-3583c7061d3d	c5fe89fa-9a66-4061-bdba-8b6a12d6028c	7:00	\N	COMPLETADO
6a76950e-c840-4d5a-b9f7-891d4fc6affc	b71d9a0f-f721-4d41-a72e-24dfd092b1a9	bee47ae1-f2f9-4fe8-83cf-e3cb977c6fb2	14:00	\N	ACTIVO
a18529c5-b94a-40d9-968c-ee428de2161a	3da3968a-b294-4344-806b-3887bd52db3c	503df901-9864-4f1f-9625-cc14d853a313	15:00	\N	ACTIVO
5ab4e7ee-d5f2-462d-9689-e765a146cdca	0cef0cd5-3646-4d8a-a1d6-aae18db552a8	498c7d29-4711-4a47-a73d-19d537ed4353	9:00	\N	ACTIVO
28fdd560-9585-45e4-aa04-b1924ab43be6	25ea81f4-284c-436b-97c9-3dab308c5d38	719b95cf-1964-4536-aa17-8aaec04ea1ab	10:00	\N	ACTIVO
e1ded4a7-c038-4885-8330-e41c13081e0e	eebd6522-8c92-4b75-b2ac-117888f45c07	33843cf4-8bde-402c-97ef-1a79757207e2	22:00	\N	ACTIVO
d63b5cdf-2e49-4a91-8b11-cabc301aa897	51809b00-0738-4179-8f30-647c2b6fe6a6	9590a225-9007-42ca-9431-6e54eb24e4b9	6:00	\N	COMPLETADO
741499dd-cbb2-4ce9-a1c5-49435bfc3cfe	1318d3f4-84b9-40d9-9ea3-88bd13e88605	fe0bd9ad-1cba-4540-b745-69a6b6fa6d94	6:00	\N	CANCELADO
6566cf0e-49c4-4c33-9195-3786a60a7d12	31fbf48b-2c1d-442f-b7fb-9bd4bc7228f2	389df2ed-cf00-4ce6-b3a2-c7e4461a5b0e	6:00	\N	ACTIVO
3006aad0-b8aa-40a1-8ba7-07b041188815	6c586ea7-283d-4f72-95af-90917d213646	af2e0448-f675-4062-9e62-1ca1ce809694	7:00	\N	CANCELADO
755ffc84-7177-4f88-8732-87c2bf173b97	70931e79-3d99-4b89-9d61-1df877e2a477	9a648b95-3e20-455d-8108-0e3cdab01251	18:00	\N	CANCELADO
d7a7d214-59cf-41a1-9ce3-9dd4ff3ecc96	7d382649-5c6a-4b86-a941-eee8373e7e37	7333ca48-3e98-4747-850c-c83d91bc8c02	14:00	\N	ACTIVO
306f36a3-e38d-4061-b72a-de2bec053e5d	09e1c88c-3c59-4b6c-b4f8-c8b3661e9734	3e3d4d7d-206f-4456-8168-f8c63ce843d0	8:00	\N	CANCELADO
bed83d05-f0fd-4dbf-89ca-108ff3e06b14	7398e721-7e7c-4fb0-b336-1e57d037d3a2	8a0bd398-5d51-4c5f-be18-74a8001ec425	15:00	\N	PAUSADO
ffdd399c-0f62-43f5-aa91-dccad68d1ba7	2a37c6b4-5f78-448b-91d4-ae7d86c014a3	3a840607-09cb-49d7-b256-be7bf688fd16	9:00	\N	COMPLETADO
5faae834-ce35-4c1c-b92c-36b1fd7b3187	e6301ffb-5fb3-44a9-9667-cd20918bd62e	cc478ce6-47b5-49bf-a62e-9aa9807d4d83	8:00	\N	PAUSADO
bf9b8498-2ea2-484b-a11a-98426332ed31	d45f77bd-83c3-40b0-800e-5a4e75125b18	a186c03e-7723-4633-a10a-43c0d5a37a41	18:00	\N	PAUSADO
39d59b26-ac3a-441f-aaf0-e80e1f701579	b71d9a0f-f721-4d41-a72e-24dfd092b1a9	7333ca48-3e98-4747-850c-c83d91bc8c02	11:00	\N	CANCELADO
4838c6aa-6555-494e-abcf-39261a15d1f3	3a8f361f-6aed-4290-be3d-5a2c4f26d6c3	60dc45f1-75e9-4925-a559-f2b04aed16a5	14:00	\N	COMPLETADO
c34f59b3-9a9b-43e3-9045-3642be07eee6	b71d9a0f-f721-4d41-a72e-24dfd092b1a9	2e46c2df-062c-4d37-9ce7-bca11437615b	8:00	\N	COMPLETADO
689273c9-ce1a-4f5a-901e-37749fcfdf3d	addb7aff-6ce8-4f1d-93bb-973339eb84cb	6e06df87-2688-4c1f-bb81-4f9672a5908f	7:00	\N	ACTIVO
b47fcc6d-9549-4423-bf5a-550a93d902ed	ff44e113-5641-46f4-877d-6ad37245de3e	2a535fe7-e302-478e-bf18-0fd9c78627cd	9:00	\N	PAUSADO
35042ea4-c27a-41c2-a424-926408f2cbd7	5787a18e-0468-4b0d-ad49-a6ff0e7a2a5e	892f48fa-43a7-4e62-93a4-729b8e838310	10:00	\N	COMPLETADO
5c0ffc2b-48f1-4621-a0b4-2f9034c4cf63	eebd6522-8c92-4b75-b2ac-117888f45c07	60dc45f1-75e9-4925-a559-f2b04aed16a5	8:00	\N	PAUSADO
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
378c3b11-4d3b-4f6d-b689-c27647a98500	61ccae2a84f03821afefd5ac7966dc92374d90a7b84ee884028554e254943211	2025-08-15 15:24:46.6348+00	20250615192532_init	\N	\N	2025-08-15 15:24:46.619884+00	1
f57fd88b-c44c-41e9-b962-36a3be4b132e	c99d6bb18e9731b99093b0da251d051304536073257e422450971b5d137862b3	2025-08-15 15:24:46.638408+00	20250623175620_init	\N	\N	2025-08-15 15:24:46.635503+00	1
a66df957-32fd-4aaf-81a6-e7e9a952475a	eb7b8daec0ee36044749897ffa29c96c41df26fac64762d6285882b2cbf3c99d	2025-08-15 15:24:46.640855+00	20250721220548_	\N	\N	2025-08-15 15:24:46.639052+00	1
826633e5-aa79-4ec6-a4c9-9280ab8464e9	f83019f9d48c4573c17dd0fd4deaaf80a3a90d10690b1460232bcd4f7d232ce5	2025-08-15 15:24:46.643164+00	20250721222229_	\N	\N	2025-08-15 15:24:46.641474+00	1
\.


--
-- Name: Habit Habit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Habit"
    ADD CONSTRAINT "Habit_pkey" PRIMARY KEY (id);


--
-- Name: Interaction Interaction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Interaction"
    ADD CONSTRAINT "Interaction_pkey" PRIMARY KEY (id);


--
-- Name: Profile Profile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Profile"
    ADD CONSTRAINT "Profile_pkey" PRIMARY KEY (id);


--
-- Name: Recommendation Recommendation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Recommendation"
    ADD CONSTRAINT "Recommendation_pkey" PRIMARY KEY (id);


--
-- Name: UserHabit UserHabit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserHabit"
    ADD CONSTRAINT "UserHabit_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Profile_userId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Profile_userId_key" ON public."Profile" USING btree ("userId");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: Interaction Interaction_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Interaction"
    ADD CONSTRAINT "Interaction_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Profile Profile_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Profile"
    ADD CONSTRAINT "Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Recommendation Recommendation_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Recommendation"
    ADD CONSTRAINT "Recommendation_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserHabit UserHabit_habitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserHabit"
    ADD CONSTRAINT "UserHabit_habitId_fkey" FOREIGN KEY ("habitId") REFERENCES public."Habit"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserHabit UserHabit_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserHabit"
    ADD CONSTRAINT "UserHabit_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

