--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alert_settings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE alert_settings (
    id integer NOT NULL,
    doctor_id integer NOT NULL,
    skipped_meds integer DEFAULT 2 NOT NULL,
    skipped_appointments integer DEFAULT 2 NOT NULL,
    a1c_min double precision DEFAULT 18.4 NOT NULL,
    a1c_max double precision DEFAULT 25 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    skipped_treatments integer DEFAULT 2 NOT NULL,
    skipped_inputs integer DEFAULT 2 NOT NULL,
    bmi_min double precision DEFAULT 18 NOT NULL,
    bmi_max double precision DEFAULT 30 NOT NULL
);


--
-- Name: alert_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE alert_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alert_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE alert_settings_id_seq OWNED BY alert_settings.id;


--
-- Name: alerts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE alerts (
    id integer NOT NULL,
    patient_id integer NOT NULL,
    alert_type character varying(255) NOT NULL,
    complete boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    reminders_skipped integer,
    reason character varying(255)
);


--
-- Name: alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE alerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE alerts_id_seq OWNED BY alerts.id;


--
-- Name: appointment_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE appointment_types (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    recurrence boolean DEFAULT false NOT NULL,
    occurence_frequency integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    doctor_id integer NOT NULL
);


--
-- Name: appointment_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE appointment_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: appointment_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE appointment_types_id_seq OWNED BY appointment_types.id;


--
-- Name: appointments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE appointments (
    id integer NOT NULL,
    patient_id integer NOT NULL,
    doctor_id integer,
    datetime timestamp without time zone NOT NULL,
    note text,
    met boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    appointment_type_id integer
);


--
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE appointments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE appointments_id_seq OWNED BY appointments.id;


