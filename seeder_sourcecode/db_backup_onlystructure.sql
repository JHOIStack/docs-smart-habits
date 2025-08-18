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