--
-- Name: appt_type_diagnoses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE appt_type_diagnoses (
    id integer NOT NULL,
    appt_type_id integer NOT NULL,
    diagnosis_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: appt_type_diagnoses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE appt_type_diagnoses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: appt_type_diagnoses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE appt_type_diagnoses_id_seq OWNED BY appt_type_diagnoses.id;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    handler text NOT NULL,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: diagnoses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE diagnoses (
    id integer NOT NULL,
    code character varying(255) NOT NULL,
    description text NOT NULL,
    code_type character varying(255) DEFAULT 'ICD10'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: diagnoses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE diagnoses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: diagnoses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE diagnoses_id_seq OWNED BY diagnoses.id;


--
-- Name: healths; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE healths (
    id integer NOT NULL,
    patient_id integer NOT NULL,
    height double precision,
    weight double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: healths_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE healths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: healths_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE healths_id_seq OWNED BY healths.id;


--
-- Name: patient_diagnoses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE patient_diagnoses (
    id integer NOT NULL,
    diagnosis_id integer NOT NULL,
    patient_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: patient_diagnoses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE patient_diagnoses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patient_diagnoses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE patient_diagnoses_id_seq OWNED BY patient_diagnoses.id;


--
-- Name: practices; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE practices (
    id integer NOT NULL,
    specialty character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: practices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE practices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: practices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE practices_id_seq OWNED BY practices.id;


--
-- Name: reminders; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE reminders (
    id integer NOT NULL,
    datetime timestamp without time zone NOT NULL,
    title character varying(255) NOT NULL,
    rem_type character varying(255) NOT NULL,
    input integer,
    patient_id integer NOT NULL,
    due boolean DEFAULT false NOT NULL,
    note text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    checked boolean DEFAULT false NOT NULL,
    complete boolean,
    sub_type character varying(255),
    input_checked boolean DEFAULT false NOT NULL
);


--
-- Name: reminders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE reminders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reminders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE reminders_id_seq OWNED BY reminders.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_digest character varying(255) NOT NULL,
    session_token character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    phone character varying(255),
    doctor_id integer,
    practice_id integer,
    is_doctor boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    avatar_file_name character varying(255),
    avatar_content_type character varying(255),
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone,
    email_notifications boolean DEFAULT true NOT NULL,
    uid character varying(255),
    access_token character varying(255),
    provider character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY alert_settings ALTER COLUMN id SET DEFAULT nextval('alert_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY alerts ALTER COLUMN id SET DEFAULT nextval('alerts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY appointment_types ALTER COLUMN id SET DEFAULT nextval('appointment_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY appointments ALTER COLUMN id SET DEFAULT nextval('appointments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY appt_type_diagnoses ALTER COLUMN id SET DEFAULT nextval('appt_type_diagnoses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY diagnoses ALTER COLUMN id SET DEFAULT nextval('diagnoses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY healths ALTER COLUMN id SET DEFAULT nextval('healths_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY patient_diagnoses ALTER COLUMN id SET DEFAULT nextval('patient_diagnoses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY practices ALTER COLUMN id SET DEFAULT nextval('practices_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY reminders ALTER COLUMN id SET DEFAULT nextval('reminders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: alert_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY alert_settings
    ADD CONSTRAINT alert_settings_pkey PRIMARY KEY (id);


--
-- Name: alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (id);


--
-- Name: appointment_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY appointment_types
    ADD CONSTRAINT appointment_types_pkey PRIMARY KEY (id);


--
-- Name: appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: appt_type_diagnoses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY appt_type_diagnoses
    ADD CONSTRAINT appt_type_diagnoses_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: diagnoses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY diagnoses
    ADD CONSTRAINT diagnoses_pkey PRIMARY KEY (id);


--
-- Name: healths_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY healths
    ADD CONSTRAINT healths_pkey PRIMARY KEY (id);


--
-- Name: patient_diagnoses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY patient_diagnoses
    ADD CONSTRAINT patient_diagnoses_pkey PRIMARY KEY (id);


--
-- Name: practices_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY practices
    ADD CONSTRAINT practices_pkey PRIMARY KEY (id);


--
-- Name: reminders_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY reminders
    ADD CONSTRAINT reminders_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: index_alerts_on_patient_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_alerts_on_patient_id ON alerts USING btree (patient_id);


--
-- Name: index_appointment_types_on_doctor_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_appointment_types_on_doctor_id ON appointment_types USING btree (doctor_id);


--
-- Name: index_appointments_on_patient_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_appointments_on_patient_id ON appointments USING btree (patient_id);


--
-- Name: index_appt_type_diagnoses_on_appt_type_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_appt_type_diagnoses_on_appt_type_id ON appt_type_diagnoses USING btree (appt_type_id);


--
-- Name: index_appt_type_diagnoses_on_appt_type_id_and_diagnosis_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_appt_type_diagnoses_on_appt_type_id_and_diagnosis_id ON appt_type_diagnoses USING btree (appt_type_id, diagnosis_id);


--
-- Name: index_appt_type_diagnoses_on_diagnosis_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_appt_type_diagnoses_on_diagnosis_id ON appt_type_diagnoses USING btree (diagnosis_id);


--
-- Name: index_diagnoses_on_code; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_diagnoses_on_code ON diagnoses USING btree (code);


--
-- Name: index_diagnoses_on_description; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_diagnoses_on_description ON diagnoses USING btree (description);


--
-- Name: index_healths_on_patient_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_healths_on_patient_id ON healths USING btree (patient_id);


--
-- Name: index_patient_diagnoses_on_diagnosis_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_patient_diagnoses_on_diagnosis_id ON patient_diagnoses USING btree (diagnosis_id);


--
-- Name: index_patient_diagnoses_on_diagnosis_id_and_patient_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_patient_diagnoses_on_diagnosis_id_and_patient_id ON patient_diagnoses USING btree (diagnosis_id, patient_id);


--
-- Name: index_patient_diagnoses_on_patient_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_patient_diagnoses_on_patient_id ON patient_diagnoses USING btree (patient_id);


--
-- Name: index_reminders_on_patient_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_reminders_on_patient_id ON reminders USING btree (patient_id);


--
-- Name: index_users_on_doctor_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_doctor_id ON users USING btree (doctor_id);


--
-- Name: index_users_on_uid_and_provider; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_uid_and_provider ON users USING btree (uid, provider);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140217172201');

INSERT INTO schema_migrations (version) VALUES ('20140217190936');

INSERT INTO schema_migrations (version) VALUES ('20140218000241');

INSERT INTO schema_migrations (version) VALUES ('20140218230317');

INSERT INTO schema_migrations (version) VALUES ('20140219031512');

INSERT INTO schema_migrations (version) VALUES ('20140219133023');

INSERT INTO schema_migrations (version) VALUES ('20140219232041');

INSERT INTO schema_migrations (version) VALUES ('20140220015904');

INSERT INTO schema_migrations (version) VALUES ('20140220022317');

INSERT INTO schema_migrations (version) VALUES ('20140220032845');

INSERT INTO schema_migrations (version) VALUES ('20140220151004');

INSERT INTO schema_migrations (version) VALUES ('20140220193450');

INSERT INTO schema_migrations (version) VALUES ('20140220202754');

INSERT INTO schema_migrations (version) VALUES ('20140220205718');

INSERT INTO schema_migrations (version) VALUES ('20140221004903');

INSERT INTO schema_migrations (version) VALUES ('20140221032604');

INSERT INTO schema_migrations (version) VALUES ('20140223202403');

INSERT INTO schema_migrations (version) VALUES ('20140224220309');

INSERT INTO schema_migrations (version) VALUES ('20140224220955');

INSERT INTO schema_migrations (version) VALUES ('20140226150556');

INSERT INTO schema_migrations (version) VALUES ('20140227142245');

INSERT INTO schema_migrations (version) VALUES ('20140227154356');

INSERT INTO schema_migrations (version) VALUES ('20140227214520');

INSERT INTO schema_migrations (version) VALUES ('20140228002707');

INSERT INTO schema_migrations (version) VALUES ('20140228154623');

INSERT INTO schema_migrations (version) VALUES ('20140228160612');

INSERT INTO schema_migrations (version) VALUES ('20140228170948');

INSERT INTO schema_migrations (version) VALUES ('20140228172921');

INSERT INTO schema_migrations (version) VALUES ('20140228185512');