--
-- PostgreSQL database dump
--

-- Dumped from database version 10.13
-- Dumped by pg_dump version 10.13

-- Started on 2022-07-18 15:14:21 IST

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
-- TOC entry 5 (class 2615 OID 116383)
-- Name: master; Type: SCHEMA; Schema: -; Owner: sysadmin
--

CREATE SCHEMA master;


ALTER SCHEMA master OWNER TO sysadmin;

--
-- TOC entry 1 (class 3079 OID 13794)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3798 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 197 (class 1259 OID 116387)
-- Name: advice_seq; Type: SEQUENCE; Schema: master; Owner: sysadmin
--

CREATE SEQUENCE master.advice_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.advice_seq OWNER TO sysadmin;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 116389)
-- Name: advice; Type: TABLE; Schema: master; Owner: sysadmin
--

CREATE TABLE master.advice (
    id bigint DEFAULT nextval('master.advice_seq'::regclass) NOT NULL,
    name character varying(500) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE master.advice OWNER TO sysadmin;

--
-- TOC entry 204 (class 1259 OID 117551)
-- Name: consultation_ruling_engine_seq; Type: SEQUENCE; Schema: master; Owner: sysadmin
--

CREATE SEQUENCE master.consultation_ruling_engine_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.consultation_ruling_engine_seq OWNER TO sysadmin;

--
-- TOC entry 205 (class 1259 OID 117553)
-- Name: consultation_ruling_engine; Type: TABLE; Schema: master; Owner: sysadmin
--

CREATE TABLE master.consultation_ruling_engine (
    id bigint DEFAULT nextval('master.consultation_ruling_engine_seq'::regclass) NOT NULL,
    diagnosis_id bigint,
    symptoms_id json,
    medicine_id json,
    advice_id json,
    investigation_id json,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE master.consultation_ruling_engine OWNER TO sysadmin;

--
-- TOC entry 211 (class 1259 OID 117953)
-- Name: consultation_ruling_engine_sequence; Type: SEQUENCE; Schema: master; Owner: sysadmin
--

CREATE SEQUENCE master.consultation_ruling_engine_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.consultation_ruling_engine_sequence OWNER TO sysadmin;

--
-- TOC entry 200 (class 1259 OID 116734)
-- Name: medicines_seq; Type: SEQUENCE; Schema: master; Owner: sysadmin
--

CREATE SEQUENCE master.medicines_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE master.medicines_seq OWNER TO sysadmin;

--
-- TOC entry 201 (class 1259 OID 116736)
-- Name: medicines; Type: TABLE; Schema: master; Owner: sysadmin
--

CREATE TABLE master.medicines (
    id bigint DEFAULT nextval('master.medicines_seq'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(100) NOT NULL,
    salt character varying(250) DEFAULT NULL::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE master.medicines OWNER TO sysadmin;

--
-- TOC entry 212 (class 1259 OID 117955)
-- Name: advice_details; Type: TABLE; Schema: public; Owner: sysadmin
--

CREATE TABLE public.advice_details (
    advice_id integer NOT NULL,
    advice character varying(255)
);


ALTER TABLE public.advice_details OWNER TO sysadmin;

--
-- TOC entry 202 (class 1259 OID 117079)
-- Name: data_request_dtls; Type: TABLE; Schema: public; Owner: sysadmin
--

CREATE TABLE public.data_request_dtls (
    transaction_id character varying(255) NOT NULL,
    appointment_id character varying(255),
    data_push_url character varying(255),
    date_range_from character varying(255),
    date_range_to character varying(255),
    key_crypto_alg character varying(255),
    key_curve character varying(255),
    key_expiry character varying(255),
    key_parameters character varying(255),
    receiver_nonce character varying(255),
    receiver_private_key character varying(255),
    receiver_public_key character varying(255),
    request text,
    is_called boolean DEFAULT false,
    "timestamp" character varying(255)
);


ALTER TABLE public.data_request_dtls OWNER TO sysadmin;

--
-- TOC entry 203 (class 1259 OID 117088)
-- Name: data_transfer_dtls; Type: TABLE; Schema: public; Owner: sysadmin
--

CREATE TABLE public.data_transfer_dtls (
    id character varying(255) NOT NULL,
    appointment_id character varying(255),
    fhir_string text,
    labname character varying(255),
    is_called boolean DEFAULT false,
    "timestamp" character varying(255),
    transaction_id character varying(255)
);


ALTER TABLE public.data_transfer_dtls OWNER TO sysadmin;

--
-- TOC entry 213 (class 1259 OID 117960)
-- Name: diagnosis_details; Type: TABLE; Schema: public; Owner: sysadmin
--

CREATE TABLE public.diagnosis_details (
    diagnosis_id integer NOT NULL,
    diagnosis character varying(255)
);


ALTER TABLE public.diagnosis_details OWNER TO sysadmin;

--
-- TOC entry 208 (class 1259 OID 117600)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: sysadmin
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO sysadmin;

--
-- TOC entry 210 (class 1259 OID 117945)
-- Name: hip_data_dtls; Type: TABLE; Schema: public; Owner: sysadmin
--

CREATE TABLE public.hip_data_dtls (
    id bigint NOT NULL,
    fhir_string text,
    labname character varying(255),
    transaction_id character varying(255)
);


ALTER TABLE public.hip_data_dtls OWNER TO sysadmin;

--
-- TOC entry 207 (class 1259 OID 117584)
-- Name: hip_request_dtls; Type: TABLE; Schema: public; Owner: sysadmin
--

CREATE TABLE public.hip_request_dtls (
    transaction_id character varying(255) NOT NULL,
    appointment_id character varying(255),
    data_push_url character varying(255),
    date_range_from character varying(255),
    date_range_to character varying(255),
    key_crypto_alg character varying(255),
    key_curve character varying(255),
    key_expiry character varying(255),
    key_parameters character varying(255),
    patient_name character varying(255),
    receiver_nonce character varying(255),
    receiver_public_key character varying(255),
    "timestamp" character varying(255),
    lab_name character varying(255)
);


ALTER TABLE public.hip_request_dtls OWNER TO sysadmin;

--
-- TOC entry 214 (class 1259 OID 117965)
-- Name: medicines_details; Type: TABLE; Schema: public; Owner: sysadmin
--

CREATE TABLE public.medicines_details (
    medicine_id integer NOT NULL,
    medicine character varying(255)
);


ALTER TABLE public.medicines_details OWNER TO sysadmin;

--
-- TOC entry 199 (class 1259 OID 116726)
-- Name: patient_dtls; Type: TABLE; Schema: public; Owner: sysadmin
--

CREATE TABLE public.patient_dtls (
    pd_id_pk integer NOT NULL,
    pd_dr_name character varying(255),
    pd_patient_name character varying(255),
    pd_mobile_no character varying(10),
    pd_email character varying(100),
    pd_appointment_id integer,
    pd_blood_grp character varying(50),
    pd_height integer,
    pd_weight integer,
    pd_gender character varying(10),
    pd_dob character varying(50),
    pd_abha_id character varying(100),
    pd_abha_no character varying(100)
);


ALTER TABLE public.patient_dtls OWNER TO sysadmin;

--
-- TOC entry 209 (class 1259 OID 117608)
-- Name: patient_report_dtls; Type: TABLE; Schema: public; Owner: sysadmin
--

CREATE TABLE public.patient_report_dtls (
    prd_id_pk integer NOT NULL,
    prd_dr_name character varying(255),
    prd_patient_name character varying(255),
    prd_report_type character varying(255),
    prd_report_path character varying(255),
    prd_created_tmstmp timestamp without time zone
);


ALTER TABLE public.patient_report_dtls OWNER TO sysadmin;

--
-- TOC entry 206 (class 1259 OID 117571)
-- Name: priscription_dtls; Type: TABLE; Schema: public; Owner: sysadmin
--

CREATE TABLE public.priscription_dtls (
    pd_id_pk integer NOT NULL,
    pd_dr_name character varying(255),
    pd_patient_name character varying(255),
    pd_symptoms character varying(255),
    pd_diagnosis character varying(255),
    pd_advice character varying(255),
    pd_temperature integer,
    pd_respiratory_rate integer,
    pd_heart_rate integer,
    pd_priscription_path character varying(255),
    uniqueid bigint,
    pd_medicine character varying(255),
    pd_blood_pressure_max integer,
    pd_blood_pressure_min integer,
    pd_blood_pressure integer,
    pd_json_path character varying(255)
);


ALTER TABLE public.priscription_dtls OWNER TO sysadmin;

--
-- TOC entry 215 (class 1259 OID 118346)
-- Name: report_dtls; Type: TABLE; Schema: public; Owner: sysadmin
--

CREATE TABLE public.report_dtls (
    labname character varying(255) NOT NULL,
    abhaid character varying(255),
    abhano character varying(255),
    appointmentid character varying(255),
    dremail character varying(255),
    drid character varying(255),
    drmcino character varying(255),
    drmob character varying(255),
    drname character varying(255),
    drsmcno character varying(255),
    drspeciality character varying(255),
    patientgender character varying(255),
    patientdob character varying(255),
    patientid character varying(255),
    patientmob character varying(255),
    patientname character varying(255)
);


ALTER TABLE public.report_dtls OWNER TO sysadmin;

--
-- TOC entry 3773 (class 0 OID 116389)
-- Dependencies: 198
-- Data for Name: advice; Type: TABLE DATA; Schema: master; Owner: sysadmin
--

INSERT INTO master.advice VALUES (1, 'Take Rest.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (2, 'Drink lot of water.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (3, 'Sleep properly.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (4, 'Avoid junk food.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (6, 'Crocin can be repeated every four hours.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (7, 'Asthalin Nebulizer to be given every six hours at  6 am, 12 Noon, 6 pm, and 12 Midnight.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (8, 'Lukewarm water sponging/bath in case of high fever.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (10, 'Follow the instructions given on Otrivin Leaflet before using it.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (11, 'Maintain a symptom diary.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (12, 'Instill two drops in each eye every 5 minutes for 30 minutes. Then, two drops in each eye every 30 minutes for 2 hours. Then, every 2 hourly.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (13, 'Use tissue to clean the eyes.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (14, 'Temperature record every six hours.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (15, 'Avoid outside uncooked food items.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (16, 'Give plenty of oral fluids.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (17, 'Give boiled and cooled water.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (18, 'Maintain hygiene at home.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (19, 'Give boiled and cooled water. Drink plenty of oral fluids to avoid dehydration. Give ORS.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (20, 'Avoid giving fruit juices, sports drinks, sugarcane juice instead of that give coconut water, chaach, sweet lemon water, lassi.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (21, 'Give home-cooked diet, soup, khichri, rice with curd, white bread.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (22, 'Avoid spicy and sour items.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (23, 'Give sweet items like kheer, halwa, custard, ice cream, shakes.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (24, 'Directly massage irritated gums with your finger or a clean, wet, refrigerated cloth.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (25, 'Give the baby a chilled wet cloth to chew on.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (26, 'Do not self-medicate with gel or pain killers.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (27, 'Keep baby distracted and busy in some activities.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (28, 'Give cold food like custard, yogurt, pureed fruits.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (29, 'Voice rest.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (30, 'Avoid chilled and sour beverages and eatables.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (31, 'Breast feed.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (32, 'Burping after every feed.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (33, 'No use of bottle.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (34, 'No ghutti or honey.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (35, 'No application of kajal or surma. No neck thread.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (36, 'Bulb suctioning.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (37, 'Increase cereal-based diet.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (38, 'Give high-calorie and high-protein diet.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (39, 'Breast milk de-addiction advice given.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (42, 'Review after 5 days or early if needed.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (43, 'Budesal can be given at 7 am , 3 pm, and 11 pm.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (44, 'Review as needed.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (45, 'Maintain a temperature record.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (47, 'Give plenty of fluids.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (48, 'Review after 2 days or early if symptoms worsen.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (49, 'Watch for other symptoms.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (50, 'Give a normal diet, but do not force to eat.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (51, 'Asthalin can be given every 12 hours at 6 am and 6 pm.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (53, 'Budesal can can be given every 12 hours  at 12 noon and 12 midnight.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (54, 'In addition to the infested person, same treatment is recommended for household members. All the members should be treated at the same time to prevent reinfestation.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (55, 'Bedding, clothing , and towels used by infested persons anytime during the three days before treatment should be decontaminated by washing in hot water and drying in a hot dryer ,by dry-cleaning, or by sealing in a plastic bag for atleast 72 hours. Scabies mites generally do not survive more than 2 to 3 days away from human skin. Itchy may last up to 1 month after the treatment.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (56, 'Asthalin Repsule can be given every six hours at 6 am ,12 noon , 6 pm, and 12 midnight.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (57, 'Follow the instructions given on OtrivinLeaflet before using it.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (58, 'In case of high grade fever, tap water sponging/bath is recommended.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (59, 'Vitcofol and Zincovit to be started after recovery.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (60, 'Stop bottle feeding. Avoid using rubber and plastic utensils for feeding.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (61, 'Normal bath without soap.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (62, 'Normal diet.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (63, 'Keep the child isolated till the scabs dry.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (64, 'Zifi and Azee to be started after blood test.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (65, 'Review with reports.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (66, 'Warm saline gargles.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (67, 'Tap water sponging/bath in case of high fever.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (68, 'Constipation advice given.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (69, 'Decrease milk. Increase cereal based diet.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (70, 'Crocin can be repeated every four hours. No other medicine to be given.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (71, 'Drink enough fluids like water, lemonade, juices to prevent dehydration.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (72, 'Protect yourself and your household members from mosquito bites by wearing protective clothing and mosquito repellent.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (73, 'Dengue can make you prone to bleeding. Therefore, you should watch closely for any of the following signs: gums bleeding after brushing your teeth, nosebleeds, easy bruising, sticky black stools, vomiting of blood, increased menstrual bleeding.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (74, 'Seek immediate medical attention if child develops: severe abdominal pain, sweating with cold, clammy hands and feet, repeated vomiting, excessive restlessness or lethargy.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (75, 'If child feels unwell at ant time, please got to a clinic or hospital immediately for further evaluation and management.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (76, 'Do not panic.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (77, 'Do not bundle up with excess clothing and blanket.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (78, 'The room temperature should be comfortable, not very hot or cool.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (79, 'Lukewarm water/lukewarm water sponging/bath in case of high fever.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (80, 'Give a normal diet but dont force to eat.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (81, 'Give anticonvulsant medications as advised.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (82, 'Follow the febrile seizures instructions (attachment).', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (161, 'Budesal can be given every 6 hours at 6 am, 12 noon, 6 pm, and 12 midnight.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (162, 'Vitcofol to be started after recovery.', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (716, 'Test Advice', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (736, 'Do not eat fast food', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (737, 'Test_takeBedRest', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (738, 'Take Rest', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (739, 'Drink water', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (740, 'Repeat Crocin twice a day for 3 days', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (741, 'Not Applicable', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (742, 'Oral fluids Maintain hydration', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (743, 'Plenty of oral fluids', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (744, 'Steam inhalation', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (745, 'Saturation monitoring', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (746, 'Drink plenty of oral fluids', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (747, 'Monitor urine output', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (748, 'Admission', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (749, 'Drink fluids', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (750, 'Re-establish breastfeeding', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (751, 'Nutritional counseling', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (752, 'Nutritional rehabilitation', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (753, 'Pediatric Endocrinologist opinion', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (754, 'Oxygen saturation monitoring', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (755, 'SOS Admit', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (756, 'Admit', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (757, 'Supportive care', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (758, 'Wear Mask', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (759, 'Take rest', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (760, 'stay home, Wear mask', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (761, 'Dipti Advice 1', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (762, 'Dipti Advice 2', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (763, 'do not eat after 7 PM at evening', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');
INSERT INTO master.advice VALUES (764, 'stay at home', '2022-07-15 20:23:56.340452', '2022-07-15 20:23:56.340452');


--
-- TOC entry 3780 (class 0 OID 117553)
-- Dependencies: 205
-- Data for Name: consultation_ruling_engine; Type: TABLE DATA; Schema: master; Owner: sysadmin
--

INSERT INTO master.consultation_ruling_engine VALUES (1, 6, '[25064002,162297001,466841000124105,13]', '[13,15,19,20]', '[1,4,7,9]', NULL, '2022-07-17 12:47:20.369', '2022-07-17 12:47:20.369');
INSERT INTO master.consultation_ruling_engine VALUES (2, 8, '[386661006,248447001,722892007,426000000]', '[2,4,5,13,23,27,28,36,48,49,50,54]', '[6,5,7,15,16,17,18,22,23,29,42]', NULL, '2022-07-17 14:54:09.955', '2022-07-17 14:54:09.955');
INSERT INTO master.consultation_ruling_engine VALUES (3, 9, '[278040002,299671008,298001000,299672001,247549004]', '[31,41,51,53,5]', '[31,32,67,92,78,17,18,22,23,29,42]', NULL, '2022-07-17 15:04:30.023', '2022-07-17 15:04:30.023');


--
-- TOC entry 3776 (class 0 OID 116736)
-- Dependencies: 201
-- Data for Name: medicines; Type: TABLE DATA; Schema: master; Owner: sysadmin
--

INSERT INTO master.medicines VALUES (1, 'Dolo650', 'Tablet', 'Paracetamol', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2, 'Crocin 500 mg', 'Tablet', 'Paracetamol', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (4, 'Asthalin Respule', 'Liquid', 'Salbutamol', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (5, 'Maxtra Tab', 'Tablet', 'Chlorpheniramine, Phenylephrine', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (7, 'Atarax', 'Syrup', 'hydroxyzine', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (8, 'Augmentin 625', 'Tablet', 'amoxicillin and clavulanic acid', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (9, 'Budesal', 'Liquid', 'Budesonide', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (10, 'Calshine-P', 'Drops', 'Cholecalciferol', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (11, 'Clavam Bid', 'Syrup', 'Amoxicillin and Clavulanic Acid', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (12, 'Colimex', 'Drops', 'Dicyclomine and Dimethicone', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (13, 'Darolac', 'Sachet', 'Lacto Bacillus Sporegens', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (14, 'Deriphyllin', 'Syrup', 'Etophylline and Theophylline', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (15, 'Enterogermina', 'Liquid', 'Bacillus Clausii Spores', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (16, 'Ibugesic', 'Syrup', 'Ibuprofen', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (17, 'Bandy', 'Suspension', 'Albendazole', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (18, 'Monocef', 'Injection', 'Ceftriaxone Sodium', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (19, 'Montair', 'Tablet', 'Montelukast', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (20, 'Frisium', 'Tablet', 'Clobazam', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (21, 'Ondem', 'Syrup', 'Ondansetron', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (22, 'Otrivin', 'Spray', 'Xylometazoline Hcl', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (23, 'Taxim O', 'Spray', 'Cefixime', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (24, 'Zincovit', 'Syrup', 'Multivitamin', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (25, 'Tonoferon', 'Syrup', 'Folic Acid, Iron Hydroxide and Vitamin B12', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (26, 'Vitcofol', 'Syrup', 'Cyanocobalamin, Ferrous Fumarate and Folic Acid', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (27, 'Nasoclear', 'Drops', 'Benzalkonium Chioride and Sodium Chloride', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (28, 'Azilide DT', 'Tablet', 'Azithromycin', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (29, 'T Minic', 'Syrup', 'Chlorpheniramine and Phenylephrine', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (30, 'Metrogyl', 'Suspension', 'Metronidazole', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (31, 'Laxiwal', 'Syrup', 'Lactulose', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (32, 'Eumosone', 'Cream', 'Clobetasone Topical', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (33, 'Laxopeg', 'Sachet', 'Polyethelene Glycol', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (34, 'T Bact', 'Ointment', 'Mupirocin Topical', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (35, 'Mycin Eye Drops', 'Drops', 'Chloramphenicol and Polymyxin B Sulphate', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (36, 'Phenzee', 'Syrup', 'Promethazine', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (40, 'Calapure Lotion', 'Liquid', 'Calamine Topical', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (41, 'Deriphyllin Retard', 'Tablet', 'Theophylline and Etophyllin', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (42, 'Zifi 100', 'Tablet', 'Cefixime', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (43, 'Azee-SYS', 'Syrup', 'Azithromycin', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (45, 'Desowen', 'Cream', 'Desonide', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (46, 'Glycerine Suppository', 'Liquid', 'Colace Suppositories contains glycerin', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (47, 'Shield', 'Ointment', 'Lidocaine-topical, Hydrocortisone-acetate-topical', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (48, 'Maxtra', 'Syrup', 'Phenylephrine', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (49, 'Budesal Respule via Nebulizer', 'Liquid', 'Budesonide', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (50, 'Crocin Suspension DS', 'Syrup', 'Paracetamol', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (51, 'Metaspray', 'Spray', 'mometasone furoate', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (52, 'Allegra', 'Tablet', 'fexofenadine', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (53, 'Permite Cream', 'Cream', 'permethrin', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (54, 'Borax Glycerine', 'Gel', 'Borax Topical , Glycerin Topical', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (55, 'Recofast', 'Syrup', 'Phenylephrine, Triprolidine', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (56, 'Augmentin DDS', 'Syrup', 'Amoxicillin', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (57, 'Otrivin P nasal', 'Spray', 'xylometazoline', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (58, 'Midacip', 'Spray', 'Midazolam topical', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (152, 'AB PHYLLINE,100MG', 'CAPSULE', 'ACEBROPHYLLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (153, 'AB PHYLLINE SYRUP,10MG, 1.80MG', 'SYRUP', 'ACEBROPHYLLINE, METHYLPARABEN IP, PROPLYPARABEN IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (154, 'ABZORB POWDER,100 GM', 'POWDER', 'CLOTRIMAZOLE POWDER', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (155, 'ACAMPROL,333MG', 'TABLET', 'ACAMPROSATE CALCIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (156, 'ACOSTIN 3 MIU,3 MILLION IU', 'POWDER', 'COLISTIMETHATE SODIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (157, 'ACOSTIN FORTE,2 MILLION IU', 'POWDER', 'COLISTIMETHATE SODIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (158, 'ACOSTIN INJ 1 MIU,1 MILLION IU', 'POWDER', 'COLISTIMETHATE SODIUM BP 1000000 IU', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (159, 'ACROTAC CAPS 10 MG,10MG', 'CAPSULE', 'ACITRETIN 10MG,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (160, 'ACROTAC CAPS 25 MG,25 MG', 'CAPSULE', 'ACITRETIN 25MG CAPS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (161, 'ACTIZO DT,40 MG + 240MG', 'TABLET', 'ARTEMETHER , LUMEFANTRINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (162, 'ACTIZO DT,80 MG + 480MG', 'TABLET', 'ARTEMETHER , LUMEFANTRINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (163, 'ACTIZO DT,20 MG + 120MG', 'TABLET', 'ARTEMETHER , LUMEFANTRINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (164, 'ACUCAL,200MG', 'TABLET', 'CALCIUM CITRATE, VITAMIN D3, MAGNESIUM HYDROXIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (165, 'ADCAPONE,200MG', 'TABLET', 'ENTACAPONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (166, 'ADDWIZE 10MG 10 TAB,10MG', 'TABLET', 'METHYL PHENIDATE HYDROCHLORIDE VSP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (167, 'ADFOVIR,10MG', 'TABLET', 'ADEFOVIR DIPIVOXIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (168, 'ADHEB TABLET,10 MG', 'TABLET', 'ADEFOVIR 10MG TABS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (169, 'ADMENTA-10,10MG', 'TABLET', 'MEMANTINE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (170, 'ADMENTA-5,5MG', 'TABLET', 'MEMANTINE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (171, 'ADVADOX INJECTION,2 MG', 'INJECTION', 'DOXORUBICIN HYDROCHLORIDE INJECTION', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (172, 'AFDURA,10 MG, 0.5 MG', 'TABLET', 'ALFUZOSIN HYDROCHLORIDE BP, DUTASTERIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (173, 'ALCAINE-MPS 200ML 1 BTL,5ML, 50MG', 'SYRUP', 'MEGALDRATE , OXYTHAZINE BP, METHYLPOLYSILOXANE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (174, 'ALCOLIV,500MG', 'TABLET', 'METADOXINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (175, 'ALDORACE TABLET,50 MG', 'TABLET', 'EPALRESTAT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (176, 'ALTIVA TABLET 120MG,120 MG', 'TABLET', 'FEXOFENADINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (177, 'ALTRADAY CAPSULE,200MG + 20MG', 'CAPSULE', 'ACECLOFENAC IP 200 MG , RABEPRAZOLE SODIUM IP 20 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (178, 'ALTRAFLAM-P,100 MG + 325 MG', 'TABLET', 'ACECLOFENAC,PARACETAMOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (179, 'ALZOLAM 0.25MG,0.25MG', 'TABLET', 'ALPRAZOLAM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (180, 'ALZOLAM 0.5MG,0.5MG', 'TABLET', 'ALPRAZOLAM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (181, 'ALZOLAM 1.0MG,1.00MG', 'TABLET', 'ALPRAZOLAM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (182, 'AM-LAQER,5% W/V, 55%', 'LIQUID', 'AMOROLFINE, ETHANOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (183, 'AMEXIDIL SOLUTION,60 ML', 'SOLUTION', 'MINOXIDIL IP 5.0%,AMINEXIL 1.5% ,ALCOHOL 95%', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (184, 'AMIVAL TABLET. 100MG,100 MG', 'TABLET', 'AMISULPRIDE TABLET 100MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (185, 'AMIVAL TABLET. 200MG,200 MG', 'TABLET', 'AMISULPRIDE TABLET 200MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (186, 'AMIVAL TABLET. 50MG,50 MG', 'TABLET', 'AMISULPRIDE TABLET 50MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (187, 'AMIXIDE,25MG, 10MG', 'TABLET', 'AMITRIPTYLINE IP, CHLORIDIAZEPOXIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (188, 'AMIXIDE-5,25MG, 5MG', 'TABLET', 'AMITRIPTYLINE IP, CHLORIDIAZEPOXIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (189, 'AMIXIDE-H,12.5MG, 5MG', 'TABLET', 'AMITRIPTYLINE IP, CHLORIDIAZEPOXIDEI IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (190, 'AMLOBET,5MG, 50MG', 'TABLET', 'AMLODIPINE, ATENOLOL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (191, 'AMLOSUN 5,5MG', 'TABLET', 'AMLODIPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (192, 'AMYLAC CREAM,50 GM', 'CREAM', 'AMMONIUM LACTATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (193, 'AMYLAC LOTION,50 ML', 'LOTION', 'AMMONIUM LACTATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (194, 'ANABREZ,1MG', 'TABLET', 'ANASTROZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (195, 'ANDROBLOK,50MG', 'TABLET', 'BICALUTAMIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (196, 'ANGISTAT 2.5 MG,2.5 MG', 'TABLET', 'NITRO GLYCERINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (197, 'ANGISTAT 6.5 MG,6.5 MG', 'TABLET', 'NITRO GLYCERINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (198, 'ANGIZEM 30,30MG', 'TABLET', 'DILTIAZEM HCL USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (199, 'ANGIZEM 60,60MG', 'TABLET', 'DILTIAZEM HCL USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (200, 'ANGIZEM-CD 120,120MG', 'CAPSULE', 'DILTIAZEM HCL USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (201, 'ANGIZEM-CD 180,180MG', 'CAPSULE', 'DILTIAZEM HCL USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (202, 'ANGIZEM-CD 90,90MG', 'CAPSULE', 'DILTIAZEM HCL USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (203, 'ANOFER LIQUID,60MG, 0.75MG, 6MCG, 11MG', 'SYRUP', 'CARBONYL IRON, FOLIC ACID IP, CYANOCOBALAMIN IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (204, 'ANOFER SP,120MG, 25MG, 1.5MG,12MCG', 'TABLET', 'IRON, ZINC OXIDE IP, FOLIC ACID IP, CYANOCOBALAMIN IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (205, 'APRELIEF CAPSULE - KIT,125MG+80MG', 'CAPSULE', 'APREPITANT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (206, 'AQUAMET NASAL SPRAY,0.05% W/V', 'VIALS', 'MOMETASONE FUROATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (207, 'AQUAZIDE 12.5,12.5MG', 'TABLET', 'HYDROLCHLOROTHIAZIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (208, 'AQUAZIDE 25,25MG', 'TABLET', 'HYDROLCHLOROTHIAZIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (209, 'ARPIZOL 5,5MG', 'TABLET', 'ARIPIPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (210, 'ARPIZOL-10,10MG', 'TABLET', 'ARIPIPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (211, 'ARPIZOL-15,15MG', 'TABLET', 'ARIPIPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (212, 'ARPIZOL-20,20MG', 'TABLET', 'ARIPIPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (213, 'ARPIZOL-30,30MG', 'TABLET', 'ARIPIPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (214, 'ASGINASE 10000 IU,10000 IU', 'INJECTION', 'L-ASPARAGINASE 10000 IU', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (215, 'ASGINASE 5000 IU,5000 IU', 'INJECTION', 'L-ASPARAGINASE 5000 IU', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (216, 'ATTENTROL 10,10MG', 'CAPSULE', 'ATOMOXETINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (217, 'ATTENTROL 18,18MG', 'CAPSULE', 'ATOMOXETINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (218, 'ATTENTROL 25,25MG', 'CAPSULE', 'ATOMOXETINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (219, 'AVESSA 100 OCTACAPS,UA', 'DPI', 'FLUTICASONE PROPIONATE IP 100MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (220, 'AVESSA 250 OCTACAPS,UA', 'DPI', 'FLUTICASONE PROPIONATE IP 250MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (221, 'AVESSA 500 OCTACAPS,UA', 'DPI', 'FLUTICASONE PROPIONATE IP 500MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (222, 'AZELAST EYE DROPS 0.5MG/5ML,0.5MG', 'DROPS', 'AZELASTINE HYDROCHLORIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (223, 'AZTOR 80,80MG', 'TABLET', 'ATORVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (224, 'AZTOR ASP 150,10 MG, 150 MG', 'TABLET', 'ATORVASTATIN, ASPIRIN IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (225, 'AZTOR ASP-75,10MG, 75MG', 'CAPSULE', 'ATORVASTATIN, ASPIRIN IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (226, 'AZTOR EZ,10MG,10MG', 'TABLET', 'ATORVASTATIN, EZETIMIBE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (227, 'AZTOR EZ 20,20MG, 20MG', 'TABLET', 'ATORVASTATIN, EZETIMIBE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (228, 'AZTOR-10,10MG', 'TABLET', 'ATORVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (229, 'AZTOR-20,20MG', 'TABLET', 'ATORVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (230, 'AZTOR-40,40MG', 'TABLET', 'ATORVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (231, 'AZTOR-5,5MG', 'TABLET', 'ATORVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (232, 'BAXIMIB INJECTION 2 MG,2 MG', 'INJECTION', 'BORTEZOMIB.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (233, 'BAXMUNE TABLET 500 MG.,500MG', 'TABLET', 'MYCOPHENOLATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (234, 'BENFOMET,100MG,0.5MG, 50MG', 'CAPSULE', 'BENFOTIAMINE, MECOBLAMIN , VITAMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (235, 'BENFOMET PLUS,100MG, 0.5MG,50MG', 'TABLET', 'BENFOTIAMINE , ALPHA LIPOIC ACID USP, MECOBALAMIN, PYRIDOXINE HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (236, 'BETACAP 10,10MG', 'TABLET', 'PROPRANOLOL HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (237, 'BETACAP 20,20MG', 'TABLET', 'PROPRANOLOL HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (238, 'BETACAP PLUS 10,40MGF, 10MG', 'CAPSULE', 'PROPRANOLOL HYDROCHLORIDE IP, FLUNARIZINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (239, 'BETACAP PLUS 5,40MG, 5MG', 'CAPSULE', 'PROPRANOLOL HYDROCHLORIDE IP, FLUNARIZINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (240, 'BETACAP TR 60,60MG', 'CAPSULE', 'PROPRANOLOL HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (241, 'BETACAP-TR 40,40MG', 'CAPSULE', 'PROPANOLOL HCL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (242, 'BETACAP-TR 80,80MG', 'CAPSULE', 'PROPANOLOL HCL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (243, 'BETATROP,20MG,50MG', 'TABLET', 'NIFEDIPINE USP, ATENOLOL BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (244, 'BETAVERT,8 MG', 'TABLET', 'BETAHISTINE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (245, 'BETAVERT 24,24MG', 'TABLET', 'BETAHISTINE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (246, 'BETAVERT-16,16MG', 'TABLET', 'BETAHISTINE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (247, 'BIVAFLO,250MG', 'VIALS', 'BIVALIRUDIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (248, 'BONISTA CARTRIDGE,750MCG / 3ML', 'INJECTION', 'TERIPARATIDE (R-HUMAN PARATHYROID HORMONE)', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (249, 'BRIMOLOL,1.5MG, 0.01% W/V', 'DROPS', 'BRIMONIDINE TARTRATE, TIMOLOL, BENZALKONIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (250, 'BRIMOSUN LS,1MG,0.005% W/V', 'DROPS', 'BRIMONIDINE TARTRATE, OXYCHLORO COMPLEX', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (251, 'BRIMOSUN-P,1.5MG', 'DROPS', 'BRIMONIDINE TARTRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (252, 'BUDEZ CR,3MG', 'CAPSULE', 'BUDESONIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (253, 'BUPRON XL 150,150 mg', 'Tablet', 'BUPROPION HYDROCHLORIDE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (254, 'BUPRON XL 300,300 mg', 'TABLET', 'BUPROPION HYDROCHLORIDE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (255, 'CABERLIN 0.25,0.25MG', 'TABLET', 'CABERGOLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (256, 'CABERLIN 0.5 2 TAB,0.5MG', 'TABLET', 'CABERGOLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (257, 'CABGOLIN 0.25,0.25MG', 'TABLET', 'CABERGOLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (258, 'CABGOLIN 0.5 2 TAB,0.5 MG', 'TABLET', 'CABERGOLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (259, 'CALMPOSE INJ 2ML,10 MG', 'INJECTION', 'DIAZEPAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (260, 'CALMPOSE TABLET,5 MG', 'TABLET', 'DIAZEPAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (261, 'CALURAN TABLET 50 MG. 10S,50 MG', 'TABLET', 'BICALUTAMIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (262, 'CALURAN TABLET 50 MG.30S,50 MG', 'TABLET', 'BICALUTAMIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (263, 'CANSOFT,100MG', 'PESSERY', 'CLOTRIMAZOLE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (264, 'CARCIDOX,200MG', 'CAPSULE', 'DOXIFLURIDIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (265, 'CARDIBETA AM TABLET 25 MG,25MG + 2.5MG', 'TABLET', 'METOPROLOL , AMLODIPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (266, 'CARDIBETA AM TABLET 50 MG,50 MG + 5MG', 'TABLET', 'METOPROLOL , AMLODIPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (267, 'CARDIBETA TABLET 100 MG,100 MG', 'TABLET', 'METOPROLOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (268, 'CARDIBETA XR TABLET 12.5 MG,12.5 MG', 'TABLET', 'METOPROLOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (269, 'CARDIBETA XR TABLET 25 MG,25 MG', 'TABLET', 'METOPROLOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (270, 'CARDIBETA XR TABLET 50 MG,50 MG', 'TABLET', 'METOPROLOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (271, 'CARDIJECT LYOPHILISED INJ 250MG,250MG', 'VIALS', 'DOBUTAMINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (272, 'CARDIVAS 12.5,12.5MG', 'TABLET', 'CARVEDILOLG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (273, 'CARDIVAS 25MG,25MG', 'TABLET', 'CARVEDILOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (274, 'CARDIVAS 3.125,3.125MG', 'TABLET', 'CARVEDILOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (275, 'CARDIVAS 6.25,6.25MG', 'TABLET', 'CARVEDILOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (276, 'CAREPROST,0.3MG, 0.01% W/V', 'VIALS', 'BIMATOPROST, BENZALKONIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (277, 'CAREPROST PLUS,0.3MG, 5MG, 0.01% W/V', 'DROPS', 'BIMATOPROST, TIMOLOL, BENZALKONIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (278, 'CAREVON INJECTION,1.5MG / ML', 'INJECTION', 'EDARAVONE 1.5 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (279, 'CARNIVIT 500 MG TABLET,500 MG', 'TABLET', 'L-CARNITINE L-TARTRATE725 MG, EQU TO L-CARNITINE 500 MG COLOUR: TITANIUM DIOXIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (280, 'CARTIDIN GM TABLET,50 MG+500 MG', 'TABLET', 'DIACEREIN 50 MG,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (281, 'CARTISHINE,50MG', 'CAPSULE', 'DIACEREIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (282, 'CASPORAN INJECTION 50MG,50 MG', 'INJECTION', 'CASPOFUNGIN ACETATE 50MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (283, 'CASPORAN INJECTION 70MG,70 MG', 'INJECTION', 'CASPOFUNGIN ACETATE 70MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (284, 'CAVERTA TABLET 100MG,100 MG', 'TABLET', 'SILDENAFIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (285, 'CAVERTA TABLET 25MG,25 MG', 'TABLET', 'SILDENAFIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (286, 'CAVERTA TABLET 50MG,50 MG', 'TABLET', 'SILDENAFIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (287, 'CAXETA 500,500MG', 'TABLET', 'CAPECITABINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (288, 'CEFDIEL CAP,300 MG', 'CAPSULE', 'CEFDINIR', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (289, 'CEFDIEL SUS 30ML,125 MG/5 ML', 'SUSPENSION', 'CEFDINIR', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (290, 'CEPODEM AZ TABLET,200 + 250 MG', 'TABLET', 'CEFPODOXIME PROXETIL,AZITHROMYCIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (291, 'CEPODEM DT 100MG,100 MG', 'TABLET', 'CEFPODOXIME PROXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (292, 'CEPODEM DT 50MG,50 MG', 'TABLET', 'CEFPODOXIME PROXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (293, 'CEPODEM O TABLET,200 MG', 'TABLET', 'CEFPODOXIME PROXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (294, 'CEPODEM SUSPENSION DS 100 MG/5ML,100 MG/5 ML', 'SUSPENSION', 'CEFPODOXIME PROXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (295, 'CEPODEM SUSPENSION DS 50 MG/5ML 30ML,50 MG/5 ML', 'SUSPENSION', 'CEFPODOXIME PROXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (296, 'CEPODEM TABLET 200MG,200 MG', 'TABLET', 'CEFPODOXIME PROXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (297, 'CEPODEM TABLET 100MG,100 MG', 'TABLET', 'CEFPODOXIME PROXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (298, 'CEPODEM XP DRY SYRUP,10 GM', 'SUSPENSION', 'CEFPODOXIME PROXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (299, 'CEPODEM XP DS 100,100+62.5', 'TABLET', 'CEFPODOXIME PROXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (300, 'CEPODEM XP DT,100 MG', 'TABLET', 'CEFPODOXIME PROXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (301, 'CEPODEM XP DT 50MG,50+31.25', 'TABLET', 'CEFPODOXIME PROXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (302, 'CEPODEM XP TABLET 325MG,325MG', 'TABLET', 'CEFPODOXIME PROXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (303, 'CERELOID,1MG', 'TABLET', 'ERGOLOID MESYLETES USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (304, 'CERESTAR CAP,50 MG + 60MG', 'CAPSULE', 'GINKO BILOBA COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (305, 'CERITON-EPO 10000 IU (RHE),10000 IU/ML', 'INJECTION', 'ERYTHROPOETIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (306, 'CERITON-EPO 2000 IU (RHE),MULTIPLE INGREDIENTS', 'INJECTION', 'ERYTHROPOETIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (307, 'CERITON-EPO 4000 IU (RHE),MULTIPLE INGREDIENTS', 'INJECTION', 'ERYTHROPOETIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (308, 'CERNOS,40MG', 'CAPSULE', 'TESTOSTERONE UNDECANOATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (309, 'CERNOS GEL,1% W/W,', 'SACHET', 'TESTOSTERONE USP, ETHANOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (310, 'CEROXIM TABLET,250 MG', 'TABLET', 'CEFUROXIME AXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (311, 'CEROXIM TABLET,500 MG', 'TABLET', 'CEFUROXIME AXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (312, 'CEROXIM XP 375 MG TABLET,250MG + 125 MG', 'TABLET', 'CEFUROXIME AXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (313, 'CEROXIM XP 625 MG TABLET,500MG + 125 MG', 'TABLET', 'CEFUROXIME AXETIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (314, 'CEROXIM-I 1.5GM INJECTION,1.5GM/VIAL', 'INJECTION', 'CEFUROXIME SODIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (315, 'CEROXIM-I 750 INJECTION,750 MG', 'INJECTION', 'CEFUROXIME SODIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (316, 'CERUVIN A CAPSULE,75+75MG', 'CAPSULE', 'CLOPIDOGREL,ASPIRIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (317, 'CERUVIN AF CAPSULE,75+150MG', 'CAPSULE', 'CLOPIDOGREL,ASPIRIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (318, 'CERUVIN TABLET 150 MG.,150 MG', 'TABLET', 'CLOPIDOGREL+ASPIRIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (319, 'CERUVIN TABLET 75 MG,75 MG', 'TABLET', 'CLOPIDOGREL,ASPIRIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (320, 'CETRIZET,10MG', 'TABLET', 'CETIRIZINE DIHYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (321, 'CETRIZET 5,5MG', 'TABLET', 'CETIRIZINE DIHYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (466, 'ENCORATE-CHRONO 500,500MG', 'TABLET', 'SODIUM VALPROATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (322, 'CETRIZET D,5MG, 20MG', 'TABLET', 'CETIRIZINE HYDROCHLORIDE BP, PHENYLEPHRINE HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (323, 'CIALO LOTION,100ML', 'LOTION', 'CALAMINE IP 8.0% W/W', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (324, 'CIFRAN CT TABLET,500 MG+600 MG', 'TABLET', 'CIPROFLOXACIN COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (325, 'CIFRAN CTH TABLET,250 MG+300 MG', 'TABLET', 'CIPROFLOXACIN COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (326, 'CIFRAN EYE DROP,3MG/ML', 'EYE DROPS', 'CIPROFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (327, 'CIFRAN INFUSION,200 MG/100 ML', 'INFUSION', 'CIPROFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (328, 'CIFRAN TABLET 1000 MG,1 GM', 'TABLET', 'CIPROFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (329, 'CIFRAN TABLET 500 MG,500 MG', 'TABLET', 'CIPROFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (330, 'CIFRAN OZ INFUSION KIT,100ML', 'INFUSION', 'CIPROFLOXACIN,ORNIDAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (331, 'CIFRAN OZ TABLET,200 MG + 500 MG', 'TABLET', 'CIPROFLOXACIN,ORNIDAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (332, 'CIFRAN TABLET 100 MG,100 MG', 'TABLET', 'CIPROFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (333, 'CIFRAN TABLET 250 MG,250 MG', 'TABLET', 'CIPROFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (334, 'CIFRAN TABLET 750 MG,750 MG', 'TABLET', 'CIPROFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (335, 'CILANEM CDS 500MG 100ML,500 MG', 'INJECTION', 'IMIPENEM,CILASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (336, 'CILANEM 1G,1 GM', 'INJECTION', 'IMIPENEM,CILASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (337, 'CILANEM INJ 250MG,250 MG', 'INJECTION', 'IMIPENEM,CILASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (338, 'CILANEM INJ 500MG,500 MG', 'INJECTION', 'IMIPENEM,CILASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (340, 'CILENTRA PLUS,10 MG + 0.5 MG', 'TABLET', 'ESCITALOPRAM,CLONAZAPAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (341, 'CILENTRA TABLET. 10 MG.,10 MG', 'TABLET', 'ESCITALOPRAM 10MG,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (342, 'CILENTRA TABLET. 20 MG.,20 MG', 'TABLET', 'ESCITALOPRAM 20MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (343, 'CILENTRA TABLET. 5 MG.,5 MG', 'TABLET', 'ESCITALOPRAM 5MG,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (344, 'CITELAC INJ 250MG 2ML,250 MG', 'INJECTION', 'CITICHOLINE 250MG INJN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (345, 'CITELAC TABLET 500 MG,500 MG', 'TABLET', 'CITICHOLINE 500MG TABS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (346, 'CITELEC OD 1GM TABLET,100 MG', 'TABLET', 'CITICOLINE SODIUM EQUIVALENT TO CITICOLINE 1 G', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (347, 'CITOPAM 20,20MG', 'TABLET', 'CITALOPRAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (348, 'CLEFT TABLET 10 MG.,10MG', 'TABLET', 'LEFLUNOMIDE 10MGÂ &Â Â  TITANIUM DIOXIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (349, 'CLEFT TABLET 20 MG.,20 MG', 'TABLET', 'LEFLUNOMIDE 20MGÂ & TITANIUM DIOXIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (350, 'CLIXEL INJ 100 MG,100 MG', 'INJECTION', 'PACLITAXEL 100MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (351, 'CLIXEL INJ 30 MG,30 MG', 'INJECTION', 'PACLITAXEL 30MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (352, 'CLIXEL INJ 300 MG,300 MG', 'INJECTION', 'PACLITAXEL 300MG INJNS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (353, 'CLOFRANIL,25MG', 'TABLET', 'CLOMIPRAMINE HCL BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (354, 'CLOFRANIL 10,10MG', 'TABLET', 'CLOMIPRAMINE HCL BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (355, 'CLOFRANIL 50,50MG', 'TABLET', 'CLOMIPRAMINE HCL BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (356, 'CLOFRANIL-SR,75MG', 'TABLET', 'CLOMIPRAMINE HCL BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (357, 'COBESE CAP.120MG,120 MG', 'CAPSULE', 'ORLISTAT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (358, 'COBESE CAPSULE 60 MG,60 MG', 'CAPSULE', 'ORLISTAT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (359, 'COGNITOL-5,5MG', 'TABLET', 'VINPOCETINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (360, 'COLVAC,10MG', 'TABLET', 'SODIUM PICOSULPHATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (361, 'COMBITIDE-100 DISK,50MCG., 100MCG', 'INHALER', 'SALMETEROL . FLUTICASONE PROPIONATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (362, 'COMBITIDE-250 DISK,50MCG, 250MCG', 'INHALER', 'SALMETEROL. FLUTICASONE PROPIONATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (363, 'CONADERM SHAMPOO WITH ZPTO,50 ML', 'SHAMPOO', 'KETOCONAZOLE IP 2% W / V', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (364, 'CONTIFLO D KIT,S10', 'TABLET', 'TAMSULOSIN DUTASTERIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (365, 'CONTIFLO ICON TABLET 0.4MG,0.4 MG', 'TABLET', 'TAMSULOSIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (366, 'CONTIFLO OD- F TABLET,0.4 MG + 5 MG', 'TABLET', 'TAMSULOSIN FINASTERIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (367, 'CONVIRON FORTE CAPSULE,60 MG', 'CAPSULE', 'ASCORBIC,CYANOCO,FERR SUL,FOLIC,PYRIDO', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (368, 'COVAMLO TABLET,50 MG+12.5 MG', 'TABLET', 'AMLODIPINE COMB.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (369, 'COVANCE CT,50MG+12.5MG', 'TABLET', 'LOSARTAN POTASSIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (370, 'COVANCE TABLET 25 MG,25 MG', 'TABLET', 'LOSARTAN POTASSIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (371, 'COVANCE TABLET 50 MG,50 MG', 'TABLET', 'LOSARTAN POTASSIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (373, 'COVANCE-AT TABLET,50 MG + 50 MG', 'TABLET', 'LOSARTAN ATENOLOL COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (374, 'COVANCE-D TABLET,50 MG+12.5 MG', 'TABLET', 'LOSARTAN COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (376, 'CPZ-100(CHLORPROMAZINE),100MG', 'TABLET', 'CHLORPROMAZINE HCL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (377, 'CPZ-50(CHLORPROMAZINE),50MG', 'TABLET', 'CHLORPROMAZINE HCL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (378, 'CRIXAN GEL 1% W/W 15 GM,15 GM', 'GEL', 'CLARITHROMYCIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (379, 'CRIXAN TABLET,500 MG', 'TABLET', 'CLARITHROMYCIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (380, 'CRIXAN SUSPENSION 125 MG/5 ML,125 MG/5 ML', 'SUSPENSION', 'CLARITHROMYCIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (381, 'CROLIM CAPSULE 1MG,1MG', 'CAPSULE', 'TACROLIMUS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (382, 'CROLIM CAPSULE 0.5MG,.50MG', 'CAPSULE', 'TACROLIMUS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (383, 'CROLIM CAPSULE 1 MG,1 MG', 'CAPSULE', 'TACROLIMUS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (384, 'CROLIM OINTMENT 15 GM 0.03% W/W,0.0003', 'OINTMENT', 'TACROLIMUS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (385, 'CROLIM OINTMENT 15GM 0.1% W/W,0.001', 'OINTMENT', 'TACROLIMUS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (386, 'CUTIZONE CREAM,15 GM', 'CREAM', 'MOMETASONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (387, 'CUTIZONE OINTMENT,15 GM', 'OINTMENT', 'MOMETASONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (388, 'CYCLOMUNE,0.5MG', 'DROPS', 'CYCLOSPORINE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (389, 'CYCLOMUNE EYE DROPS 0.1%,1MG', 'DROPS', 'CYCLOSPORINE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (390, 'CYCLOPENT 1%-5ML,0.01', 'VIALS', 'CYCLOPENTOLATE HCL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (391, 'CYSTOPEN CAPSULE 100MG,100 MG', 'CAPSULE', 'PENTOSAN POLYSULFATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (392, 'D-VENIZ 100,100MG', 'TABLET', 'DESVENLAFAXINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (393, 'D-VENIZ 50,50MG', 'CAPSULE', 'DESVENLAFAXINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (394, 'D-WELL CHEWTABLET,60000 IU', 'CHEWABLE TABLET', 'CHOLECALCIFEROL (VITAMIN D?)', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (395, 'D-WELL DROPS,400 IU', 'DROPS', 'CHOLECALCIFEROL (VITAMIN D?)', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (691, 'LONAZEP-MD 0.5,0.5MG', 'TABLET', 'CLONAZEPAM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (396, 'D-WELL MOUTH DISSOLVING GRANULES,60000 IU', 'CHEWABLE TABLET', 'CHOLECALCIFEROL (VITAMIN D?)', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (397, 'D-WELL SOFTGELS,60000 IU', 'SOFTGEL', 'CHOLECALCIFEROL (VITAMIN D?)', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (398, 'DARBESURE 25MG,25 MCG', 'INJECTION - PFS', 'DARBEPOETIN ALFA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (399, 'DARBESURE 40MG,40 MCG', 'INJECTION - PFS', 'DARBEPOETIN ALFA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (400, 'DARILONG 15,15MG', 'TABLET', 'DARIFENACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (401, 'DARILONG 7.5,7.5MG', 'TABLET', 'DARIFENACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (402, 'DARITEN 15MG TABLET,7.5 MG', 'TABLET', 'DARIFENACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (403, 'DARITEN 7.5MG TABLET,7.5MG', 'TABLET', 'DARIFENACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (404, 'DAZIT,5MG', 'TABLET', 'DESLORATIDINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (405, 'DAZOLIC,500MG', 'TABLET', 'ORNIDAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (406, 'DEPOPRED 1ML,40MG', 'VIALS', 'METHYLPREDNISOLONE ACETATE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (407, 'DEPOPRED 2ML,40MG', 'VIALS', 'METHYLPREDNISOLONE ACETATE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (408, 'DESLOR,5MG', 'TABLET', 'DESLORATIDINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (409, 'DESVAL ER TABLET 1000MG,100 MG', 'ER TABLET', 'DIVALPROREX', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (410, 'DESVAL ER TABLET 125 MG,125 MG', 'ER TABLET', 'DIVALPROREX', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (411, 'DESVAL ER TABLET 250 MG,250 MG', 'ER TABLET', 'DIVALPROREX', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (412, 'DESVAL ER TABLET 500 MG,500 MG', 'ER TABLET', 'DIVALPROREX', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (413, 'DESVAL ER TABLET 750 MG,750 MG', 'ER TABLET', 'DIVALPROREX', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (414, 'DICORATE ER 125,250MG', 'TABLET', 'VALPROIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (415, 'DICORATE ER 750,750MG', 'TABLET', 'VALPROIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (416, 'DICORATE-ER 250,250MG', 'TABLET', 'VALPROIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (417, 'DICORATE-ER 500,500MG', 'TABLET', 'VALPROIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (418, 'DILTIACT,2%W/W', 'TUBE', 'DILTIAZEM HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (419, 'DIPROBEC CREAM,15 GM', 'CREAM', 'BECLOMETHASONE DIPROPIONATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (420, 'DIPROBEC LOTION,30 ML', 'LOTION', 'BECLOMETHASONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (421, 'DIPROVATE PLUS CREAM,20 GM', 'CREAM', 'BETAMETHASONE DIPROPIONATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (422, 'DIPROVATE PLUS ES OINTMENT,20 GM', 'CREAM', 'BETAMETHASONE DIPRO, SALICYLIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (423, 'DIPROVATE PLUS G CREAM,20 GM', 'CREAM', 'BETAMETHASONE DIPRO, GENTAMYCIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (424, 'DIPROVATE PLUS LOTION (DISPENSER),50 ML', 'LOTION', 'BETAMETHASONE 0.05% W/V', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (425, 'DIPROVATE PLUS N CREAM,20 GM', 'CREAM', 'BETAMETHASONE DIPRO, NEOMYCIN SULPHATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (426, 'DIPROVATE PLUS S OINTMENT,20 GM', 'CREAM', 'BETAMETHASONE DIPRO, SALICYLIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (427, 'DIPROVATE RD CREAM,20 GM', 'CREAM', 'BETAMETHASONE DIPROPIONATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (428, 'DISTENIL,400MG, 80MG', 'TABLET', 'CHARCOAL IP, SIMETHICONE IP M', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (429, 'DOBESIL CAPS,500 MG', 'CAPSULE', 'CALCIUM DOBESILATE MONOHYDRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (430, 'DOBESIL H CREAM 30G TUBE,30G', 'CREAM', 'ANHYDROUS CALCIUM DOBESILATE,LIGNOCAINE HYDROCHLORIDE,ANHYDROUS LIGNOCAINE,HYDROCORTISONE ACETATE,ZINC OXIDE,CHLOROCRESOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (431, 'DOCEFREZ 20,20MG', 'VIALS', 'DOCETAXEL ANHYDROUS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (432, 'DOCEFREZ 80,80MG', 'VIALS', 'DOCETAXEL ANHYDROUS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (433, 'DOLAMIDE TABLET,100MG+325MG', 'TABLET', 'NIMESULIDE,PARACETAMOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (434, 'DONAMEM 10,10MG, 5MG', 'TABLET', 'MEMANTINE HYDROCHLORIDE, DOMEPERIL HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (435, 'DONAMEM 5,5MG , 5MG', 'TABLET', 'MEMANTINE HYDROCHLORIDE, DOMEPERIL HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (436, 'DRONIS 20,3MG, 0.02MG', 'TABLET', 'DROSPIRENONE USP, ETHINYLOESTRADIOL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (437, 'DRONIS 30,3MG, 0.03MG', 'TABLET', 'DROSPIRENONE USP, ETHINYLOESTRADIOL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (438, 'DUDROP,14MG, 6MG, 9.028% W/V', 'DROPS', 'POLYVINYL ALCOHOL USP, POVIDONE IP, SODIUM PERBORATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (439, 'DULANE 20,20MG', 'CAPSULE', 'DULOXETINE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (440, 'DULANE 30,30MG', 'CAPSULE', 'DULOXETINE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (441, 'DUTAGEN SOFGEL 0.5 MG.,0.5MG', 'SOFTGELS', 'DUTASTERIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (442, 'DUZELA 20,20MG', 'CAPSULE', 'DULOXETINE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (443, 'DUZELA 30,30MG', 'CAPSULE', 'DULOXETINE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (444, 'DUZELA 40,40MG', 'CAPSULE', 'DULOXETINE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (445, 'DUZELA 60,60MG', 'CAPSULE', 'DULOXETINE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (446, 'DYNOLAP 5,5MG', 'TABLET', 'OLOPATADINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (447, 'EFFERVEN TABLET 600 MG,600MG', 'TABLET', 'EFAVIRENZ', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (448, 'EFFODAY TABLET,(300+300+600)MG', 'TABLET', 'TENOFAVIR 300MG,LAMIVUDINE 300MG, EFAVIRENZ 600MG)', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (449, 'EFLORA CREAM 13.9% W/W 1,15 GM', 'CREAM', 'EFLORNITHINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (450, 'EFNASE 15ML,50 MCG', 'SPRAY', 'CICLESONIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (522, 'FUCIDIN OINTMENT,5 GM', 'OINTMENT', 'SODIUM FUCIDATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (451, 'EGLITON 3MIU,3MIU', 'INJECTION', 'VIAL CONTAINS 3 MILLION UNITS OF RECOMBINANT HUMAN INTERFERON ALPHA 2B', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (452, 'EGLITON 5MIU,5MIU', 'INJECTION', 'VIAL CONTAINS 5 MILLION UNITS OF RECOMBINANT HUMAN INTERFERON ALPHA 2B', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (453, 'ELIGARD 7.5 MG,7.5 MG', 'TABLET', 'LEUPROLIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (454, 'ELIGARD DEPOT 22.5 MG,22.5 MG', 'DEPOT', 'LEUPROLIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (455, 'ELIGARD DEPOT 45 MG,45 MG', 'DEPOT', 'LEUPROLIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (456, 'ELIWEL,25MG', 'TABLET', 'AMITRIPTYLINE HCL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (457, 'ELIWEL 75,75MG', 'TABLET', 'AMITRIPTYLINE HCL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (458, 'ELIWEL-10,10MG', 'TABLET', 'AMITRIPTYLINE HCL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (459, 'ELKAR TABLET.,500 MG', 'TABLET', 'LEVACECARNINE HYDROCHLORIDE 500 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (460, 'EMARSA INJ 350MG,350MG', 'INJECTION', 'SODIUM HYDROXIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (461, 'ENCORATE,200MG', 'TABLET', 'SODIUM VALPROATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (462, 'ENCORATE 300,300MG', 'TABLET', 'SODIUM VALPROATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (463, 'ENCORATE 500,500MG', 'TABLET', 'SODIUM VALPROATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (464, 'ENCORATE-CHRONO 200,200MG', 'TABLET', 'SODIUM VALPROATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (465, 'ENCORATE-CHRONO 300,300MG', 'TABLET', 'SODIUM VALPROATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (467, 'ENCORATE-INJ 100MG,100MG', 'VIALS', 'VALPROIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (468, 'ENCORATE-SYRUP 100ML 1 BTL,5ML', 'SYRUP', 'SODIUM VALPORATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (469, 'ENHANCIN TABLET 625MG,500 MG+125 MG', 'TABLET', 'AMOXY,CLAV POTAS COM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (470, 'ENTECA TABLET 0.5 MG Â Â Â Â Â Â Â Â ,0.5 MG', 'TABLET', 'ENTECAVIR 0.5MG FILM COATED TABS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (471, 'ENTECA TABLET 1 MG,1 MG', 'TABLET', 'ENTECAVIR 1MG FILM COATED TABS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (472, 'ENVOCIN INJECTION 50MG,50 MG', 'INJECTION', 'AMPHOTERICIN B -LYPHOPHILSED', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (473, 'EPIVAL,200MG', 'TABLET', 'SODIUM VALPROATE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (474, 'EPIVAL SYRUP 200ML 1 BTL,200MG', 'SYRUP', 'SODIUM VALPROATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (475, 'ESSVIT TABLET,5 MG', 'TABLET', 'BIOTIN B.P. 5 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (476, 'ESSVITAL TABLET,10MG+8MG+5MG+5MG+2MG+50MG', 'TABLET', 'BIOTIN, MINERAL & AMINO ACID COMBINATION', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (477, 'ETILITE TABLET 0.5MG,0.5 MG', 'TABLET', 'ETIZOLAM 0.5 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (478, 'ETILITE TABLET 1MG,1 MG', 'TABLET', 'ETIZOLAM 1 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (479, 'ETIREST 1,1 MG', 'TABLET', 'ETIZOLAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (480, 'ETOSHINE 120,120MH', 'TABLET', 'ETORICOXIB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (481, 'ETOSHINE 90,90MH', 'TABLET', 'ETORICOXIB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (482, 'ETROBAX MR 4 TABLET,60MG + 4MG', 'TABLET', 'ETORICOXIB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (483, 'ETROBAX MR 8 TABLET,60MG + 4MG', 'TABLET', 'ETORICOXIB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (484, 'ETROBAX TABLET 120MG,120 MG', 'TABLET', 'ETORICOXIB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (485, 'ETROBAX TABLET 60MG,60MG', 'TABLET', 'ETORICOXIB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (486, 'ETROBAX TABLET 90MG,90 MG', 'TABLET', 'ETORICOXIB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (487, 'EXEL CREAM,0.05%W/W 30GM', 'CREAM', 'CLOBETASOL PROPIONATE USP 0.05% W / W', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (488, 'EXEL GN CREAM,15G', 'CREAM', 'CLOBETASOL PROPIONATE USP 0.05% W / W ,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (489, 'EXEL-M SKIN CREAM,16 GM', 'CREAM', 'CLOBETASOL PROPIONATE USP 0.05% W / W ,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (490, 'EXMASIN,25MG', 'TABLET', 'EXEMESTANE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (491, 'EXZILOR,0.5MG, 10MG', 'TABLET', 'FLUPENTIXOL , MELITRACEN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (492, 'EYEMIST EYE DROPS,0.3%W/V/', 'DROPS', 'HPMC WITH SOC', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (493, 'EZACT 60,60MG', 'TABLET', 'ETORICOXIB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (494, 'EZACT 90,90MG', 'TABLET', 'ETORICOXIB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (495, 'EZENTIA 10,10MG', 'TABLET', 'EZETIMIBE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (496, 'FAMOCID 20MG 14 TAB,20MG', 'TABLET', 'FAMOTIDINE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (497, 'FAMOCID 40MG 14 TAB,40MG', 'TABLET', 'FAMOTIDINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (498, 'FARONEM TABLET,200 MG', 'TABLET', 'FAROPENEM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (499, 'FELDEX,20MG', 'TABLET', 'PIROXICAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (500, 'FENTOIN-ER 100,100MG', 'CAPSULE', 'PHENYTOIN SODIUM IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (501, 'FIBATOR EZ,160 MG ,10 MG, 10 MG', 'TABLET', 'FENOFIBRATE BP, ATORVASTATIN, EZETIMIBE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (502, 'FLEXURA D,400MG, 50MG', 'TABLET', 'METAXALONE, DICLOFENAC POTASSIUM BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (503, 'FLEXURA-400,400MG', 'TABLET', 'METAXALONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (504, 'FLOTHIN 40 MG INJ.,40MG/0.4ML', 'INJECTION', 'ENOXAPARIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (505, 'FLOTHIN 60 MG INJ.,60MG/0.6ML', 'INJECTION', 'ENOXAPARIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (506, 'FLOTRAL D KIT,UA', 'KIT', 'ALFUZOSIN DUTASTERIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (507, 'FLOTRAL TABLET 10 MG,10 MG', 'TABLET', 'ALFUZOSIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (508, 'FLUVOXIN 100,100MG', 'TABLET', 'FLUVOXAMIN MALEATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (509, 'FLUVOXIN 50,50MG', 'TABLET', 'FLUVOXAMINE MALEATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (510, 'FLUZET CAPLET,MULTIPLE INGREDIENTS', 'CAPLETS', 'CHLORPHENIR COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (511, 'FLUZET CF 60 ML,60 ML', 'SUSPENSION', 'CHLORPHENIR COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (512, 'FLUZET SUSPENSION,60 ML', 'SYRUP', 'CHLORPHENIR COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (513, 'FOMTIDE-100 DISK,2MCG.,100MC', 'INHALER', 'FORMOTEROL FUMARATE, BUDESONIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (514, 'FOMTIDE-200 DISK,12MCG, 200MC', 'INHALER', 'FORMOTEROL FUMARATE, BUDESONIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (515, 'FORTWIN INJECTION 12*1ML FFS,30 MG/ML', 'INJECTION', 'PENTAZOCINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (516, 'FORZEST TABLET,20 MG', 'TABLET', 'TADALAFIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (517, 'FOSARAN INJECTION,150MG', 'INJECTION', 'FOSAPREPITANT DIMEGLUMINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (518, 'FUCIBET CREAM,15 GM', 'CREAM', 'FUSIDIC ACID BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (519, 'FUCIDIN CREAM,15 GM', 'CREAM', 'FUSIDIC ACID BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (520, 'FUCIDIN CREAM,5 GM', 'CREAM', 'FUSIDIC ACID BP 20MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (521, 'FUCIDIN H CREAM,15 GM', 'CREAM', 'FUSIDIC ACID,HYDROCORTISONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (523, 'FUCIDIN OINTMENT,15 GM', 'OINTMENT', 'SODIUM FUCIDATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (524, 'FULNITE 2,2MG', 'TABLET', 'ESZOPICLONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (525, 'FULSED INJECTION 10ML VIAL,1 MG/ML', 'INJECTION', 'MIDAZOLAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (526, 'FULSED INJECTION 1ML AMP,5 MG/ML', 'INJECTION', 'MIDAZOLAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (527, 'FULSED INJECTION 5ML VIAL,1 MG/ML', 'INJECTION', 'MIDAZOLAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (528, 'GABANTIN 300,300MG', 'CAPSULE', 'GABAPENTINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (529, 'GABANTIN 400,400MG', 'CAPSULE', 'GABAPENTINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (530, 'GABANTIN FORTE,300MG, 0.5MG', 'TABLET', 'GABAPENTIN, METHYLCOBALAMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (531, 'GABANTIN PLUS,100MG, 500MCG', 'TABLET', 'GABAPENTIN, METHYLCOBALAMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (532, 'GABANTIN-100,100MG', 'CAPSULE', 'GABAPENTIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (533, 'GALAMER 4,4MG', 'TABLET', 'GALANTAMINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (534, 'GALAMER 8,8MG', 'TABLET', 'GALANTAMINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (535, 'GALAMER OD 8,8MG', 'TABLET', 'GALANTAMINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (536, 'GALINERVE 75,75MG', 'CAPSULE', 'PREGABALIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (537, 'GALINERVE M 75,75MG, 0.75MG', 'CAPSULE', 'PREGABALIN, METHYLCOBALAMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (538, 'GANGUARD CAP 250MG B10,250 MG', 'CAPSULE', 'GANCICLOVIR', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (539, 'GANGUARD CAP 500MG B10,500MG', 'CAPSULE', 'GANCICLOVIR', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (541, 'GATILOX PLUS E/D 5ML,4MG, 3MG, 0.005% W/V', 'SYRUP', 'KETOROLAC TROMETHAMINE USP, GATIFLOXACIN IP, BENZALKONIUM CHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (542, 'GATILOX-0.3% EYE DROPS [5ML],3MG', 'DROPS', 'GATIFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (543, 'GEMBAX TABLET 400MG,320 MG', 'TABLET', 'GEMIFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (544, 'GEMER 1 [BI-LAYERED TABLET],1MG, 500MG', 'TABLET', 'GLIMEPIRIDE, METFORMIN HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (545, 'GEMER 2 [BI-LAYERED TABLET],2MG, 500MG', 'TABLET', 'GLIMEPIRIDE, METFORMIN HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (546, 'GEMER FORTE 1,1MG, 850 MG', 'TABLET', 'GLIMEPIRIDE, METFORMIN ER', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (547, 'GEMER FORTE 2,2MG, 850 MG', 'TABLET', 'GLIMEPIRIDE, METFORMIN ER', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (548, 'GEMER P1,1MG, 15MG, 500MG', 'TABLET', 'GLIMEPIRIDE, PIOGLITAZONE, METFORMIN HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (549, 'GEMER P2,2MG, 15MG, 500MG', 'TABLET', 'GLIMEPIRIDE, PIOGLITAZONE, METFORMIN HYDROCHLORIDE IP)', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (550, 'GEMTAZ 1GM,1GM', 'VIALS', 'GEMCITABINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (551, 'GEMTAZ 200,200MG', 'VIALS', 'GEMCITABINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (552, 'GENTALENE PLUS CREAM,10 GM', 'CREAM', 'BECLOMETHASONE , NEOMYCIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (553, 'GENTALENE PLUS CREAM,20 GM', 'CREAM', 'BECLOMETHASONE , NEOMYCIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (554, 'GINKOCER M CAPS,40MG + 500 MCG', 'CAPSULE', 'GINKGO BILOBA,MECOBALAMINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (555, 'GINKOCER TABLET,40 MG', 'TABLET', 'GINKO BILOBA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (556, 'GLIMPID TABLET 1MG.,1 MG', 'TABLET', 'GLIMEPERIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (557, 'GLIMPID TABLET 2MG,2 MG', 'TABLET', 'GLIMEPERIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (558, 'GLIOTEM-100,100MG', 'CAPSULE', 'TEMOZOLOMIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (559, 'GLIOTEM-20,20MG', 'CAPSULE', 'TEMOZOLOMIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (560, 'GLIOTEM-250,250MG', 'CAPSULE', 'TEMOZOLOMIDEG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (561, 'GLUCORED,2.5MG, 400MG', 'TABLET', 'GLIBENCLAMIDE IP, METFORMIN HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (562, 'GLUCORED FORTE,5MG, 500MG', 'TABLET', 'GLIBENCLAMIDE IP, METFORMIN HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (563, 'GLUCORED FORTE 850,450MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (564, 'GLUCORED FORTE SR,5MG, 500MG', 'TABLET', 'GLIBENCLAMIDE IP, METFORMIN HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (565, 'GLUGEN,10G', 'GRANULES BLEND', 'COLLAGEN HYDROLYSATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (566, 'GLYPRIDE-1,1MG', 'TABLET', 'GLIMEPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (567, 'GLYPRIDE-2,2MG', 'TABLET', 'GLIMEPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (568, 'GLYPRIDE-4,4MG', 'TABLET', 'GLIMEPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (569, 'GLYTEARS,0.5% W/V, 0.0075% W/V', 'DROPS', 'SODIUM CARBOXYMETHYLCELLULOSE IP, OXYCHLORO COMPLEX', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (570, 'GMH 150 IU 2ML VIAL,150 IU', 'VIALS', 'FOLLICLE STIMULATING HORMONE, LUTEINISING HORMONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (571, 'GMH 75 2ML VIAL,75 IU', 'VIALS', 'FOLLICLE STIMULATING HORMONE, LUTEINISING HORMONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (572, 'GRAFTIN SOFGEL 100 MG 5S,100 MG', 'SOFTGELS', 'CYCLOSPORINE 100MG,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (573, 'GRAFTIN SOFGEL 25 MG 5S,25 MG', 'SOFTGELS', 'CYCLOSPORINE 25MG,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (574, 'GRAFTIN SOFGEL 50 MG 5S,50 MG', 'SOFTGELS', 'CYCLOSPORINE 50MG,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (575, 'GRAMOGYL SYRUP,100 MG+100 MG/5 ML', 'SUSPENSION', 'NORFLOXACIN,METRONIDAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (576, 'GRAMOGYL TABLET,150 MG+100 MG', 'TABLET', 'NORFLOXACIN,METRONIDAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (577, 'GRAMONEG TABLETLET,500 MG', 'TABLETS', 'NALIDIXIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (578, 'GRAMONEG SUSPENSION,300 MG/5 ML', 'SUSPENSION', 'NALIDIXIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (579, 'GRANISET-1MG 4 TAB,1MG', 'TABLET', 'GRANISETRON', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (580, 'GRAVITOR,60MG', 'TABLET', 'PYRIDOSTIGMINE BROMIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (581, 'GRAVITOR-SR,180MG', 'TABLET', 'PYRIDOSTIGMINE BROMIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (582, 'GYNAZOL 100,100MG', 'CAPSULE', 'DANAZOL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (583, 'GYNAZOL 200,200MG', 'CAPSULE', 'DANAZOL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (584, 'GYNAZOL 50,50MG', 'CAPSULE', 'DANAZOL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (585, 'HALOX CREAM,20 GM', 'CREAM', 'HALOBETASOL CREAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (586, 'HALOX ES OINTMENT,10 GM', 'CREAM', 'HALOBETASOL OINTMENT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (587, 'HALOX F CREAM,0.5% + 2% - 10GM', 'CREAM', 'HALOBETASOL CREAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (588, 'HALOX LOTION,0.05% W/V', 'CREAM', 'HALOBETASOL PROPIONATE 0.05% W/V', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (589, 'HALOX OINTMENT,20 GM', 'OINTMENT', 'HALOBETASOL OINTMENT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (590, 'HALOX S LOTION,0.05 W/V + 3% W/V', 'CREAM', 'HALOBETASOL PROPIONATE 0.05% W/V', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (591, 'HALOX S OINTMENT,0.05% + 3%', 'CREAM', 'HALOBETASOL OINTMENT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (592, 'HALOX S OINTMENT,20 GM', 'CREAM', 'HALOBETASOL OINTMENT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (593, 'HEADON INJECTION 4 IU,4IU', 'INJECTION', 'SOMATROPIN ( RECOMBINATE HUMAN GROWTH HORMONE ) 4 I.U. ( 1.6 MG )', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (594, 'HISTAC EVT,150 MG', 'EFFERVESCENT TABLET', 'RANITIDINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (595, 'HISTAC INJECTION,25 MG/ML', 'INJECTION', 'RANITIDINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (596, 'HISTAC TABLET 150 MG,150 MG', 'TABLET', 'RANITIDINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (597, 'HISTAC TABLET 300 MG,300 MG', 'TABLET', 'RANITIDINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (598, 'HP-KIT', 'TABLET', 'AMOXYCILLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (599, 'HYCLEAN TF CREAM,15 GM', 'CREAM', 'HYDROQUINONE USP 2.00%, TRETINOIN USP 0.25% & FLUOCINOLONE ACETONIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (600, 'HYDROQUIN,200MG', 'TABLET', 'HYDROXYCHLOROQUINE SULPHATE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (601, 'HYNOV INJECTION 8MG/ML,8 MG', 'INJECTION', 'SODIUM HYALURONATE , SODIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (602, 'HYVISC 0.55ML,10MG/ML', 'SACHET', 'SODIUM HYALURONATEL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (603, 'HYVISC PLUS-0.55ML,14MG/ML', 'SACHET', 'SODIUM HYALURONATEL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (604, 'IDROFOS,1MG', 'VIALS', 'IBANDRONIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (605, 'IDROFOS 150,150MG', 'TABLET', 'IBANDRONIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (606, 'IDROFOS 3 INJECTION,1MG', 'VIALS', 'IBANDRONIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (607, 'IDROFOS 50,50MG', 'TABLET', 'IBANDRONIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (608, 'IMALEK 100,100MG', 'TABLET', 'IMATINIB MESYLATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (609, 'IMALEK 400,400MG', 'TABLET', 'IMATINIB MESYLATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (610, 'INAPURE 5,5MG', 'TABLET', 'IVABRADINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (611, 'INSUCARE M30 INJ. 40IU/ML, 10 ML,40 IU/ML', 'INJECTION', 'INSULIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (612, 'INSUCARE M50 INJ. 40IU/ML, 10 ML,40 IU/ML', 'INJECTION', 'INSULIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (613, 'INSUCARE N INJ. 40IU/ML, 10 ML,40 IU/ML', 'INJECTION', 'INSULIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (614, 'INSUCARE R INJ. 40IU/ML, 10 ML,40 IU/ML', 'INJECTION', 'INSULIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (615, 'IRNOGEN 100 MG,100 MG', 'INJECTION', 'IRINOTECAN 100 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (616, 'IRNOGEN 40 MG,40 MG', 'INJECTION', 'IRINOTECAN 40 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (617, 'IROVEL-150,150MG', 'TABLET', 'IRBESARTAN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (618, 'IROVEL-300,300MG', 'TABLET', 'IRBESARTAN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (619, 'IROVEL-H,150MG, 12.5MG', 'TABLET', 'IRBESARTAN, HYDROCHLOROTHIAZIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (620, 'ISOBAX OD 30MG,30 MG', 'TABLET', 'ISOSORBIDE MONONITRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (621, 'IVEPRED 16,16MG', 'TABLET', 'METHYLPREDNISOLONE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (622, 'IVEPRED 4,4MG', 'TABLET', 'METHYLPREDNISOLONE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (623, 'IVEPRED 8,8MG', 'TABLET', 'METHYLPREDNISOLONE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (624, 'IVEPRED-1000 INJ,1000MG', 'VIALS', 'METHYLPREDNISOLONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (625, 'IVEPRED-125 INJ,125MG', 'VIALS', 'METHYLPREDNISOLONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (626, 'IVEPRED-40 INJ,40MG', 'VIALS', 'METHYLPREDNISOLONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (627, 'IVEPRED-500 INJ,500MG', 'VIALS', 'METHYLPREDNISOLONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (628, 'IVERMECTOL-12 MG,12 MG', 'TABLET', 'IVERMECTIN B.P 12 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (629, 'IVERMECTOL-3 MG,3 MG', 'TABLET', 'IVERMECTIN B.P 3 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (630, 'IVERMECTOL-6 MG,6 MG', 'TABLET', 'IVERMECTIN B.P 6 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (631, 'KEFLOR TABLETLET 125 MG,125 MG', 'TABLETS', 'CEFACLOR', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (632, 'KEFLOR TABLETLET 250 MG,250 MG', 'TABLETS', 'CEFACLOR', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (633, 'KEFLOR DROPS,50 MG/ML', 'DROPS', 'CEFACLOR', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (634, 'KEFLOR REDIMIX 125 MG/5 ML,125 MG/5 ML', 'REDIMIX', 'CEFACLOR', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (635, 'KEFLOR SUSPENSION 125MG,125 MG/5 ML', 'SUSPENSION', 'CEFACLOR', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (636, 'KETANOV INJECTION,30 MG/ML', 'INJECTION', 'KETOROLAC TROMETH', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (637, 'KETANOV TABLET,10 MG', 'TABLET', 'KETOROLAC TROMETH', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (638, 'KETASMA,1MG', 'TABLET', 'KETOTIFEN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (639, 'KETLUR LS,4MG, 0.12MG', 'DROPS', 'KETOROLAC TROMETHAMINE USP, BENZALKONIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (640, 'KETLUR PLUS,5MG, 3MG, 0.01% W/V', 'DROPS', 'KETOROLAC TROMETHAMINE USP, OFLOXACIN USP, BENZALKONIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (641, 'KETLUR-5ML,0.005', 'VIALS', 'KETOROLAC TROMETHAMINE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (642, 'KORANDIL-10,10MG', 'TABLET', 'NICORANDIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (643, 'KORANDIL-5,5MG', 'TABLET', 'NICORANDIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (644, 'KRIMSON 35,2MG, 0.035MG', 'TABLET', 'CYPROTERONE ACETATE BP, ETHINYLOESTRADIOL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (645, 'LACTIHEP SYRUP,10GM, 0.0225GM', 'SYRUP', 'LACTITOL MONOHYDRATE BP , BANZOIC ACID IP , AQUEOUS BASE Q.S.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (646, 'LAMBIN INJECTION,50MG', 'VIALS', 'AMPHOTERICINBIP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (647, 'LAMOSYN 100,100MG', 'TABLET', 'LAMOTRIGINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (648, 'LAMOSYN 25,25MG', 'TABLET', 'LAMOTRIGINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (649, 'LAMOSYN 50,50MG', 'TABLET', 'LAMOTRIGINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (650, 'LATOCOM EYE DROPS,50MCG, 5MG', 'DROPS', 'LATANOPROST, TIMOLOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (651, 'LATOPROST,50MCG', 'DROPS', 'LATANOPROST', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (652, 'LENZEST 10,10MG', 'CAPSULE', 'LENALIDOMIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (653, 'LENZEST 25,25MG', 'CAPSULE', 'LENALIDOMIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (654, 'LESURIDE,25MG', 'TABLET', 'LEVOSULPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (655, 'LETOVAL-2.5,2.5MG', 'TABLET', 'LETROZOLE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (656, 'LETROZ-2.5,2.5 MG', 'TABLET', 'LETROZOLE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (657, 'LEVIPIL 1 G,1000MG', 'TABLET', 'LEVETIRACETAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (658, 'LEVIPIL 250,250MG', 'TABLET', 'LEVETIRACETAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (659, 'LEVIPIL 500,500MG', 'TABLET', 'LEVETIRACETAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (660, 'LEVIPIL INJECTION,100 MG', 'VIALS', 'LEVETIRACETAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (661, 'LEVIPIL SYRUP,100MG, 1.35MG, 0.15MG', 'SYRUP', 'LEVETIRACETAM, METHYLPARABEN IP, PROPYLPARABEN IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (662, 'LEVROXA INJECTION,100MG/1ML', 'INJECTION', 'LEVETIRACETAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (663, 'LEVROXA ORAL SOLUTION 100ML,100 ML', 'LIQUID', 'LEVETIRACETAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (664, 'LEVROXA TABLET 1000 MG,1000 MG', 'TABLET', 'LEVETIRACETAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (665, 'LEVROXA TABLET 250MG,250 MG', 'TABLET', 'LEVETIRACETAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (666, 'LEVROXA TABLET 500MG,500 MG', 'TABLET', 'LEVETIRACETAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (667, 'LEVROXA TABLET 750MG,750 MG', 'TABLET', 'LEVETIRACETAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (668, 'LIOFEN 10,10MG', 'TABLET', 'BACLOFEN USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (669, 'LIOFEN 25,25MG', 'TABLET', 'BACLOFEN USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (670, 'LIOFEN XL 20,20MG', 'CAPSULE', 'BACLOFEN USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (671, 'LIOFEN XL 30,30MG', 'CAPSULE', 'BACLOFEN USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (672, 'LIOFEN XL 40,40MG', 'CAPSULE', 'BACLOFEN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (673, 'LIPODOX,2MG', 'VIALS', 'DOXORUBICIN HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (674, 'LIPODOX 5ML,2MG', 'VIALS', 'DOXORUBICIN HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (675, 'LITHOSUN 300,300MG', 'TABLET', 'LITHIUM CARBONATE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (676, 'LITHOSUN-SR 400,400MG', 'TABLET', 'LITHIUM CARBONATE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (677, 'LOBAZAM 10,10 MG', 'TABLET', 'CLOBAZAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (678, 'LOBAZAM 20,20 MG', 'TABLET', 'CLOBAZAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (679, 'LOBAZAM 5,5 MG', 'TABLET', 'CLOBAZAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (680, 'LOBAZAM MD 10,10MG', 'TABLET', 'CLOBAZAM IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (681, 'LOBAZAM MD 5,5MG', 'TABLET', 'CLOBAZAM IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (682, 'LOFECAM 4,4 MG', 'TABLET', 'LORNOXICAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (683, 'LOFECAM 8,8 MG', 'TABLET', 'LORNOXICAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (684, 'LOFECAM SR,16MG', 'TABLET', 'LORNOXICAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (685, 'LOFEQUIK 8,500MG', 'TABLET', 'LORNOXICAM AND PARACETAMOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (686, 'LONAZEP 0.5,0.5MG', 'TABLET', 'CLONAZEPAM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (687, 'LONAZEP 2,2MG', 'TABLET', 'CLONAZEPAM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (688, 'LONAZEP-0.25,0.25MG', 'TABLET', 'CLONAZEPAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (689, 'LONAZEP-1,1MG', 'TABLET', 'CLONAZEPAM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (690, 'LONAZEP-MD 0.25,0.25MG', 'TABLET', 'CLONAZEPAM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (692, 'LONAZEP-MD 1,1MG', 'TABLET', 'CLONAZEPAM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (693, 'LONAZEP-MD 2,2MG', 'TABLET', 'CLONAZEPAM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (694, 'LOTENSYL-10,10MG', 'TABLET', 'LERCANIDIPINE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (695, 'LOTENSYL-20,20MG', 'TABLET', 'LERCANIDIPINE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (696, 'LOTENSYL-AT,10MG, 50MG', 'TABLET', 'LERCANIDIPINE HYDROCHLORIDE. ATENOLOL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (697, 'LOTEPRED LS 0.2% E/D 5 ML,2MG', 'SUSPENSION', 'LOTEPREDNOL ETABONATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (698, 'LOTEPRED T,5MG, 3MG', 'DROPS', 'LOTEPREDNOL ETABONATE, TOBRAMYCIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (699, 'LOTEPRED-5ML,5MG', 'SUSPENSION', 'LOTEPREDNOL ETABONATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (700, 'LOXOF TABLET 250 MG,250 MG', 'TABLET', 'LEVOFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (701, 'LOXOF TABLET 500 MG,500 MG', 'TABLET', 'LEVOFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (702, 'LOXOF TABLET 750 MG,750 MG', 'TABLET', 'LEVOFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (703, 'LOXOF AZ 250+250MG TABLET,250+250MG', 'TABLET', 'LEVOFLOXACIN AZITHROMYCIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (704, 'LOXOF AZ 500MG+500MG TABLET,500MG+500MG', 'TABLET', 'LEVOFLOXACIN AZITHROMYCIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (705, 'LOXOF INFUSION,500 MG/100 ML', 'INFUSION', 'LEVOFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (706, 'LOXOF OZ TABLET,200MG + 500MG', 'TABLET', 'LEVOFLOXACIN 250MG , ORNIDAZOLE 500MG TABS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (707, 'LULIFIN CREAM,10G', 'CREAM', 'LULICANAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (708, 'LULIFIN CREAM,20 GM', 'CREAM', 'LULICANAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (709, 'LULIFIN LOTION 10ML BTL,10ML', 'LOTION', 'LULICANAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (710, 'LUPRIDE DEPOT 11.25MG ( 3 MONTHS),11.25MG', 'VIALS', 'LEUPROLIDE ACETATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (711, 'LUPRIDE DEPOT 22.50MG ( 3 MONTHS),22.50MG', 'VIALS', 'LEUPROLIDE ACETATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (712, 'LUPRIDE DEPOT 7.5MG ( 1 MONTH),7.5MG', 'VIALS', 'LEUPROLIDE ACETATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (713, 'LUPRIDE DEPOT-3.75MG INJ.,3.75MG', 'VIALS', 'LEUPROLIDE ACETATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (714, 'LUPRIDE-4MG/4ML [1 VIAL],1MG., 9MG', 'VIALS', 'LEUPROLIDE ACETATE, BENZYL ALCOHOL BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (715, 'LUTICA CREAM,0.05% W/W', 'CREAM', 'FLUTICASONE PROPIONATE BP 0.05% W/W', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (716, 'LUTICA LOTION,30 ML', 'CREAM', 'FLUTICASONE PROPIONATE IP 0.05%', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (717, 'MACORATE 200,200MCG', 'TABLET', 'MAGNESIUM VALPROATEENTERIC', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (718, 'MACORATE 400,400MCG', 'TABLET', 'MAGNESIUM VALPROATEENTERIC', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (719, 'MACORATE CR 600,600MG', 'TABLET', 'MAGNESIUM VALPROATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (720, 'MACROGEN,400MCG', 'INJECTION', 'MOLGRAMOSTIM 400 MCG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (721, 'MAXGALIN 150,150MG', 'CAPSULE', 'PREGABALIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (722, 'MAXGALIN 50,50MG', 'CAPSULE', 'PREGABALIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (723, 'MAXGALIN 75,75MG', 'CAPSULE', 'PREGABALIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (724, 'MAXGALIN M 150,150MG, 0.75MG', 'CAPSULE', 'PREGABALIN, METHYLCOBALAMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (725, 'MAXGALIN M 50,50MG, 0.50MG', 'CAPSULE', 'PREGABALIN , METHYLCOBALAMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (726, 'MAXGALIN M 75,75MG, 0.75MG', 'CAPSULE', 'PREGABALIN, METHYLCOBALAMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (727, 'MAXOZA,5GM', 'POWDER', 'AMINO ACIDS, VITAMINS AND MINERALS POWDER', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (728, 'MAXTIB,2.5MG', 'TABLET', 'TIBOLONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (729, 'MEBIZ-SR,200MG', 'CAPSULE', 'MEBEVERINE HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (730, 'MEDSOP 75GM,75 GM', 'SOAP', 'SULPHONATED SURFACTANT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (731, 'MEDSOP ACNE 75GM,75 GM', 'SOAP', 'SALICYCLOC ACID, SODIUM LACTATE, GLYCERINE, TITANIUM DIOXIDE, TRICLOSAN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (732, 'MERIXIM 1000 MG INJECTION,1000 MG', 'INJECTION', 'MEROPENEM INJECTION IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (733, 'MERIXIM 500 MG INJECTION,500MG', 'INJECTION', 'MEROPENEM INJECTION IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (734, 'MESACOL,400MG', 'TABLET', 'AMINO SALICYLIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (735, 'MESACOL 800,800MG', 'TABLET', 'MESALAMINE UPS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (736, 'MESACOL OD,1.2 G', 'TABLET', 'MESALAMINE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (737, 'MESACOL-ENEMA,60ML, 4GM', 'SYRUP', 'MESALAMINE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (738, 'METHIMEZ 10,10MG', 'TABLET', 'METHIMAZOLE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (739, 'METHIMEZ 5,5MG', 'TABLET', 'METHIMAZOLE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (740, 'MIDOSED-INJ 10ML,1MG/ML, 0.8%', 'VIALS', 'MIDOZOLAM BP , SODIUM CHLORIDE IP0', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (741, 'MIDOSED-INJ 5ML,1MG/ML, 0.8%', 'VIALS', 'MIDOZOLAM BPL, SODIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (742, 'MIFEPRIN,200MG', 'TABLET', 'MIFEPRISTON', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (743, 'MIFEPRIN KIT,200MCG', 'TABLET', 'MIFEPRISTONE, MISOPROSTOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (744, 'MIL-10ML,0.056%, 0.01%, 0.12%,', 'VIALS', 'NAPHAZOLINE HCL UPS, CHLORPHENIRAMINE MALEATE IP, ZINC SULPHATE IP, BORIC ACID IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (745, 'MILBORN 50,50 MG', 'TABLET', 'MILNACIPRAN HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (746, 'MILFLOX,5MG', 'DROPS', 'MOXIFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (747, 'MILFLOX PLUS,5MG, 0.01% W/V', 'DROPS', 'MOXIFLOXACIN, KETOROLAC TROMETHAMINE, BENZALKONIUM CHLORIDE SOLUTION IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (748, 'MINOZ OD CAP 100 MG,100 MG', 'CAPSULE', 'MINOCYCLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (749, 'MINOZ S FACE LIQUID,50 ML', 'LIQUID', 'MINOCYCLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (750, 'MINOZ TABLET 100 MG,100 MG', 'TABLET', 'MINOCYCLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (751, 'MINOZ TABLET 50 MG,50 MG', 'TABLET', 'MINOCYCLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (752, 'MIRTAZ-15,15MG', 'TABLET', 'MIRTAZAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (753, 'MIRTAZ-30,30MG', 'TABLET', 'MIRTAZAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (754, 'MIRTAZ-7.5,7.5MG', 'TABLET', 'MIRTAZAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (755, 'MOBISWIFT D 450MG TABLET,400MG + 50MG', 'TABLET', 'METHOXOLONE,DICLOFENAC', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (756, 'MOBIZOX TABLET 10Â´S,500 + 325MG', 'TABLET', 'DICLOFENAC 50MG , PARACETAMOL 325MG , CHLORZOXAZONE 325MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (757, 'MODALERT 100,100MG', 'TABLET', 'MODAFINIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (758, 'MODALERT 200,200MG', 'TABLET', 'MODAFINIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (759, 'MOISTUREX CALM 50ML LOTION,50 ML', 'LOTION', 'CALAMINE IP ,LIGHT LIQUID PARAFIN IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (760, 'MOISTUREX CREAM 100GM,100 GM', 'CREAM', 'UREA COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (761, 'MOISTUREX SOFT,300GM', 'CREAM', 'WHITE SOFT PARAFFIN IP 13.2% W/W , LIGHT LIQUID PARAFFIN IP 10.2% W/W', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (899, 'ONCOMOX 10,10MG, 10MG', 'TABLET', 'TAMOXIFEN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (762, 'MOISTUREX SOFT,100 GM', 'CREAM', 'WHITE SOFT PARAFFIN IP 13.2% W/W , LIGHT LIQUID PARAFFIN IP 10.2% W/W', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (763, 'MONDESLOR,10MG, 15MG', 'TABLET', 'MONTELUKAST, DESLORATADINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (764, 'MONOSPRIN 30,30MG, 75MG', 'CAPSULE', 'ISOSORBIDE MONONITRATE, ASPIRIN75MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (765, 'MONOSPRIN 60,60MG, 75MG', 'CAPSULE', 'ISOSORBIDE MONONITRATE, ASPIRIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (766, 'MONOTRATE SR 30,30MG', 'TABLET', 'ISOSORBIDE MONONITRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (767, 'MONOTRATE SR 60,60MG', 'TABLET', 'ISOSORBIDE MONONITRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (768, 'MONOTRATE-10,10MG', 'TABLET', 'ISOSORBIDE MONONITRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (769, 'MONOTRATE-20,20MG', 'TABLET', 'ISOSORBIDE MONONITRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (770, 'MONOTRATE-40,40MG', 'TABLET', 'ISOSORBIDE MONONITRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (771, 'MONOTRATE-OD,50MG', 'TABLET', 'ISOSORBIDE MONONITRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (772, 'MONOTRATE-OD 25,25MG', 'TABLET', 'ISOSORBIDE MONONITRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (773, 'MONTEK LC,10MG, 5MG', 'TABLET', 'MONTELUKAST, LEVOCETIRIZINE DIHYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (774, 'MONTEK LC KID,4 MG, 2.5 MG', 'CAPSULE', 'MONTELUKAST, LEVOCETIRIZINE DIHYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (775, 'MONTEK PLUS,10MG, 10MG', 'TABLET', 'MONTELUKAST, BAMBUTEROL HYDROCHLORIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (776, 'MONTEK-10,10MG', 'TABLET', 'MONTELUKAST', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (777, 'MONTEK-4MG 10 TAB,4MG', 'TABLET', 'MONTELUKAST', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (778, 'MONTEK-5MG 10 TAB,5MG', 'TABLET', 'MONTELUKAST', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (779, 'MOX BD 875MG TABLET,875MG', 'TABLET', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (780, 'MOX BD TABLETLET 200 MG,200 MG', 'TABLET', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (781, 'MOX BD TABLETLET 400 MG,400 MG', 'TABLET', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (782, 'MOX CAPSULE 250 MG 15S,250 MG', 'CAPSULE', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (783, 'MOX CAPSULE 250 MG 3S,250 MG', 'CAPSULE', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (784, 'MOX CAPSULE 500 MG 15S,500 MG', 'CAPSULE', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (785, 'MOX CAPSULE 500 MG 3S,500 MG', 'CAPSULE', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (786, 'MOX CLAV BD 1000 MG TABLET,1000 MG', 'TABLETS', 'AMOXY,CLAV POTAS COM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (788, 'MOX CLAV BD SUSPENSION 30 ML,200MG + 28.5MG', 'SUSPENSION', 'AMOXY,CLAV POTAS COM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (789, 'MOX CLAV DROPS 10ML,10ML', 'PEDIATRIC DROPS', 'AMOXY,CLAV POTAS COM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (790, 'MOX CLAV DS TABLETLET 457MG,400 MG/57 MG', 'TABLETS', 'AMOXY,CLAV POTAS COM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (791, 'MOX CLAV DS SUS 457MG 30 ML,400 MG/57 MG', 'SUSPENSION', 'AMOXY,CLAV POTAS COM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (792, 'MOX CLAV INJECTION 0.3 GM,300 MG', 'INJECTION', 'AMOXY,CLAV POTAS COM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (793, 'MOX CLAV ORAL SUSPENSION 30B,125 MG+31.25 MG/5 ML', 'SUSPENSION', 'AMOXY,CLAV POTAS COM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (794, 'MOX CLAV TABLET 375 MG,250 MG+125 MG', 'TABLET', 'AMOXY,CLAV POTAS COM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (795, 'MOX CLAV TABLET 625 MG,500 MG+125 MG', 'TABLET', 'AMOXY,CLAV POTAS COM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (796, 'MOX CV 375MG,250MG + 125MG', 'TABLET', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (797, 'MOX CV 625MG TABLET,500 MG+125 MG', 'TABLET', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (798, 'MOX CV BD SUSPENSION 228.5MG (30ML),200MG + 28.5MG', 'SUSPENSION', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (799, 'MOX CV DROPS 91.4,80 MG + 11.4 MG', 'DROPS', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (800, 'MOX CV DS SUSPENSION 457MG (30ML),400MG + 57MG', 'SUSPENSION', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (801, 'MOX DROPS REDIMIX -10 ML,10ML', 'DROPS', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (802, 'MOX INJ. 250MG,250 MG', 'INJECTION', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (803, 'MOX INJ. 500MG,500 MG', 'INJECTION', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (804, 'MOX KID TABLET 125 MG,125 MG', 'KIDTABS', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (805, 'MOX KID TABLET 250 MG,250 MG', 'KIDTABS', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (806, 'MOX P TABLET 250 MG,250 MG', 'TABLET', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (807, 'MOX P TABLET 500 MG,500 MG', 'TABLET', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (808, 'MOX REDIMIX 125MG 5ML - 30ML,125 MG/5 ML', 'REDIMIX', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (809, 'MOX REDIMIX 125MG 5ML - 60ML,125 MG/5 ML', 'REDIMIX', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (810, 'MOX REDIMIX 250MG 5ML - 30ML,250 MG/5 ML', 'REDIMIX', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (811, 'MOX REDIMIX 250MG 5ML - 60ML,250 MG/5 ML', 'REDIMIX', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (812, 'MOX SUSPENSION 125 MG 5 ML - 30 ML.,125 MG/5 ML', 'SUSPENSION', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (813, 'MOX SUSPENSION 125 MG 5 ML - 60 ML.,125 MG/5 ML', 'SUSPENSION', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (814, 'MOX SUSPENSION 250 MG 5 ML - 60 ML.,250 MG/5 ML', 'SUSPENSION', 'AMOXYCILLIN TRIHYDRA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (815, 'MOX-CLAV INJECTION 1.2 GM,1000 MG+200 MG', 'INJECTION', 'AMOXY,CLAV POTAS COM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (816, 'MUVERA 15,15MG', 'TABLET', 'MELOXICAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (817, 'MUVERA 7.5,7.5MG', 'TABLET', 'MELOXICAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (818, 'NATAMET 5% SUSPENSION-3ML,50MG', 'VIALS', 'NATAMYCIN USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (819, 'NAXDOM 250,10MG, 250MG', 'TABLET', 'DOMPERIDONE, NAPROXEN SODIUM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (820, 'NAXDOM 500,10MG, 500MG', 'TABLET', 'DOMPERIDONE, NAPROXEN SODIUM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (821, 'NEUCOBAL FORTE,1500MCG, 1500MCG, 3MG', 'CAPSULE', 'MECOBALAMIN, ALPHA LIPOIC ACID, FOLICACID IP, PYRIDOXINE H.CHL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (822, 'NEUCOBAL G,300MG, 500MCG', 'TABLET', 'GABAPENTIN , METHYLCOBALAMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (823, 'NEUCOBAL-OD 1.5,1.5MG', 'TABLET', 'MECOBALAMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (824, 'NEUGABA 150,150MG', 'CAPSULE', 'PREGABALIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (825, 'NEUGABA 75,75MG', 'CAPSULE', 'PREGABALIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (826, 'NEUGABA M 75,75MG, 0.75MG', 'CAPSULE', 'PREGABALIN, METHYLCOBALAMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (827, 'NEUGALIN M CAPSULE,MULTIPLE INGREDIENTS', 'CAPSULE', 'PREGABALIN 75MG, METHYLCOBALAMIN 750 MCG.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (828, 'NEUGALIN CAPSULE 75MG,75 MG', 'CAPSULE', 'PREGABALIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (900, 'ONCOPLATIN AQ 100ML,0.5MG/ML, 9MG', 'VIALS', 'CISPLATIN IP, SODIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (829, 'NEURONOX INJECTION,0.5MG + 0.9MG', 'INJECTION', '100 UNITS OF BOTULINUM TOXIN TYPE A,0.5 MG OF ALBUMIN (HUMAN),0.9 MG OF SODIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (830, 'NEVIPAN TABLET 200 MG,200 MG', 'TABLET', 'NEVIRAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (831, 'NEXIPRIDE 100,100 MG', 'TABLET', 'LEVOSULPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (832, 'NEXIPRIDE 25,25 MG', 'TABLET', 'LEVOSULPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (833, 'NEXIPRIDE 50,50 MG', 'TABLET', 'LEVOSULPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (834, 'NEXITO FORTE,10MG,0.5MG', 'TABLET', 'ESCITALOPRAM, CLONAZEPAM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (835, 'NEXITO PLUS,5 MG, 0.5MG', 'TABLET', 'ESCITALOPRAM , CLONAZEPAM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (836, 'NEXITO-10,10MG', 'TABLET', 'ESCITALOPRAM OXALATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (837, 'NEXITO-20,20MG', 'TABLET', 'ESCITALOPRAM OXALATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (838, 'NEXITO-5,5MG', 'TABLET', 'ESCITALOPRAM OXALATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (839, 'NEZAFLO NASAL SPRAY,0.05% W/V', 'VIALS', 'FLUTICASONE PROPIONATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (840, 'NEZALAST,0.10% W/V', 'VIALS', 'AZELASTINE HYDROCHLORIDE BP, FLUTICASONE PROPIONATE BP, BENZALKONIUM CHLORIDE SOLUTION IP, PHENYL ETHYL ALCOHOL USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (841, 'NIAVAS TABLET,5 MG', 'TABLET', 'NEBIVOLOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (842, 'NIFTRAN 100 MG 10S,100MG', 'CAPSULE', 'NITROFURANTOIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (843, 'NIFTRAN 100 MG 30S,100MG', 'CAPSULE', 'NITROFURANTOIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (844, 'NITREST-10,10 MG', 'TABLET', 'ZOLPIDEM TARTRATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (845, 'NITREST-5,5MG', 'TABLET', 'ZOLPIDEM TARTRATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (846, 'NITROSUN 10,10MG', 'TABLET', 'NITRAZEPAM IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (847, 'NITROSUN 5,5MG', 'TABLET', 'NITRAZEPAM IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (848, 'NOCULI B6,200 ML', 'ORAL SOLUTION', 'POTASSIUM AND MAGNESIUM CITRATE VIT B6', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (849, 'NOCULI DT,7+3.5+10.5 M EQ', 'TABLET', 'POTASSIUM MAGNESIUM CITRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (850, 'NOCULI ORAL SOLUTION 500ML,500ML', 'ORAL SOLUTION', 'POTASSIUM MAGNESIUM CITRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (851, 'NODICT,50MG', 'TABLET', 'NALTREXONE HYDROCHLORIDE TABS USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (852, 'NUTRIKIT,MULTIPLE INGREDIENTS', 'TABLET', 'SOYA OIL, GELATIN- FOOD GRADE,NATURAL EXTRACTS, MINERALS,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (853, 'NUTRIKIT NS,MULTIPLE INGREDIENTS', 'SOFTGEL', 'SOYA OIL, GELATIN, GLYCERIN ,BEES WAX, VITAMINS, HYDROGENATED VEG. OIL, SORBITOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (854, 'NUTRIKIT RESPI,MULTIPLE INGREDIENTS', 'SOFTGEL', 'SOYA OIL, GELATIN, GLYCERIN ,BEES WAX, VITAMINS, HYDROGENATED VEG. OIL, SORBITOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (855, 'OCEPRED,10MG, 3MG', 'SUSPENSION', 'PREDNISOLONE ACETATE USP, OFLOXZCIN USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (856, 'OCTAHALER DEVICE FOR DRY PWDR,UA', 'INHALER', 'OCTAHALER DEVICE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (857, 'OCTRIDE DEPOT 20 (1 MONTH),20MG', 'VIALS', 'OCTREOTIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (858, 'OCUCIN-0.3% 5ML,3MG', 'VIALS', 'OFLOXACIN USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (859, 'OD PHYLLIN-400,400MG', 'TABLET', 'THEOPHYLLINE ANHYDROUS IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (860, 'OFRAMAX FORTE 1.5GM,1.5GM/VIAL', 'INJECTION', 'CEFTRIAXONE,SULBACTAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (861, 'OFRAMAX FORTE 375MG,375 MG', 'INJECTION', 'CEFTRIAXONE,SULBACTAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (862, 'OFRAMAX FORTE 750MG,750 MG', 'INJECTION', 'CEFTRIAXONE,SULBACTAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (863, 'OFRAMAX INJECTION 1 GM+FFS,1 GM', 'INJECTION', 'CEFTRIAXONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (864, 'OFRAMAX INJECTION 2 GM+FFS,2 GM', 'INJECTION', 'CEFTRIAXONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (865, 'OFRAMAX INJECTION 250 MG+FFS,250 MG', 'INJECTION', 'CEFTRIAXONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (866, 'OFRAMAX INJECTION 500 MG+FFS,500 MG', 'INJECTION', 'CEFTRIAXONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2748, 'Test med', 'Aerosol Spray', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (868, 'OLANEX F TABLET,5MG + 20MG', 'TABLET', 'OLANZAPINE,FLUOXETINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (869, 'OLANEX IT TABLET 10MG,10MG', 'TABLET', 'OLANZAPINE IP 10MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (870, 'OLANEX IT TABLET 5MG,5 MG', 'TABLET', 'OLANZAPINE IP 5MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (871, 'OLANEX TABLET 10 MG,10 MG', 'TABLET', 'OLANZAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (872, 'OLANEX TABLET 2.5 MG,2.5 MG', 'TABLET', 'OLANZAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (873, 'OLANEX TABLET 5 MG,5 MG', 'TABLET', 'OLANZAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (874, 'OLANEX TABLET 7.5 MG,7.5 MG', 'TABLET', 'OLANZAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (875, 'OLEANZ 10,10MG', 'TABLET', 'OLANZAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (876, 'OLEANZ 2.5,2.5MG', 'TABLET', 'OLANZAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (877, 'OLEANZ 5,5MG', 'TABLET', 'OLANZAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (878, 'OLEANZ 7.5,7.5MG', 'TABLET', 'OLNZAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (879, 'OLEANZ FORTE,10MG, 20MG', 'TABLET', 'OLANZAPINE, FLUOXETINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (880, 'OLEANZ PLUS,5MG, 20MG', 'TABLET', 'OLANZAPINE , FLUOXETINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (881, 'OLMEZEST 10,10MG', 'TABLET', 'OLMESARTAN MEDOXOMIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (882, 'OLMEZEST 20,20MG', 'TABLET', 'OLMESARTAN MEDOXOMIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (883, 'OLMEZEST 40,40 MG', 'TABLET', 'OLMESARTAN MEDOXOMIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (884, 'OLMEZEST AM,20MG, 5MG', 'TABLET', 'OLMESARTAN MEDOXOMIL, AMLODIPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (885, 'OLMEZEST H 20,20MG, 12.5MG', 'TABLET', 'OLMESARTAN MEDOXOMIL, HYDROCHLOROTHIAZIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (886, 'OLMEZEST H 40,12.5MG', 'TABLET', 'OLMESARTAN MEDOXOMIL, HYDROCHLOROTHIAZIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (887, 'OLVANCE 20MG TABLET,20 MG', 'TABLET', 'OLMESARTAN MEDOXOMIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (888, 'OLVANCE 40MG TABLET,40 MG', 'TABLET', 'OLMESARTAN MEDOXOMIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (889, 'OLVANCE AM 20,20MG', 'TABLET', 'OLMESARTAN MEDOXOMIL COMB.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (890, 'OLVANCE AM 40,40MG', 'TABLET', 'OLMESARTAN MEDOXOMIL COMB.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (891, 'OLVANCE CT 20,20MG + 12.5MG', 'TABLET', 'OLMESARTAN MEDOXOMIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (892, 'OLVANCE CT 40,40MG + 12.5MG', 'TABLET', 'OLMESARTAN MEDOXOMIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (893, 'OLVANCE M 25,25+20', 'TABLET', 'OLMESARTAN MEDOXOMIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (894, 'OLVANCE M 50,25+20', 'TABLET', 'OLMESARTAN MEDOXOMIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (895, 'OLVANCE â„¢ H20 TABLET,20+12.5 MG', 'TABLET', 'OLMESARTAN,HCTZ', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (896, 'OLVANCE â„¢ H40 TABLET,40+12.5 MG', 'TABLET', 'OLMESARTAN,HCTZ', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (897, 'ONCOCARBIN-AQ 15ML [1 VIL],10MG/ML', 'VIALS', 'CARBOPLATIN USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (898, 'ONCOCRISTIN-AQ 1MG [1 VIL],1MG', 'VIALS', 'VINCRISTINE SULPHATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (901, 'ONCOPLATIN AQ 20ML,0.5MG/ML, 9MG', 'VIALS', 'CISPLATIN IPL, SODIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (902, 'ONCOTAXEL-100 17ML 1VIAL,527MG, 45.7% v/v', 'VIALS', 'PACLITAXEL, POLYOXYL CASTOR OIL USNF, ABSOLUTE ALCOHOL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (903, 'ONCOTAXEL-260,6MG', 'VIALS', 'PACLITAXEL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (904, 'ONCOTREX 10,10MG', 'TABLET', 'METHOTREXATE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (905, 'ONCOTREX 2.5,2.5MG', 'TABLET', 'METHOTREXATE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (906, 'ONCOTREX-5,5MG', 'TABLET', 'METHOTREXATE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (907, 'ONCOTREX-7.5,7.5MG', 'TABLET', 'METHOTREXATE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (908, 'ONCOTRON-INJ 10ML 1 VIL,2MG/ML,0.01%W/V', 'VIALS', 'MITOXANTRONEL, SODIUMCHLORIDEIP, SODIUMMETABISULPHATE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (909, 'OSTOSPRAY,0.0002', 'VIALS', 'CALCITONIN (SALMON) BP, BENZALKONIUM CHLORIDE SOLUTION IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (910, 'OVITROP 150 IU VIAL,150IU', 'VIALS', 'UROFOLLITROPHIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (911, 'OVITROP 75 IU VIAL,75IU', 'VIALS', 'UROFOLLITROPHIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (912, 'OVURELIX,0.25MG', 'VIALS', 'CETRORELIX', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (913, 'OXETOL 150,150MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (914, 'OXETOL 300,300MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (915, 'OXETOL 600,600MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (916, 'OXETOL XR 150,150MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (917, 'OXETOL XR 300,300MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (918, 'OXETOL XR 450,450MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (919, 'OXETOL XR 600,600MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (920, 'OXETOL-450,450MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (921, 'OXIDATCH 100 MG,100 MG', 'INJECTION', 'OXALIPLATIN 100 MG., LACTOSE MONOHYDRATE I.P. 900 MG.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (922, 'OXIDATCH 50 MG,50 MG', 'INJECTION', 'OXALIPLATIN 50 MG., LACTOSE MONOHYDRATE I.P. 450 MG.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (923, 'OXIPLAT 100 (SOLUTION),5MG', 'VIALS', 'OXALIPLATIN BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (924, 'OXIPLAT 50 (SOLUTION),5MG', 'VIALS', 'OXALIPLATIN BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (925, 'PALIRIS 3,3MG', 'TABLET', 'PALIPERIDONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (926, 'PALIRIS 6,6MG', 'TABLET', 'PALIPERIDONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (927, 'PALONEW,0.05 MG', 'VIALS', 'PALONOSETRON HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (928, 'PANLIPASE,10000 USP, 37500 USP, 33200 USP', 'CAPSULE', 'LIPASE, PROTEASE, AMYLASE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (929, 'PANTOCID,40MG', 'TABLET', 'PANTOPRAZOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (930, 'PANTOCID HP,500MG, 40MG, 750MG', 'TABLET', 'CLARITHROMYCIN, PANTOPRAZOLE SODIUM, AMOX.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (931, 'PANTOCID IT,40MG, 20MG, 150MG', 'CAPSULE', 'PANTOPRAZOLE , ITOPRIDE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (932, 'PANTOCID-20,20 MG', 'TABLET', 'PANTOPRAZOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (933, 'PANTOCID-D,20MG, 10 MG', 'CAPSULE', 'PANTOPRAZOLE, DOMPERIDONE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (934, 'PANTOCID-DSR,40MG, 30MG', 'CAPSULE', 'PANTOPRAZOLE, DOMPERIDONE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (935, 'PANTOCID-IV 40MG INJ,40MG', 'VIALS', 'PANTOPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (936, 'PARKITIDIN,100MG', 'TABLET', 'AMANTADINE HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (937, 'PAXIDEP CR-12.5,12.5MG', 'TABLET', 'PAROXETINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (938, 'PAXIDEP CR-25,25MG', 'TABLET', 'PAROXETINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (939, 'PAXIDEP CR-37.5,37.5MG', 'TABLET', 'PAROXETINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (940, 'PEG XPHIL 6MG ( 0.6ML) INJECTION,6 MG', 'INJECTION', '6 MG OF PEGYLATED R-HUGCSF', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (941, 'PEGLITON 100,100 MCG', 'INJECTION', 'VIAL CONTAINS 100MCG OF PEGYLATED RECOMBINANT HUMAN INTERFERON ALPHA 2B', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (942, 'PEGLITON 50MCG,50 MCG', 'TABLET', 'VIAL CONTAINS 50MCG OF PEGYLATED RECOMBINANT HUMAN INTERFERON ALPHA 2B', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (943, 'PEGLITON 80MCG,80 MCG', 'TABLET', 'VIAL CONTAINS 80MCG OF PEGYLATED RECOMBINANT HUMAN INTERFERON ALPHA 2B', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (944, 'PEXITAZ 500MG,500MG', 'VIALS', 'PEMETREXED', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (945, 'PILOMAX 5,5MG', 'TABLET', 'PILOCARPINE HYDROCHLORIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (946, 'PIMERA INJECTION,1G + 125MG', 'INJECTION', 'CEFUROXIME SODIUM , TAZOBACTAM SODIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (947, 'PIOGLAR 7.5MG,7.5 MG', 'TABLET', 'PIOGLITAZONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (948, 'PIOGLAR G TABLET 15 + 2 MG,15 MG + 2 MG', 'TABLET', 'PIOGLITAZONE,GLIMEPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (949, 'PIOGLAR GF TABLET 30 + 2 MG,30 MG + 2 MG', 'TABLET', 'PIOGLITAZONE,GLIMEPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (950, 'PIOGLAR MF 15+500 MG,15 MG + 500 MG', 'TABLET', 'POIGLITAZONE,METFORM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (951, 'PIOGLAR MF 30+500 MG,30 MG + 500 MG', 'TABLET', 'POIGLITAZONE,METFORM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (952, 'PIOGLAR MF 7.5MG,7.5 MG', 'TABLET', 'PIOGLITAZONE METFORMING COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (953, 'PIOGLAR TABLET 15 MG,15 MG', 'TABLET', 'POIGLITAZONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (954, 'PIOGLAR TABLET 30 MG,30 MG', 'TABLET', 'POIGLITAZONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (955, 'PIOGLIT 15,15MG', 'TABLET', 'PIOGLITAZONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (956, 'PIOGLIT 30,30MG', 'TABLET', 'PIOGLITAZONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (957, 'PIOGLIT MF FORTE 15,15MG, 850MG', 'TABLET', 'PIOGLITAZONE, METFORMIN HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (958, 'PIOGLIT-G,15MG, 2MG', 'TABLET', 'PIOGLITAZONE, GLIMEPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (959, 'PIOGLIT-GF,2MG', 'TABLET', 'PIOGLITAZONE, GLIMEPIRIDE.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (960, 'PIOGLIT-MF 15,15MG, 500MG', 'TABLET', 'PIOGLITAZONE, METFORMIN HYDRCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (961, 'PIOGLIT-MF 30,30MG., 500MG', 'TABLET', 'PIOGLITAZONE. METFORMIN HYDROCHLORIDE IP.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (962, 'PIOGLIT-MF 7.5,7.5MG., 500MG', 'TABLET', 'PIOGLITAZONE, METFORMIN HYDRCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (963, 'PIOGLUCORED FORTE,5MG, 500MG, 15MG', 'TABLET', 'GLIBENCLAMIDE IP, METFORMIN HYDROCHLORIDE IP, PIOGLITAZONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (964, 'PRAMIPEX 0.125,0.125 MG', 'TABLET', 'PRPAMIPEXOLE DIHYDROCHLORIDE MONOHYDRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (965, 'PRAMIPEX 0.25,0.25 MG', 'TABLET', 'PRPAMIPEXOLE DIHYDROCHLORIDE MONOHYDRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (966, 'PRAMIPEX 0.5,0.5 MG', 'TABLET', 'PRPAMIPEXOLE DIHYDROCHLORIDE MONOHYDRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (967, 'PRAMIPEX 1,1 MG', 'TABLET', 'PRPAMIPEXOLE DIHYDROCHLORIDE MONOHYDRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (968, 'PRASITA 10MG,10 MG', 'TABLET', 'PRASUGREL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (969, 'PRASITA 5MG,5 MG', 'TABLET', 'PRASUGREL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (970, 'PRAZOPRESS 1,1MG', 'TABLET', 'PRAZOSIN BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (971, 'PRAZOPRESS 2,2MG', 'TABLET', 'PRAZOSIN BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (972, 'PRAZOPRESS-XL 2.5,2.5MG', 'TABLET', 'PRAZOSIN HCL EQ. TO PRAZOSIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (973, 'PRAZOPRESS-XL 5,5MG', 'TABLET', 'PRAZOSIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (974, 'PRECIZE INJ 1.5 GM,1 GM + 0.5 GM', 'INJECTION', 'CEFOPERAZONE,SULBACTAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (975, 'PRECIZE INJ 3 GM,2 GM + 1 GM', 'INJECTION', 'CEFOPERAZONE,SULBACTAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (976, 'PREDMET 16,16MG', 'TABLET', 'METHYLPREDNISOLONE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (977, 'PREDMET 4,4MG', 'TABLET', 'METHYLPREDNISOLONE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (978, 'PREDMET 8,8MG', 'TABLET', 'METHYLPREDNISOLONE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (979, 'PRIMOX 25,25MG', 'TABLET', 'NORTRIPTYLINE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (980, 'PRODEP,20MG', 'CAPSULE', 'FLUOXETINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (981, 'PRODEP 10,10MG', 'CAPSULE', 'FLUOXETINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (982, 'PRODEP 60,60MG', 'CAPSULE', 'FLUOXETINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (983, 'PROLOMET AM 25,23.75MG, 25MG, 5MG', 'TABLET', 'METOPROLOL TARTARATE , AMLODIPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (984, 'PROLOMET AM 50,47.50MG, 50MG , 5MG', 'TABLET', 'METOPROLOL TARTARATE, AMLODIPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (985, 'PROLOMET R 25,23.75MG,25MG, 2.5MG', 'TABLET', 'METOPROLOL TARTARATE, RAMIPRIL USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (986, 'PROLOMET R 50,23.75MG,50MG, 5MG', 'TABLET', 'METOPROLOL TARTARATE, RAMIPRIL USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (987, 'PROLOMET XL 100,95MG, 100MG', 'TABLET', 'METOPROLOL TARTARATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (988, 'PROLOMET XL 12.5,11.875MG, 12.5MG', 'TABLET', 'METOPROLOL TARTARATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (989, 'PROLOMET XL 25,23.75MG, 25MG', 'TABLET', 'METOPROLOL TARTARATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (990, 'PROLOMET XL 50,47.5MG, 50MG', 'TABLET', 'METOPROLOL TARTARATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (991, 'PULMOZA,200MG', 'TABLET', 'OZAGREL HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (992, 'PUREGEST 200,200MG', 'CAPSULE', 'PROGESTERONE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (993, 'PUREGEST 400,400MG', 'CAPSULE', 'PROGESTERONE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (994, 'PYRODEX,20MG', 'TABLET', 'PIROXICAM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (995, 'QUTIPIN SR 100,100 MG', 'TABLET', 'QUETIAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (996, 'QUTIPIN SR 200,200 MG', 'TABLET', 'QUETIAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (997, 'QUTIPIN SR 300,300 MG', 'TABLET', 'QUETIAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (998, 'QUTIPIN SR 400,400MG', 'TABLET', 'QUETIAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (999, 'QUTIPIN SR 50,50 MG', 'TABLET', 'QUETIAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1000, 'QUTIPIN-100,100MG', 'TABLET', 'QUETIAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1001, 'QUTIPIN-200,200MG', 'TABLET', 'QUETIAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1002, 'QUTIPIN-25,25MG', 'TABLET', 'QUETIAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1003, 'QUTIPIN-300,300MG', 'TABLET', 'QUETIAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1004, 'QUTIPIN-50,50MG', 'TABLET', 'QUETIAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1005, 'RACIPER D 20 CAPSULE,20+30 MG', 'CAPSULE', 'ESOMEPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1006, 'RACIPER D 40,40+30 MG', 'CAPSULE', 'ESOMEPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1007, 'RACIPER INJ IV 40MG 5ML,40 MG', 'INJECTION', 'ESOMEPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1008, 'RACIPER L CAPSULE,40 + 75 MG', 'CAPSULE', 'ESOMEPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1009, 'RACIPER TABLET 20 MG,20 MG', 'TABLET', 'ESOMEPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1010, 'RACIPER TABLET 40 MG,40 MG', 'TABLET', 'ESOMEPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1011, 'RAMITAX TABLET 8MG,8MG', 'TABLET', 'RAMELTEON 8MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1012, 'RANBAXY EXIDIL 2%,0.02', 'LOTION', 'MINOXIDIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1013, 'RANBAXY EXIDIL 5%,0.05', 'LOTION', 'MINOXIDIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1014, 'RANCIL 10 MG,10MG', 'TABLET', 'CILNIDIPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1015, 'RANCIL 5 MG,5MG', 'TABLET', 'CILNIDIPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1016, 'RANOZEX,500MG', 'TABLET', 'RANOLAZINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1017, 'RAPIFOL-20,10MG', 'VIALS', 'EPROPOFOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1018, 'RASALECT 0.5,0.5MG', 'TABLET', 'RASAGILINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1019, 'RASALECT 1,1MG', 'TABLET', 'RASAGILINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1020, 'REBOSE-25,25MG', 'TABLET', 'ACARBOSE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1021, 'REBOSE-50,50MG', 'TABLET', 'ACARBOSE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1022, 'REFLIN INJECTION 1 GM+WFI,1 GM', 'INJECTION', 'CEFAZOLIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1023, 'REFLIN INJECTION 250 MG+WFI,250 MG', 'INJECTION', 'CEFAZOLIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1024, 'REFLIN INJECTION 500 MG+WFI,500 MG', 'INJECTION', 'CEFAZOLIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1025, 'REFZIL O 125MG SUSP.,125 MG', 'SUSPENSION', 'CEFPROZIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1026, 'REFZIL O 250MG SUSP.,250 MG', 'SUSPENSION', 'CEFPROZIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1027, 'REFZIL O ORAL DROPS,50 MG', 'DROPS', 'CEFPROZIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1028, 'REFZIL O TABLET 250 MG,250 MG', 'TABLET', 'CEFPROZIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1029, 'REFZIL O TABLET 500 MG,500 MG', 'TABLET', 'CEFPROZIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1030, 'REPACE 100,100MG', 'TABLET', 'LOSARTAN POTASSIUM USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1031, 'REPACE 25,25M', 'TABLET', 'LOSARTAN POTASSIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1032, 'REPACE 50,50MG', 'TABLET', 'LOSARTAN POTASSIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1033, 'REPACE H,12.5MG', 'TABLET', 'LOSARTAIN POTTASIUM, HYDROCHLORTHIAZIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1034, 'REPACE-A,25MG, 5MG', 'TABLET', 'LOSARTAN POTASSIUM, AMLODIPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1035, 'REPACE-AF,50MG, 5MG', 'TABLET', 'LOSARTAN POTASSIUM, AMLODIPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1036, 'REPALOL H,50MG,50MG,12.5MG', 'TABLET', 'LOSARTAN POTASSIUM USP, ATENOLOL IP, HYDROCHLOROTHIAZIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1037, 'REPALOL TAB,50MG ,50MG', 'TABLET', 'LOSARTAN POTASSIUM, ATENOLOL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1038, 'RESTOFOS-70,70MG', 'TABLET', 'ALENDRONIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1039, 'REVOCON,25 MG', 'TABLET', 'TETRABENAZINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1040, 'REVULANT TABLET 1G,1 GM', 'TABLET', 'RANOLAZINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1041, 'REVULANT TABLET 500 MG,500 MG', 'TABLET', 'RANOLAZINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1042, 'RHEORAN SF 125 INHALER 19ML,125 MCG+19 ML', 'INHALER', 'SALBUT. INHALERS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1043, 'RHEORAN SF 250 INHALER 19ML,250 MCG+19 ML', 'INHALER', 'SALBUT. INHALERS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1044, 'RHEORAN SF 500 MCG OCTACAPS,UA', 'CAPSULE', 'SALMETEROL 50MCG & FLUTICASONE 500MCG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1045, 'RHEORAN-SF 100 MCG OCTACAPS,UA', 'CAPSULE', 'SALMETEROL 50MCG & FLUTICASONE100MCG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1046, 'RHEORAN-SF 250 MCG OCTACAPS,UA', 'CAPSULE', 'SALMETEROL 50MCG & FLUTICASONE 250MCG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1047, 'RICONIA G,MULTIPLE INGREDIENTS', 'CAPSULE', 'GINSENG,VITAMINS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1048, 'RICONIA LP SILVER TABLET,MULTIPLE INGREDIENTS', 'TABLET', 'FORTIFIED MICRONUTRIENTS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1049, 'RICONIA LP TABLET,MULTIPLE INGREDIENTS', 'TABLET', 'FORTIFIED MICRONUTRIENTS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1050, 'RICONIAÂ« SYRUP 1CB,100 ML', 'SYRUP', 'GINSENG,VITAMINS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1051, 'RIDAZIN 10,10MG', 'TABLET', 'THIORIDAZINE HCL BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1052, 'RIDAZIN 25,25MG', 'TABLET', 'THIORIDAZINE HCL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1053, 'RIDAZIN 50,50MG', 'TABLET', 'THIORIDAZINE HCL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1054, 'RIFAGUT,200MG', 'TABLET', 'RIFAXIMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1055, 'RIOMET 500MG,500 MG', 'TABLET', 'HYDROCHLORIED IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1056, 'RIOMET DUO 1 TABLET,500+2 MG', 'TABLET', 'GLIMEPERIDE,METFORMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1057, 'RIOMET DUO 2 TABLET,500+2 MG', 'TABLET', 'GLIMEPERIDE,METFORMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1058, 'RIOMET DUO FORTE 1,1MG + 1000MG', 'TABLET', 'METFORMIN HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1059, 'RIOMET DUO FORTE 2,2MG + 1000MG', 'TABLET', 'METFORMIN HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1060, 'RIOMET TABLET 1000 MG,5 MG', 'TABLET', 'METFORMIN : 1000MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1061, 'RIOMET TABLET 500 MG,5 MG', 'TABLET', 'METFORMIN : 500MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1062, 'RIOMET TABLET 850 MG,850 MG', 'TABLET', 'METFORMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1063, 'RIOMET TRIO 1 TABLET,1 MG', 'TABLET', 'METFORMIN,PIOGLITAZONE,GLIMEPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1064, 'RIOMET TRIO 2 TABLET,2 MG', 'TABLET', 'METFORMIN,PIOGLITAZONE,GLIMEPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1065, 'RIOMET TRIO LS 1,500MG + 7.5MG + 1MG', 'TABLET', 'METFORMIN,PIOGLITAZONE,GLIMEPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1066, 'RIOMET TRIO LS 2,500MG + 7.5MG + 1MG', 'TABLET', 'METFORMIN,PIOGLITAZONE,GLIMEPIRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1067, 'RITOVAZ TABLET 30S,300MG + 100MG', 'TABLET', 'ATAZANAVIR 300MG , RITONAVIR IP 100MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1068, 'RIVAMER-1.5,1.5MG', 'CAPSULE', 'RIVASTIGMINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1069, 'RIVAMER-3,3MG', 'CAPSULE', 'RIVASTIGMINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1070, 'ROLES - D CAPSULE,10MG', 'CAPSULE', 'RABEPRAZOLE 20MG (EC) , DOMPERIDONE 30MG (SR)', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1071, 'ROLES L TABLET,75MG + 20MG', 'TABLET', 'RABEPRAZOLE SODIUM 20MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1072, 'ROLES TABLET 20 MG,20MG', 'TABLET', 'RABEPRAZOLE 20MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1073, 'ROLIFLO OD,4MG + 0.4MG', 'CAPSULE', 'TOLTERODINE , TAMSULOSIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1074, 'ROLIFLO OD CAP 2+0.4MG,2+0.4MG', 'CAPSULE', 'TOLTERODINE , TAMSULOSIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1075, 'ROLITEN OD CAP 2 MG,2 MG', 'CAPSULE', 'TOLTERODINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1076, 'ROLITEN OD CAP 4MG,4 MG', 'CAPSULE', 'TOLTERODINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1077, 'ROLITEN TABLET 1 MG,1 MG', 'TABLET', 'TOLTERODINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1078, 'ROLITEN TABLET 2 MG,2 MG', 'TABLET', 'TOLTERODINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1079, 'ROLSICAL PLUS,0.25MCG, 500MG, 7.5MG', 'CAPSULE', 'CALCITRIOL BP, CALCIUM CARBONATE IP, ZINC', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1080, 'ROMILAST 10MG TABLET,10 MG', 'TABLET', 'MONTELUKAST', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1081, 'ROMILAST 4MG TABLET,4 MG', 'TABLET', 'MONTELUKAST', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1082, 'ROMILAST 5MG TABLET,5 MG', 'TABLET', 'MONTELUKAST', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1083, 'ROMILAST B - 10 TABLET,10 MG + 10MG', 'TABLET', 'MONTELUKAST , BAMBUTEROL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1084, 'ROMILAST B - 5 TABLET,5 MG+10 MG', 'TABLET', 'MONTELUKAST , BAMBUTEROL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1085, 'ROMILAST FX TABLET,10MG + 120MG', 'TABLET', 'EQUIVALENT TO MONTELUKAST 10 MG , FEXOFENADINE HYDROCHLORIDE IP 120 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1086, 'ROMILAST L 4 TABLET,4 + 2.5MG', 'TABLET', 'LEVOCETRIZINE HYDROCHLORIDE , MONTELUKAST SODIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1087, 'ROMILAST L 5 TABLET,5 + 2.5MG', 'TABLET', 'LEVOCETRIZINE HYDROCHLORIDE , MONTELUKAST SODIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1088, 'ROMILAST L SYRUP 60ML,60 ML', 'SYRUP', 'LEVOCETIRIZINE, DIHYDROCHLORIDE , MONTELUKAST SODIUM IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1089, 'ROMILAST L TABLET 10MG,10 MG', 'TABLET', 'MONTELUKAST,LEVOCETIRIZINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1090, 'ROMILAST ORAL GR. 4MG,4 MG', 'ORAL GRANULES', 'MONTELUKAST', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1091, 'ROPARK-0.25,0.25MG', 'TABLET', 'ROPINIROLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1092, 'ROPARK-0.5,0.5MG', 'TABLET', 'ROPINIROLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1093, 'ROPARK-1,1MG', 'TABLET', 'ROPINIROLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1094, 'ROPARK-2,2MG', 'TABLET', 'ROPINIROLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1095, 'ROSCILLIN CAPSULE 250MG,250 MG', 'CAPSULE', 'AMPICILLIN TRIHYDRAT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1096, 'ROSCILLIN CAPSULE 500MG,500 MG', 'CAPSULE', 'AMPICILLIN TRIHYDRAT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1097, 'ROSCILLIN TABLETLET 125MG,125 MG', 'TABLETS', 'AMPICILLIN TRIHYDRAT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1098, 'ROSCILLIN TABLETLET 250 MG,250 MG', 'TABLETS', 'AMPICILLIN TRIHYDRAT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1099, 'ROSCILLIN DROPS,100 MG/ML', 'DROPS', 'AMPICILLIN TRIHYDRAT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1100, 'ROSCILLIN INJECTION 250MG,250 MG', 'INJECTION', 'AMPICILLIN TRIHYDRAT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1101, 'ROSCILLIN INJECTION 500MG,500 MG', 'INJECTION', 'AMPICILLIN TRIHYDRAT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1102, 'ROSCILLIN SUSPENSION 125MG,125 MG/5 ML', 'SUSPENSION', 'AMPICILLIN TRIHYDRAT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1103, 'ROSCILLIN SUSPENSION 250MG,250 MG/5 ML', 'SUSPENSION', 'AMPICILLIN TRIHYDRAT', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1104, 'ROSUVAS 40MG,40 MG', 'TABLET', 'ROSUVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1105, 'ROSUVAS D 10 TABLET,10 MG + 1000 IU', 'TABLET', 'ROSUVASTATIN CALCIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1106, 'ROSUVAS D 5 TABLET,5 MG + 1000 IU', 'TABLET', 'ROSUVASTATIN CALCIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1107, 'ROSUVAS EZ 10MG TABLET,10MG', 'TABLET', 'ROSUVASTATIN EZITAMIBE COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1108, 'ROSUVAS F20,20+160', 'TABLET', 'ROSUVASTATIN ,FENOFIBRATE COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1109, 'ROSUVAS TABLET 10 MG,10 MG', 'TABLET', 'ROSUVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1110, 'ROSUVAS TABLET 10MG 15S,10MG', 'TABLET', 'ROSUVASTATIN FEONFIBRATE COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1111, 'ROSUVAS TABLET 10MG 1X30BTL (CP),10MG', 'TABLET', 'ROSUVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1112, 'ROSUVAS TABLET 20 MG,20 MG', 'TABLET', 'ROSUVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1113, 'ROSUVAS TABLET 5 MG,5 MG', 'TABLET', 'ROSUVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1114, 'ROSUVAS TABLET 5MG 15S,5 MG', 'TABLET', 'ROSUVASTATIN FEONFIBRATE COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1115, 'ROSUVAS TABLET 5MG 1X30BTL (CP),5MG', 'TABLET', 'ROSUVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1116, 'ROSUVASÂ® F 10,10MG + 160MG', 'TABLET', 'ROSUVASTATIN ,FENOFIBRATE COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1117, 'ROSUVASÂ® F 5,5MG + 160MG', 'TABLET', 'ROSUVASTATIN ,FENOFIBRATE COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1118, 'ROZAVEL 10,10MG', 'TABLET', 'ROSUVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1119, 'ROZAVEL 20,20MG', 'TABLET', 'ROSUVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1120, 'ROZAVEL 5,5MG', 'TABLET', 'ROSUVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1121, 'ROZAVEL EZ,10MG, 10MG', 'TABLET', 'ROSUVASTATIN, EZETIMIBE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1122, 'RUBIZEN 10 MG,10 MG', 'INJECTION', 'EPIRUBICIN HYDROCHLORIDE 10 MG, LACTOSE I.P. 50 MG.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1123, 'RUBIZEN 50 MG,50 MG', 'INJECTION', 'EPIRUBICIN HYDROCHLORIDE 50 MG, LACTOSE I.P. 50 MG.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1124, 'RULIZO TABLET,600 MG', 'TABLET', 'PRULIFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1125, 'SEBIFIN CREAM,15 GM', 'CREAM', 'TERBINAFINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1126, 'SEBIFIN POWDER 30GM,30GMS', 'POWDER', 'TERBINAFINE HCI BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1127, 'SEBIFIN PLUS CREAM,15 GM', 'CREAM', 'TERBINAFINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1128, 'SEBIFIN TABLET 250MG,250MG', 'TABLET', 'TERBINAFINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1129, 'SELZIC TABLET 150MG,150 MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1130, 'SELZIC TABLET 300 MG,300 MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1131, 'SELZIC TABLET 600 MG,600 MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1132, 'SELZIC TABLET 900MG,900 MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1133, 'SELZIC TABLET 150 MG,150 MG', 'TABLET', 'OXCARBAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1134, 'SENVAL CHRONO TABLET 200MG,200 MG', 'TABLET', 'SODIUM VALPROATE IP 134 MG,VALPROIC ACID USP 58 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1135, 'SENVAL CHRONO TABLET 300MG,300 MG', 'TABLET', 'SODIUM VALPROATE IP 201 MG,VALPROIC ACID USP 87 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1136, 'SENVAL CHRONO TABLET 500MG,500 MG', 'TABLET', 'SODIUM VALPROATE IP 335 MG,VALPROIC ACID USP 145 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1137, 'SERLIFT TABLET 100MG,100 MG', 'ORAL GRANULES', 'SERTRALINE HCL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1138, 'SERLIFT TABLET 25MG,25 MG', 'TABLET', 'SERTRALINE HCL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1139, 'SERLIFT TABLET 50MG,50 MG', 'TABLET', 'SERTRALINE HCL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1140, 'SILBOSTIN,120MG', 'CAPSULE', 'SILYBIN PHOSPHOLIPIDS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1141, 'SILICOMET-10ML,10ML', 'VIALS', 'SILICONE OIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1142, 'SILODAL 4MG CAPSULE,4 MG', 'TABLET', 'SILODOSIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1143, 'SILODAL 8MG CAPSULE,8 MG', 'TABLET', 'SILODOSIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1144, 'SILODAL D 4MG KIT CAPSULE,0.5MG + 4MG', 'CAPSULE', 'SILODOSIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1145, 'SILODAL D 8MG KIT CAPSULE,0.5MG + 8MG', 'CAPSULE', 'SILODOSIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1146, 'SILVEREX IONIC 10GM,10 GM', 'GEL', 'SILVER NITRATE IP 0.2% W/W, ETHY ALCOHOL IP 4%', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1147, 'SILVEREX IONIC 20GM,20 GM', 'GEL', 'SILVER NITRATE IP 0.2% W/W, ETHY ALCOHOL IP 4%', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1148, 'SILVEREX IONIC 240GM JAR,240 GM', 'GEL', 'SILVER NITRATE IP 0.2% W/W, ETHY ALCOHOL IP 4%', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1149, 'SIMVOTIN EZ TABLET 10 MG,10MG', 'TABLET', 'SIMVASTATIN EZITAMIBE COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1150, 'SIMVOTIN EZ TABLET 20 MG,20 MG', 'TABLET', 'SIMVASTATIN COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1151, 'SIMVOTIN TABLET 10 MG,10 MG', 'TABLET', 'SIMVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1152, 'SIMVOTIN TABLET 20 MG,20 MG', 'TABLET', 'SIMVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1153, 'SIMVOTIN TABLET 40 MG,40 MG', 'TABLET', 'SIMVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1154, 'SIMVOTIN TABLET 5 MG,5 MG', 'TABLET', 'SIMVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1155, 'SIR-SPHERE INJECTION,3GBQ', 'INJECTION', 'YTTRIUM-90 MICROSPHERE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1156, 'SIZODON 1,1MG', 'TABLET', 'RESPERIDONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1157, 'SIZODON 2,2MG', 'TABLET', 'RESPERIDONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1158, 'SIZODON 3,3MG', 'TABLET', 'RESPERIDONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1159, 'SIZODON 4,4MG', 'TABLET', 'RESPERIDONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1160, 'SIZODON FORTE,4MG, 2MG', 'TABLET', 'RISPERIDONE, TRIHEXYPHENIDYL HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1161, 'SIZODON LS,2MG, 2MG', 'TABLET', 'RISPERIDONE BP, TRIHEXYPHENIDYL HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1162, 'SIZODON MD 0.5,0.5MG', 'TABLET', 'RISPERIDONE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1163, 'SIZODON MD 1,1MG', 'TABLET', 'RISPERIDONE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1164, 'SIZODON PLUS,3MG, 2MG', 'TABLET', 'RISPERIDONE, TRIHEXYPHENIDYL HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1165, 'SIZODON-ORAL-SUSP 60ML 1 BTL,1MG', 'SUSPENSION', 'RESPERIDONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1166, 'SIZOPIN 100,100MG', 'TABLET', 'CLOZAPIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1167, 'SIZOPIN 25,25MG', 'TABLET', 'CLOZAPIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1168, 'SIZOPIN-50,50MG', 'TABLET', 'CLOZAPINE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1169, 'SKELACT,50MG', 'TABLET', 'EPERISONE HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1170, 'SKIFI 100 DS DRY SYRUP,15 ML', 'SUSPENSION', 'CEFIXIME', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1171, 'SKIFI 100MG DT TABLET,100 MG', 'TABLET', 'CEFIXIME', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1172, 'SKIFI 200 MD TABLET,200 MG', 'TABLET', 'CEFIXIME', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1173, 'SKIFI 200 MG TABLET,200 MG', 'TABLET', 'CEFIXIME', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1174, 'SKIFI 50 DS DRY SYRUP,15 ML', 'SUSPENSION', 'CEFIXIME', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1175, 'SKIFI AZ 250 TABLET,200 +250 MG', 'TABLET', 'CEFIXIME', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1176, 'SKIFI AZ 500 TABLET,200 +500 MG', 'TABLET', 'CEFIXIME', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1177, 'SKIFI CV,200 MG + 125 MG', 'TABLET', 'CEFIXIME', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1178, 'SOBRIUM TABLET 10 MG,10 MG', 'TABLET', 'ZOLPIDEM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1179, 'SOBRIUM TABLET 5 MG,5 MG', 'TABLET', 'ZOLPIDEM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1180, 'SOCALM SR TABLET 100MG,100 MG', 'TABLET', 'QUETIAPINE FUMARATE 100MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1181, 'SOCALM SR TABLET 200MG,200 MG', 'TABLET', 'QUETIAPINE FUMARATE 200MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1182, 'SOCALM SR TABLET 300MG,300 MG', 'TABLET', 'QUETIAPINE FUMARATE 300MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1183, 'SOCALM SR TABLET 50MG,50 MG', 'TABLET', 'QUETIAPINE FUMARATE 50MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1184, 'SODOX CAPS,MULTI INGREDIENTS', 'CAPSULE', 'MELON EXTRACT EQUIVALENT TO SUPEROXIDE DISMUTASE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1185, 'SOLITEN TABLET 10 MG,10 MG', 'TABLET', 'SOLIFENACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1186, 'SOLITEN TABLET 5 MG,5 MG', 'TABLET', 'SOLIFENACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1187, 'SOLITRAL,10+5MG', 'CAPSULE', 'SOLIFENACIN , ALFUZOCIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1403, 'VORAZE INJECTION,200MG', 'VIALS', 'VORICONAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1188, 'SOLPHEN TABLET 100MG,100 MG', 'TABLET', 'PHENYTOIN SODIUM 100 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1189, 'SOLZAM TABLET 10 MG,10 MG', 'TABLET', 'CLOBAZAM IP 10 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1190, 'SOLZAM TABLET 5 MG,5 MG', 'TABLET', 'CLOBAZAM IP 5 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1191, 'SOMPRAZ D 20,40MG, 30MG', 'CAPSULE', 'ESOMEPRAZOLE, DOMPERIDONE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1192, 'SOMPRAZ D 40,40MG, 30MG', 'CAPSULE', 'ESOMEPRAZOLE , DOMPERIDONE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1193, 'SOMPRAZ HP', 'TABLET', 'CLARITHROMYCIN, ESOMEPRAZOLE MAGNESIUM, AMOXICILLIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1194, 'SOMPRAZ IT,40MG,20MG,150MG', 'CAPSULE', 'ESOMEPRAZOLE , ITOPRID HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1195, 'SOMPRAZ-20,20MG', 'TABLET', 'ESOMEPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1196, 'SOMPRAZ-40,40MG', 'TABLET', 'ESOMEPRAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1197, 'SOREST 100 TABLET,100 MG', 'TABLET', 'FLUOXAMINE 100MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1198, 'SOREST 50 TABLET,50 MG', 'TABLET', 'FLUOXAMINE 50MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1199, 'SOTRET CAPSULE 30MG,30 MG', 'CAPSULE', 'ISOTRETINON 30 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1200, 'SOTRET CAPSULE 40MG,40 MG', 'CAPSULE', 'ISOTRETINON 40 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1201, 'SOTRET CAPSULE 10 MG,10 MG', 'CAPSULE', 'ISOTRETINON', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1202, 'SOTRET CAPSULE 20 MG,20 MG', 'CAPSULE', 'ISOTRETINON', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1203, 'SOTRET GEL 30GM,30 GM', 'GEL', 'ISOTRETINON', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1204, 'SOTRET SOAP,75GMS', 'SOAP', 'SALICYLIC ACID; SODIUM LACTATE;GLYCERINE; TITANIUM DIOXIDE; TRICLOSAN;E.D.T.A./ CODEX; BASIL EXTRACT; MINT OIL/MENTHOL; TEA TREE OIL; OLIVE OIL/ OLEIVEM 400', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1205, 'SPASRIL TABLET,2.5 MG+5 MG', 'TABLET', 'CHLORDIAZ COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1206, 'SPECTRA 10MG,10 MG', 'CAPSULE', 'DOXEPIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1207, 'SPECTRA 25MG,25 MG', 'CAPSULE', 'DOXEPIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1208, 'SPECTRA 75MG,75 MG', 'CAPSULE', 'DOXEPIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1209, 'SPEELAC FACE LIQUID,60GM', 'LIQUID', 'SALICYCLIC 2% FACE LIQUID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1210, 'SPORIDEX AF TABLET 375 MG,375 MG', 'AF TABLET', 'CEPHALEXIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1211, 'SPORIDEX AF TABLET 750 MG,750 MG', 'AF TABLET', 'CEPHALEXIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1212, 'SPORIDEX CAPSULE 250 MG,250 MG', 'CAPSULE', 'CEPHALEXIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1213, 'SPORIDEX CAPSULE 500 MG,500 MG', 'CAPSULE', 'CEPHALEXIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1214, 'SPORIDEX TABLETLET 125 MG,125 MG', 'TABLETS', 'CEPHALEXIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1215, 'SPORIDEX TABLETLET 250 MG,250 MG', 'TABLETS', 'CEPHALEXIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1216, 'SPORIDEX DROPS,100 MG/ML', 'DROPS', 'CEPHALEXIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1217, 'SPORIDEX REDIMIX 125MG,125 MG/5 ML', 'REDIMIX', 'CEPHALEXIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1218, 'SPORIDEX REDIMIX 250MG,250 MG/5 ML', 'REDIMIX', 'CEPHALEXIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1219, 'SPORIDEX REDIMIX DROPS,100 MG/ML', 'DROPS', 'CEPHALEXIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1220, 'SPORIDEX SUSPENSION 125 MG,125 MG/5 ML', 'SUSPENSION', 'CEPHALEXIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1221, 'SPORIDEX SUSPENSION 250 MG,250 MG/5 ML', 'SUSPENSION', 'CEPHALEXIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1222, 'STANLIP PLUS 135MG DR,135MG', 'TABLET', 'CHOLINE FINOFIBRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1223, 'STANLIP TABLET 145 MG,145MG', 'TABLET', 'FENOFIBRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1224, 'STINBO CARTRIDGE,750MCG / 3ML', 'INJECTION', 'TERIPARATIDE (R-HUMAN PARATHYROID HORMONE)', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1225, 'STINBO INJECTION,750MCG / 3ML', 'INJECTION', 'TERIPARATIDE (R-HUMAN PARATHYROID HORMONE)', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1226, 'STORFIB TABLET,10 MG', 'TABLET', 'ATORVASTASTIN,FENOFIBRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1227, 'STORVAS D 10MG,10MG + 1000 IU', 'TABLET', 'ATORVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1228, 'STORVAS D 20MG,20MG + 1000 IU', 'TABLET', 'ATORVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1229, 'STORVAS EZ 10 TABLET,10 MG + 10MG', 'TABLET', 'ATORVASTATIN COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1230, 'STORVAS EZ 20 TABLET,20 MG+10 MG', 'TABLET', 'ATORVASTATIN,EZETIMIBE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1231, 'STORVAS TABLET 10 MG,10 MG', 'TABLET', 'ATORVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1234, 'STORVAS TABLET 20 MG,20 MG', 'TABLET', 'ATORVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1236, 'STORVAS TABLET 40 MG,40 MG', 'TABLET', 'ATORVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1237, 'STORVAS TABLET 80 MG,80 MG', 'TABLET', 'ATORVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1238, 'STORVASÂ®5MG TABLET,5 MG', 'TABLET', 'ATORVASTATIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1239, 'STROCIT 500,500MG', 'TABLET', 'CITICOLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1240, 'STROCIT CR,1000MG', 'TABLET', 'CITICOLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1241, 'STROCIT ORAL DROPS,100MG', 'DROPS', 'CITICOLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1242, 'STRONGER NEO MINOPHAGEN C,30ML', 'TABLET', 'GLYCYRRHIZIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1243, 'SUDOPEN INJ 250MG,250 MG', 'INJECTION', 'DORIPENEM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1244, 'SUDOPEN INJ 500MG,500MG', 'INJECTION', 'DORIPENEM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1245, 'SUDOPEN INJ KIT 500 MG,500 MG', 'INJECTION', 'DORIPENEM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1246, 'SULPITAC 100,100MG', 'TABLET', 'AMISULPRIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1247, 'SULPITAC 200,200MG', 'TABLET', 'AMISULPRIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1248, 'SULPITAC 300,300MG', 'TABLET', 'AMISULPRIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1249, 'SULPITAC 400,400MG', 'TABLET', 'AMISULPRIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1250, 'SULPITAC 50,50MG', 'TABLET', 'AMISULPRIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1251, 'SUMINAT 100,100MG', 'TABLET', 'SUMATRIPTAN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1252, 'SUMINAT 25,25MG', 'TABLET', 'SUMATRIPTAN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1253, 'SUMINAT 50,50MG', 'TABLET', 'SUMATRIPTAN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1254, 'SUMINAT NASAL SPRAY,20MG,', 'VIALS', 'SUMATRIPTAN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1255, 'SUNCROS 50 AQUALOTION,60 ML', 'LOTION', 'OCTIXONATE,OXYBENZONE,AVOBENZONE,OCTOCRYLENE,ZINC OXIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1256, 'SUNCROS AQUAGEL 100GM JAR,100ML', 'GEL', 'OCTINOXATE USP 7.5% W/W, AVOBENZONE USP 2% W/W,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1257, 'SUNCROS GEL 100 ML BOTTLE,100ML', 'GEL', 'COMB OCTINOXATE OXYBENZONE AVOBENZONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1258, 'SUNCROS LOTION,100ML', 'LOTION', 'OCTIXONATE,OXYBENZONE,AVOBENZONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1259, 'SUNCROS SOFT,50GM', 'CREAM', 'OCTIXONATE,OXYBENZONE,AVOBENZONE,OCTOCRYLENE,ZINC OXIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1260, 'SUNCROS UVA 50 GM,50 GM', 'GEL', 'OCTIXONATE,OXYBENZONE,AVOBENZONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1261, 'SUPATRET 0.04 %,0.04 % W/W', 'TUBE', 'TRETINOIN MICROSPHERE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1262, 'SUPATRET GEL,0.1%W/W', 'TUBE', 'TRETINOINMICROSPHERE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1263, 'SUPRIMOX PLUS CAPSULE 500MG,500 MG', 'CAPSULE', 'AMOXICILLIN TRIHYDRATE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1264, 'SURFACT-108MG 1 VIAL,108MG', 'VIALS', 'COLFOSCERIL PALMITATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1265, 'SUSTEN 100,100MG', 'CAPSULE', 'PROGESTERONE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1266, 'SUSTEN 200,200MG', 'CAPSULE', 'PROGESTERONE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1267, 'SUSTEN 300,300MG', 'CAPSULE', 'PROGESTERONE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1268, 'SUSTEN 400,400MG', 'CAPSULE', 'PROGESTERONE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1269, 'SUSTEN GEL 8.0%,8.0% W/W', 'SACHET', 'PROGESTERONE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1270, 'SYMBIVA 100 MCG OCTACAPS,100', 'DPI', 'FORMOTEROL FUMARATE DIHYDRATE , BUDESONIDE IP 100MCG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1271, 'SYMBIVA 200 MCG OCTACAPS,UA', 'DPI', 'FORMOTEROL FUMARATE DIHYDRATE , BUDESONIDE IP 200MCG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1272, 'SYMBIVA 400 MCG OCTACAPS,UA', 'DPI', 'FORMOTEROL FUMARATE DIHYDRATE , BUDESONIDE IP 400MCG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1273, 'SYNCAPONE 100,25MG,100MG, 200MG', 'TABLET', 'CARBIDOPA IP, LEVODOPA IP, ENTACAPONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1274, 'SYNCAPONE 150,37.5MG,150MG, 200MG', 'TABLET', 'CARBIDOPA IP, LEVODOPA IP, ENTACAPONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1275, 'SYNCAPONE 50,12.5MG,50MG, 200MG', 'TABLET', 'CARBIDOPA (ANHYDROUS) IP, LEVODOPA IP, ENTACAPONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1276, 'SYNDOPA 110,10MG', 'TABLET', 'LEVODOPA IP , CARBIDOPA BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1277, 'SYNDOPA 275,25MG', 'TABLET', 'LEVODOPA IP, CARBIDOPA BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1278, 'SYNDOPA CR 125,100MG, 25MG', 'TABLET', 'LEVODOPA IP, CARBIDOPA IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1279, 'SYNDOPA-CR,50MG', 'TABLET', 'LEVODOPA IP, CARBIDOPA BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1280, 'SYNDOPA-PLUS,25MG', 'TABLET', 'LEVODOPA IP, CARBIDOPA BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1281, 'SYNRIAM TABLET 150+750MG,150+750MG', 'TABLET', 'ARTEROLANE MALEATE 150MG , PIPERAQUINE PHOSPHATE 750M', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1282, 'TAMDURA,0.4MG, 0.5MG', 'TABLET', 'TAMSULOSIN HYDROCHLORIDE, DUTASTERIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1283, 'TAMFLO 0.4 [New Formulation],0.4MG', 'CAPSULE', 'TAMSULOSIN HYDROCHLORIDE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1284, 'TAMLET 2,2MG', 'CAPSULE', 'TAMSULOSIN HYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1285, 'TAMLET 4,0.4MG, 4MG', 'CAPSULE', 'TAMSULOSIN HYDROCHLORIDE, TOLTERODINE TARTRATE 4MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1286, 'TEAR DROPS,0.005% W/V', 'DROPS', 'CARBOXYMETHYLCELLULOSE SODIUM USP, STABILIZED OXYCHLORO', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1287, 'TECZINE AM CAPSULE,5 MG', 'CAPSULE', 'LEVOCETRIZINE DIHYDROCHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1288, 'TECZINE M KIDTABLET,2.5 MG +4 MG', 'KIDTABS', 'MONTELUKAST SODIUM IP ,LEVOCETIRIZINE HYDROCHLORIDE IP 2.5MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1289, 'TECZINE M TABLET,5 MG + 10MG', 'TABLET', 'MONTELUKAST SODIUM IP ,LEVOCETIRIZINE HYDROCHLORIDE IP 5MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1290, 'TECZINE SYRUP,30ML', 'SYRUP', 'LEVOCETRIZINE DIHYDROCHLORIDE I.P. 2.5 MG,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1291, 'TECZINE-10MG,10 MG', 'TABLET', 'LEVOCETRIZINE IP 10MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1292, 'TECZINE-5MG,5MG', 'TABLET', 'LEVOCETRIZINE 5MG TABS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1293, 'TELEACT 20MG TABLET,20 MG', 'TABLET', 'TELMISARTAN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1294, 'TELEACT 40MG TABLET,40 MG', 'TABLET', 'TELMISARTAN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1295, 'TELEACT 80MG,80 MG', 'TABLET', 'TELMISARTAN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1296, 'TELEACT ? 25MG,40MG + 25MG', 'CAPSULE', 'TELMISARTAN , METOPROLOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1297, 'TELEACT ? 50MG,40MG + 50MG', 'CAPSULE', 'TELMISARTAN , METOPROLOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1298, 'TELEACT AM 80 TABLET,80MG +5MG', 'TABLET', 'TELMISARTAN AND AMLODIPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1299, 'TELEACT AM TABLET,40MG + 5MG', 'TABLET', 'TELMISARTAN AMLODIPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1300, 'TELEACT CT 40MG +12.5MG,40MG +12.5MG', 'TABLET', 'TELMISARTAN CHLORTHALIDONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1301, 'TELEACT CT 80MG +12.5MG,80MG +12.5MG', 'TABLET', 'TELMISARTAN CHLORTHALIDONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1302, 'TELEACT CT LS 40MG +6.25MG,40MG +6.25MG', 'TABLET', 'TELMISARTAN CHLORTHALIDONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1303, 'TELEACT D 80,80MG + 12.5MG', 'TABLET', 'TELMISARTAN HYDROCHLOROTHIAZIDE COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1304, 'TELEACT D TABLET,40 MG', 'TABLET', 'TELMISARTAN HYDROCHLOROTHIAZIDE COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1305, 'TELEACT ST 20MG TABLET,20 MG+10 MG', 'TABLET', 'TELMISARTAN COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1306, 'TELEACT ST 40MG TABLET,40 MG+10 MG', 'TABLET', 'TELMISARTAN COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1307, 'TELEACT TRIO TABLET,40MG + 5MG + 12.5MG', 'TABLET', 'TELMISARTAN 40MG , AMLODIPINE 5MG , HYDROCHLORTHIAZIDE 12.5 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1308, 'TENTIDE EM TABLET,300 MG + 200 MG', 'TABLET', 'TENOFOVIR DISOPROXIL FUMARATE IP 300 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1309, 'TENTIDE TABLET,300 MG', 'TABLET', 'TENOFOVIR 300MG TABS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1310, 'TERLIBAX INJECTION,1 MG', 'INJECTION', 'TERLIPRESSIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1311, 'TEVRAN INJ 50MG,50 MG', 'INJECTION', 'TIGECYCLINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1312, 'THALOMA-100,100MG', 'CAPSULE', 'THALIDOMIDE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1313, 'THIOACT 4,4MG', 'CAPSULE', 'THIOCOCHICOSIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1314, 'THIOACT 8,8MG', 'CAPSULE', 'THIOCOCHICOSIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1315, 'THIOACT D4,4MG', 'CAPSULE', 'THIOCOLCHICOSIDE, DICLOFENAC SODIUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1316, 'THIOACT D8,8MG', 'CAPSULE', 'THIOCOCHICOSIDE, DICLOFENAC SODIUM IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1317, 'TICOVAN INJECTION 200 MG,200 MG', 'INJECTION', 'TEICOPLANIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1318, 'TICOVAN INJECTION 400 MG,400 MG', 'INJECTION', 'TEICOPLANIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1319, 'TIMOLET 0.5% W/V (NEW FORMULATION),5MG, 0.005% W/V', 'VIALS', 'TIMOLOL, STABILIZED OXYCHLORO COMPLEX', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1320, 'TIMOLET PLUS,20MG, 0.01% W/V', 'DROPS', 'TIMOLOL, PILOCARPINE NITRATE IP, BENZALKONIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1321, 'TIMOLET-GFS-3ML,0.005', 'VIALS', 'TIMOLOL MALEATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1322, 'TIZAN-2,2MG', 'TABLET', 'TIZANIDINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1323, 'TOBA-5ML,0.003', 'VIALS', 'TOBRAMYCIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1324, 'TOBA-F,3MG, 1MG', 'SUSPENSION', 'TOBRAMYCIN, FLUOROMETHOLONE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1325, 'TOPIROL-100,100MG', 'TABLET', 'TOPIRAMATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1326, 'TOPIROL-25,25MG', 'TABLET', 'TOPIRAMATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1327, 'TOPIROL-50,50MG', 'TABLET', 'TOPIRAMATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1328, 'TORIDE 10 MG TABLET,10 MG', 'TABLET', 'TORSEMIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1329, 'TORIDE 20 MG TABLET,20 MG', 'TABLET', 'TORSEMIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1330, 'TORLACTONE 10,10MG, 50MG', 'TABLET', 'TORSEMIDE USP, SPIRONOLACTONE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1331, 'TORLACTONE 5,5MG, 50MG', 'TABLET', 'TORSEMIDE USP, SPIRONOLACTONE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1332, 'TORLACTONE LS,10MG, 25MG', 'TABLET', 'TORSEMIDE, SPIRONOLACTONE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1333, 'TOZABACT INJECTION,4GM + 0.5 GM', 'INJECTION', 'PIPERACILLIN , TAZOBACTUM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1334, 'TRAPEX,1MG', 'TABLET', 'LORAZEPAM BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1335, 'TRAPEX 2,2MG', 'TABLET', 'LORAZEPAM BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1336, 'TRAPIC 500,500MG', 'TABLET', 'TRANEXAMIC ACID BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1337, 'TRAPIC E,250MG ,250 MG', 'TABLET', 'TRANEXAMIC ACID BP , ETAMSYLATE BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1338, 'TRAPIC MF,500MG, 250MG', 'TABLET', 'TRANEXAMIC ACID BP, MEFENAMIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1339, 'TRAZALON 25,25MG', 'TABLET', 'TRAZODONE HCL USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1340, 'TRAZALON 50,50MG', 'TABLET', 'TRAZODONE HCL USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1341, 'TRAZINE-H,2.5MG, 1MG', 'TABLET', 'TRIFLUOPERAZINE (AS HCL) , TRIHEXYPHENIDYL HCL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1342, 'TRAZINE-S,5MG, 2MG', 'TABLET', 'TRIFLUOPERAZINE IP, TRIHEXYPHENIDYL HCL USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1343, 'TRAZINE-SC,5MG, 2MG, 50MG', 'TABLET', 'TRIFLYOPERAZINE IP, TRIHEXYPHENIDYL HCL USP, CHLORPROMAZINE HCL IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1344, 'TRI OLVANCE 20MG TABLET,20MG+5+12.5', 'TABLET', 'OLMI, HCTZ,AMLO', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1345, 'TRI OLVANCE 40MG TABLET,40MG+5+12.5', 'TABLET', 'OLMI, HCTZ,AMLO', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1346, 'TRIGABANTIN 100,100MG,0.5MG, 100MG', 'TABLET', 'GABAPENTIN USP, MECOBALAMING, ALPHA LIPOIC ACID USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1347, 'TRIGABANTIN 300,300MG, 100MG', 'TABLET', 'GABAPENTIN, METHYLCOBALAMIN, ALPHA LIPOIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1348, 'TRILOPACE,50MG,5MG,12.5MG', 'TABLET', 'LOSARTAN POTASSIUM USP, AMLODIPINE, HYDROCHLOROTHIAZIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1349, 'TRIPHEN,2MG', 'TABLET', 'TRIHEXYPHENIDYL HYDROCHLORIDE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1350, 'TROPAN 2.5,2.5MG', 'TABLET', 'OXYBUTYNIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1351, 'TROPAN 5,5MG', 'TABLET', 'OXYBUTYNIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1352, 'TROPAN-XL 5,5MG', 'TABLET', 'OXYBUTYNIN CHLORIDE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1353, 'TROPEZ 60 MG,60 MG', 'TABLET', 'TROSPIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1354, 'TROPICAMET PLUS,8MG, 50MG, 0.01% W/V', 'DROPS', 'TROPICAMIDE IP, PHENYLEPHRINE HYDROCHLORIDE IP, BENZALKONIUM CHALORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1355, 'TROPICAMET-1%-5ML,0.01', 'VIALS', 'TROPICAMIDE USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1356, 'TUFPRO,5ML X10 BOTTLES', 'TABLET', 'BACILLUS CLAUSII SPORES', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1357, 'TYDOL 100 TABLET,100 MG', 'TABLET', 'TAPENTADOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1358, 'TYDOL 50 TABLET,50 MG', 'TABLET', 'TAPENTADOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1359, 'TYROGEF,250MG', 'TABLET', 'GEFITINIB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1360, 'UROTEL-XL 2,2MG', 'CAPSULE', 'TOLTERODINE TARTRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1361, 'UROTEL-XL 4,4MG', 'CAPSULE', 'TOLTERODINE TARTRATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1362, 'URSOCOL SR 450,450MG', 'CAPSULE', 'URSODEOXYCHOLIC ACID BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1363, 'URSOCOL SR 600,600MG', 'TABLET', 'URSODEOXYCHOLIC ACID BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1364, 'URSOCOL-150,150MG', 'TABLET', 'URSODEOXYCHOLIC ACID BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1365, 'URSOCOL-300,300MG', 'TABLET', 'URSODEOXYCHOLIC ACID BP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1366, 'UT FORTE,300 MG', 'CAPSULE', 'CRANBERRY EXTRACT, D-MANNOSE, HIBISCUS EXTRACT, CELLULOSE (CAPSULE SHELL), ANTI-CAKING AGENT (551), EMULSIFIER /STABILIZER (470)]', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1367, 'UTODIN,10MG', 'TABLET', 'RITRODINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1368, 'V-LETRA TABLET,200MG+50MG', 'TABLET', 'LOPINAVIR , RITONAVIR', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1369, 'VEBALONE TABLET. 150MG,150 MG', 'TABLET', 'IBANDRONATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1370, 'VENLA XR 150MG CAPS,150 MG', 'ER CAPSULE', 'VENLAFEXINE XR 150MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1371, 'VENLA XR 37.5MG CAPS,37.5MG', 'ER CAPSULE', 'VENLAFEXINE XR 37.5MG,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1372, 'VENLA XR 75MG CAPS,75 MG', 'ER CAPSULE', 'VENLAFEXINE XR 75MG,', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1373, 'VERNACE,500MG', 'TABLET', 'ACETYLL-CARNITINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1374, 'VIROCOMB - E KIT,150 MG + 300 MG + 600 MG', 'KIT', 'LAMIVUDINE,ZIDOVUDINE,EFAVIRENZ', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1375, 'VIROCOMB TABLET 150+300MG,150 MG + 300 MG', 'TABLET', 'LAMIVUDINE,ZIDOVUDIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1376, 'VIROCOMB-N TABLET,150 + 300 + 200 MG', 'TABLET', 'LAMIVUDINE,ZIDOVUDINE,NEVIRAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1377, 'VIROFOVIR 300MG + 300 MG TABLET,300MG + 300 MG', 'TABLET', 'LAMIVUDINE IP 300MG , TENOFOVIR DISOPROXIL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1378, 'VIROLANS TABLET 30MG,30 MG', 'TABLET', 'LAMIVUDINE,STAVUDINE,NEVIRAPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1379, 'VIROLIS TABLET 30MG,30 MG', 'TABLET', 'LAMIVUDINE,STAVUDINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1381, 'VIROTRENZ TABLET,300 MG+200 MG', 'TABLET', 'TENOFOVIR DISOPROXIL FUMARATE IP 300 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1382, 'VISCOMET 3ML,0.02', 'VIALS', 'HYDROXYPROPYL METHLCELLULOSE I.P', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1383, 'VISCOMET-PF-2ML,2ML', 'VIALS', 'VISCOMET, CANNULA', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1384, 'VOLIBO 0.2,0.2MG', 'TABLET', 'VOGLIBOSE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1385, 'VOLIBO 0.3,0.3MG', 'TABLET', 'VOGLIBOSE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1386, 'VOLITRA + GEL 30G TUBE,30 GM', 'GEL', 'DICLOFENAC COMB.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1387, 'VOLITRA MR TABLET,50 MG + 4 MG', 'MR TABLET', 'DICLOFENAC,THIO', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1388, 'VOLITRA PLUS SPRAY,55G', 'SPRAY', 'DICLOFENAC DIETHYLAMINE, LINSEED OIL, METHYL SALICYLATE, MENTHOL & EUCALYPTUS OIL TOPICAL SPRAY', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1389, 'VOLITRA S TABLET,50MG+10MG', 'TABLET', 'DICLOFENAC SODIUM IP 50 MG,SERRATIOPEPTIDASE 10 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1390, 'VOLIX INSTABLET 0.2 MG,0.2MG', 'TABLET', 'VOGLIBOSE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1391, 'VOLIX INSTABLET 0.3 MG,0.3 MG', 'TABLET', 'VOGLIBOSE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1392, 'VOLIX M 0.2,0.2+500MG', 'TABLET', 'VOGLIBOSE , METFORMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1393, 'VOLIX M 0.3,0.3+500MG', 'TABLET', 'VOGLIBOSE , METFORMIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1394, 'VOLIX TABLET 0.2 MG,0.2 MG', 'TABLET', 'VOGLIBOSE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1396, 'VOLIX TABLET 0.3 MG,0.3 MG', 'TABLET', 'VOGLIBOSE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1398, 'VOLIX TRIO 1,0.2MG+ 500MG + 1GM', 'TABLET', 'VOGLIBOSE , METFORMIN , GLIMEPRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1399, 'VOLIX TRIO 2,0.2MG+ 500MG + 2 GM', 'TABLET', 'VOGLIBOSE , METFORMIN , GLIMEPRIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1400, 'VOLIX TRIO FORTE 1MG,1MG+0.2+500MG', 'TABLET', 'VOGLIBOSE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1401, 'VOLIX TRIO FORTE 2MG,2MG+0.2+500MG', 'TABLET', 'VOGLIBOSE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1402, 'VORAZE,200MG', 'TABLET', 'VORICONAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1404, 'VORZU INJ 200MG SRSP,200 MG', 'INJECTION', 'VORICONAZOLE 200MG INJ.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1406, 'VSL#3', 'CAPSULE', 'BACTERIAL STRAINS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1407, 'WINOLAP,1MG, 0.02% W/V', 'DROPS', 'OLOPATADINE, BENZALKONIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1408, 'WINOLAP 5,5MG', 'TABLET', 'OLOPATADINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1409, 'WINOLAP DS,2MG, 0.02% W/V', 'DROPS', 'OLOPATADINE, BENZALKONIUM CHLORIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1410, 'WINOLAP NASAL SPRAY,0.6% W/V,0.02% W/V,', 'INHALER', 'OLOPATADINE, BENZALKONIUM CHLORIDE SOLUTION USP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1411, 'XABINE TABLET 500MG,500MG', 'TABLET', 'CAPECITABINE 500MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1412, 'XERINA CREAM,50 GM', 'CREAM', 'CETYLATED FATTY ACID , UREA , GLYCOLIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1413, 'XERINA LOTION,100ML', 'LOTION', 'CETYLATED FATTY ACID , UREA , GLYCOLIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1414, 'XPHIL NU,300 MCG', 'INJECTION', 'FILGRASTIM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1415, 'XPHIL Â® PFS,300 MCG', 'INJECTION - PFS', 'FILGRASTIM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1416, 'XPRAB INJ.,0.5 ML', 'INJECTION', 'ATTENUATED RABBIES VACCINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1417, 'XTRABAN 100 ML,100ML', 'INFUSION', 'TIROFIBAN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1418, 'XTRAGLO,40MG, 100MG', 'TABLET', 'BIOTIN, L-METHIONINE, L - CYSTEINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1419, 'XTROZ INJ. 1 GM.,1 GM', 'INJECTION', 'GEMCITABINE 1G LYO-INJN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1420, 'XTROZ INJ. 200MG,200 MG', 'INJECTION', 'GEMCITABINE 200MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1421, 'ZANOCIN DS 400MG TABLET,400 MG', 'TABLET', 'OFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1422, 'ZANOCIN EYE DROPS (FFS PACK),3MG/ML', 'EYE DROPS', 'OFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1423, 'ZANOCIN F,200 MG + 200 MG', 'TABLET', 'OFLOXACIN IP 200 MG,FLAVOXATE HYDROCHLORIDE BP 200 MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1424, 'ZANOCIN INFUSION,200 MG/100 ML', 'INFUSION', 'OFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1425, 'ZANOCIN LIQUID 100MG/5ML 60ML,100 MG/5ML', 'LIQUID', 'OFLOXACIN IP 100 MG.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1426, 'ZANOCIN LIQUID 50MG/5ML 60ML,50 MG/5ML', 'LIQUID', 'OFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1427, 'ZANOCIN TABLET 400 MG,400 MG', 'TABLET', 'OFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1428, 'ZANOCIN OZ I.V 1CB,200MG + 500MG', 'INJECTION', 'OFLOXACIN 200MG IV , ORNIDAZOLE 50MG IV', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1429, 'ZANOCIN OZ SUSPENSION 60ML,50MG+125MG', 'SUSPENSION', 'OFLOXACIN IP 50MG , ORNIDAZOLE 125MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1430, 'ZANOCIN OZ TABLET,200MG + 500MG', 'TABLET', 'OFLOXACIN 200 , ORNIDAZOLE 500MGÂ TABS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1431, 'ZANOCIN PLUS TABLET,200 MG + 200 MG', 'TABLET', 'ANHYDROUS CEFIXIME 200MG , OFLOXACIN IP 200MG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1432, 'ZANOCIN TABLET 100 MG,100 MG', 'TABLET', 'OFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1433, 'ZANOCIN TABLET 200 MG,200 MG', 'TABLET', 'OFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1434, 'ZANOCIN TZ TABLET,200 MG + 600 MG', 'TABLET', 'OFLOXACIN COMB', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1435, 'ZEALATA 400MG TABLET,400 MG', 'CAPSULE', 'IMATINIB 400MG CAPS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1436, 'ZEALATA CAPS 100MG,200 MG', 'CAPSULE', 'IMATINIB 100MG CAPS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1437, 'ZELGOR,250MG', 'TABLET', 'ABIRATERONE ACETATE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1438, 'ZEMPRED 16,16MG', 'TABLET', 'METHYLPREDNISOLONE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1439, 'ZEMPRED 4,4MG', 'TABLET', 'METHYLPREDNISOLONE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1440, 'ZEMPRED 8,8MG', 'TABLET', 'METHYLPREDNISOLONE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1441, 'ZENOTERE 120 MG,120 MG', 'INJECTION', 'DOCETAXEL ANHYDROUS 120 MG, POLYSORBATE 80 IP 1.0 ML', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1442, 'ZENOTERE 20 MG,20 MG', 'INJECTION', 'DOCETAXEL ANHYDROUS 20 MG, POLYSORBATE 80 IP 1.0 ML', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1443, 'ZENOTERE 80 MG,80 MG', 'INJECTION', 'DOCETAXEL ANHYDROUS 80 MG, POLYSORBATE 80 IP 1.0 ML', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1444, 'ZEPTOL 100,100MG', 'TABLET', 'CARBAMAZEPINE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1445, 'ZEPTOL 200,200MG', 'TABLET', 'CARBAMAZEPINE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1446, 'ZEPTOL-CR 200,200MG', 'TABLET', 'CARBAMAZEPINE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1447, 'ZEPTOL-CR 300,300MG', 'TABLET', 'CARBAMAZEPINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1448, 'ZEPTOL-CR 400,400MG', 'TABLET', 'CARBAMAZEPINE IP', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1449, 'ZIFEXIM TABLET,200MG + 200MG', 'TABLET', 'CEFIXIME , OFLOXACIN', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1450, 'ZIPSYDON-20,20MG', 'CAPSULE', 'ZIPRASIDONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1451, 'ZIPSYDON-40,40MG', 'CAPSULE', 'ZIPRASIDONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1452, 'ZIPSYDON-80,80MG', 'CAPSULE', 'ZIPRASIDONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1453, 'ZITOTEC-100,100 MCG', 'TABLET', 'MISOPROSTOL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1454, 'ZITOTEC-200,200 MCG', 'TABLET', 'MISOPROSTOL.', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1455, 'ZIVATOR INJ 1GM,1 GM', 'INJECTION', 'ERTAPENEM', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1456, 'ZOBONE,4MG', 'VIALS', 'ZOLEDRONIC ACID ANHYDROUS', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1457, 'ZOFER 4,4MG', 'TABLET', 'ONDANSETRON', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1458, 'ZOFER 8,8MG', 'TABLET', 'ONDANSETRON', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1459, 'ZOFER MD-4,4MG', 'TABLET', 'ONDANSETRON', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1460, 'ZOFER MD-8,8MG', 'TABLET', 'ONDANSETRON', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1461, 'ZOLE F SKIN LOTION 15ML,15 ML', 'LOTION', 'MICONAZOLE , FLUCINOLONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1462, 'ZOLE F SKIN OINTMENT 15GM,15 GM', 'OINTMENT', 'MICONAZOLE , FLUCINOLONE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1463, 'ZOLE SKIN OINTMENT 15GM,15 GM', 'OINTMENT', 'MICONAZOLE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1464, 'ZOLE-F NEO CREAM,2.0%W/W + 0.025%W/W + 0.5% W/W', 'CREAM', 'MICONAZOLE NITRATE , FLUOCINOLONE,NEOMYC', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1465, 'ZONISEP 100,100MG', 'CAPSULE', 'ZONISAMIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1466, 'ZONISEP 25,25MG', 'CAPSULE', 'ZONISAMIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1467, 'ZONISEP 50,50MG', 'CAPSULE', 'ZONISAMIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1468, 'ZOSERT 100,100MG', 'TABLET', 'SERTRALINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1469, 'ZOSERT 25,25 MG', 'TABLET', 'SERTRALINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1470, 'ZOSERT 50,50MG', 'TABLET', 'SERTRALINE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1471, 'ZOVAIR 160 INHALER 19ML,19ML', 'INHALER', 'CICLESONIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1472, 'ZOVAIR 160 OCTACAPS,UA', 'DPI', 'FORMOTEROL FUMARATE DIHYDRATE ,TIOTROPIUM BROMIDE MONOHYDRATE ,CICLESONIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1473, 'ZOVAIR 320 OCTACAPS,UA', 'DPI', 'FORMOTEROL FUMARATE DIHYDRATE ,TIOTROPIUM BROMIDE MONOHYDRATE ,CICLESONIDE', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1475, 'ZYRONA INJECTION 4MG,4 MG', 'INJECTION', 'ZOLENDRONIC ACID', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1519, 'Asthalin Respule via Nebulizer', 'Liquid', 'Salbutamol', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1520, 'Zifi 200', 'Tablet', 'Cefixime', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1521, 'Zifi 100 mg/5ml', 'Syrup', 'Cefixime', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1522, 'Zifi 50', 'Syrup', 'Cefixime', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1523, 'Crocin (120mg/5ml)', 'Suspension', 'Paracetamol', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1545, 'ATARAX 10 MG', 'Tablet', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (1546, 'ATARAX 25 MG', 'Tablet', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2725, 'Test Medication', 'Liquid', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2745, 'Mephataspas', 'Tablet', 'HG', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2746, 'Migraine Medicine', 'Tablet', 'Ingredient', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2747, 'test med', 'Gel', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2749, 'Test_med_27', 'Capsule', 'testactiveingredient', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2750, 'paracetamol', 'Drops', '500 mg', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2751, 'Crocin', 'Syrup', 'Ingredient xyz', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2752, 'Crocin 500 mg', 'Tablet', 'Paracetamol', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2753, 'Not Applicable', 'Syrup', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2754, 'Dolo 500 mg', 'Tablet', 'Paracetamol', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2756, 'para', 'Infusion', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2757, 'Fabiflue', 'Capsule', 'Immunity booster', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2758, 'mymed', 'Capsule', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2759, 'yumed', 'Capsule', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2760, 'Allegra', 'Capsule', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2761, 'Fabiflue', 'Tablet', 'ABC', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2762, 'Crocin Advance 500 mg', 'Tablet', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2763, 'Covifor', 'Injection - IM', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2764, 'Dipti Medicine 1', 'Capsule', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2765, 'Dipti Medicine 2', 'Ointment', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2766, 'Dipti Medicine 3', 'Tablet', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2767, 'Dipti Medicine 4', 'Drops', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2768, 'Rolipac', 'Dusting Powder', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2769, 'ROXACIN', 'Dusting Powder', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2770, 'Dipti Liquid', 'Liquid', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2771, 'Dipti Ointment', 'Ointment', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2772, 'Dipti Powder', 'Powder', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2773, 'Dipti Respules', 'Respules', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2774, 'Dipti Sachet', 'Sachet', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2775, 'Dipti Solution', 'Solution', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2776, 'Dipti Spray', 'Spray', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2777, 'Dipti Suspension', 'Suspension', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2778, 'Dipti Syrup', 'Syrup', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2779, 'Dipti Tablet', 'Tablet', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2780, 'Eno', 'Solution', 'ABV', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2781, 'meftaspas', 'Tablet', 'fg5', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');
INSERT INTO master.medicines VALUES (2782, 'NA', 'Tablet', 'NULL', '2022-07-15 20:14:32.611484', '2022-07-15 20:14:32.611484');


--
-- TOC entry 3787 (class 0 OID 117955)
-- Dependencies: 212
-- Data for Name: advice_details; Type: TABLE DATA; Schema: public; Owner: sysadmin
--



--
-- TOC entry 3777 (class 0 OID 117079)
-- Dependencies: 202
-- Data for Name: data_request_dtls; Type: TABLE DATA; Schema: public; Owner: sysadmin
--

INSERT INTO public.data_request_dtls VALUES ('308914f4-f812-432a-a634-33e60c7554e1', '', 'http://localhost:9091/hiu/health-information/transfer', '2022-07-18T05:56:33.537Z', '2022-08-02T05:56:33.538Z', 'ECDH', 'curve25519', '2022-08-17T05:56:33.537Z', 'Curve25519/32byte random key', 'Bg3J6wKHk2gjlzRTyFMfQF3gup3rPeHL3xg+p6RtRTI=', 'Br14qEk9o2qMxN3FaSca1KzjI0K147VplizqV72tRLY=', 'BGxGZze1vo7d22U0E8cNsrt3L1KmWdjZsNXatnA1P0uqG3vwRJtLv4xcKmNFQcRWvtNZBwbLB77Vtf/8omo7bqY=', NULL, true, '2022-07-18T05:56:25.787Z');
INSERT INTO public.data_request_dtls VALUES ('0743438c-19f2-4ab7-9a78-d466adc5e3e1', '', 'http://localhost:9091/hiu/health-information/transfer', '2022-07-18T06:18:00.896Z', '2022-08-02T06:18:00.896Z', 'ECDH', 'curve25519', '2022-08-17T06:18:00.895Z', 'Curve25519/32byte random key', 'IJ9zm1luka+oo7NTbJguuNgSDvLaYBMLH4CCTHlq/hQ=', 'D5HiVzJtkRUlqviFFrTvNOpTfDIPPkHwXrqCR88kj/Q=', 'BBIphZ4ll+fLCNSAKkv8mDRfqMWTAiee9JNgUVscbR09ciXmYsST2aVOgCOTPazJKyN/95M3DqOtRlNZzEnYa3M=', NULL, true, '2022-07-18T06:17:52.236Z');
INSERT INTO public.data_request_dtls VALUES ('7a8374f2-eed3-43f0-919b-5518f13422ec', '', 'http://localhost:9091/hiu/health-information/transfer', '2022-07-18T07:04:55.040Z', '2022-08-02T07:04:55.040Z', 'ECDH', 'curve25519', '2022-08-17T07:04:55.039Z', 'Curve25519/32byte random key', 'cK3KB3g05Sr/IcVteI/xf5NVmYgVHIqdj1/w6/Pa5/Y=', 'DemnoFNT/3+HkENPByGRsbX6rOyE/Np0nK5O4jyOszk=', 'BEARarkgCGlSt+tJKJAYKdcGeOnpPNV53R5mHFA3DsDWTJmbO5fa9Xcf5Zk8smu0nvGjMjVTgEtwOpPNxcOvaIk=', NULL, true, '2022-07-18T07:04:16.310Z');
INSERT INTO public.data_request_dtls VALUES ('65c0b76b-3935-4ad8-9da1-b46b4f589103', '', 'http://localhost:9091/hiu/health-information/transfer', '2022-07-18T08:22:22.766Z', '2022-08-02T08:22:22.766Z', 'ECDH', 'curve25519', '2022-08-17T08:22:22.766Z', 'Curve25519/32byte random key', 'oQx97p69/Ml/1Xwyw58AI+ZX8373nnpjWEwobC7qPeU=', 'BKzOucvbW6AjUZBUrNhe8a8CxW1NgIIbrMmPR3fs4Ag=', 'BFBAnoj1QYwzbcV2n5xIrtMj2zs0Td3P/IM8RaxztwJDQa8A8ImmlclZI4WSyH7wmjzcYLxVff9fN4XbwITvIis=', NULL, true, '2022-07-18T08:22:20.316Z');
INSERT INTO public.data_request_dtls VALUES ('58b11a6a-5fb2-4600-bf75-8ef1147c160b', '', 'http://localhost:9091/hiu/health-information/transfer', '2022-07-18T09:20:18.565Z', '2022-08-02T09:20:18.565Z', 'ECDH', 'curve25519', '2022-08-17T09:20:18.565Z', 'Curve25519/32byte random key', 'r0Vy2N6Nvwe/ao+REVOXzpHLJWwMu9hsP4bJq7tSnRc=', 'CC9gGwRAD60FrWlcPdSBmH2Zkyi2oVVwr/52f4r00Gs=', 'BD15h0/nRNHOYfj8yWhM339B4cilmKeNL5dQ5zNuGIFyRYGUgAPThlPSAv52S1TjOm2etbXRrRaawof0natVos8=', NULL, true, '2022-07-18T09:20:08.583Z');


--
-- TOC entry 3778 (class 0 OID 117088)
-- Dependencies: 203
-- Data for Name: data_transfer_dtls; Type: TABLE DATA; Schema: public; Owner: sysadmin
--



--
-- TOC entry 3788 (class 0 OID 117960)
-- Dependencies: 213
-- Data for Name: diagnosis_details; Type: TABLE DATA; Schema: public; Owner: sysadmin
--



--
-- TOC entry 3785 (class 0 OID 117945)
-- Dependencies: 210
-- Data for Name: hip_data_dtls; Type: TABLE DATA; Schema: public; Owner: sysadmin
--

INSERT INTO public.hip_data_dtls VALUES (19, '{"labName":"DR LAL PATH LABS","transactionId":"a1s2c932-2f70-3ds3-a3b5-2sfd46b12a18d","entries":[{"timestamp":null,"appointmentId":null,"content":"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","media":"application/fhir+json"}],"keyMaterial":{"cryptoAlg":"ECDH","curve":"Curve25519","dhPublicKey":{"expiry":"2022-08-17T03:53:44.593Z","parameters":"Curve25519/32byte random key","keyValue":"MIIBMTCB6gYHKoZIzj0CATCB3gIBATArBgcqhkjOPQEBAiB/////////////////////////////////////////7TBEBCAqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqYSRShRAQge0Je0Je0Je0Je0Je0Je0Je0Je0Je0Je0JgtenHcQyGQEQQQqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq0kWiCuGaG4oIa04B7dLHdI0UySPU1+bXxhsinpxaJ+ztPZAiAQAAAAAAAAAAAAAAAAAAAAFN753qL3nNZYEmMaXPXT7QIBCANCAARHT2d7FhUl1NYrBm5AU/IpHFMUWsIjZcTJ644q2jVj6FwcPr8gUmQ7qakyEHmUazlfHEEp3cl3zJ6aU0H5K5xC"},"nonce":"vp+hLcb0hdA0SXe7vN04HGlw5BoLL37/saNAcyG413c="}}', 'DR LAL PATH LABS', NULL);
INSERT INTO public.hip_data_dtls VALUES (31, '{"labName":"DR LAL PATH LABS","transactionId":"65c0b76b-3935-4ad8-9da1-b46b4f589103","entries":[{"timestamp":null,"appointmentId":null,"content":"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","media":"application/fhir+json"}],"keyMaterial":{"cryptoAlg":"ECDH","curve":"curve25519","dhPublicKey":{"expiry":"2022-08-17T08:22:43.481Z","parameters":"Curve25519/32byte random key","keyValue":"MIIBMTCB6gYHKoZIzj0CATCB3gIBATArBgcqhkjOPQEBAiB/////////////////////////////////////////7TBEBCAqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqYSRShRAQge0Je0Je0Je0Je0Je0Je0Je0Je0Je0Je0JgtenHcQyGQEQQQqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq0kWiCuGaG4oIa04B7dLHdI0UySPU1+bXxhsinpxaJ+ztPZAiAQAAAAAAAAAAAAAAAAAAAAFN753qL3nNZYEmMaXPXT7QIBCANCAAQ7KZpB4aZRvekbxY5zlQ0RJoelY1xAAAZWrEn3VlOb3gQTtZ1AVC5ScfuhzVrAMSGqiz4OECe2yk2HTFbs9LE+"},"nonce":"Q4vMxXi163NyIkzxGRQ4/hC3U8DmQtXr7mnYmtQv9Yk="}}', 'DR LAL PATH LABS', '65c0b76b-3935-4ad8-9da1-b46b4f589103');
INSERT INTO public.hip_data_dtls VALUES (35, '{"labName":"DR LAL PATH LABS","transactionId":"58b11a6a-5fb2-4600-bf75-8ef1147c160b","entries":[{"timestamp":null,"appointmentId":null,"content":"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","media":"application/fhir+json"}],"keyMaterial":{"cryptoAlg":"ECDH","curve":"curve25519","dhPublicKey":{"expiry":"2022-08-17T09:21:32.932Z","parameters":"Curve25519/32byte random key","keyValue":"MIIBMTCB6gYHKoZIzj0CATCB3gIBATArBgcqhkjOPQEBAiB/////////////////////////////////////////7TBEBCAqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqYSRShRAQge0Je0Je0Je0Je0Je0Je0Je0Je0Je0Je0JgtenHcQyGQEQQQqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq0kWiCuGaG4oIa04B7dLHdI0UySPU1+bXxhsinpxaJ+ztPZAiAQAAAAAAAAAAAAAAAAAAAAFN753qL3nNZYEmMaXPXT7QIBCANCAAQnxW+ZU1Nk+7Z22Yw2/LAeuh7Tf6drxSkYNXs9p3obYQr64zC6QkRMpilzB2uhE9Qude5sxh/hdrPOHasa2LhU"},"nonce":"gKfxPr5J9sTLoZEtRgme+H5uIaroLv7LbhzP+iiZNAk="}}', 'DR LAL PATH LABS', '58b11a6a-5fb2-4600-bf75-8ef1147c160b');


--
-- TOC entry 3782 (class 0 OID 117584)
-- Dependencies: 207
-- Data for Name: hip_request_dtls; Type: TABLE DATA; Schema: public; Owner: sysadmin
--

INSERT INTO public.hip_request_dtls VALUES ('a1s2c932-2f70-3ds3-a3b5-2sfd46b12a18d', '2022', 'https://uat.protean-health.com/hackathon/hiu/health-information/transfer', '2022-06-09T06:26', '2022-06-09T06:26', 'ECDH', 'Curve25519', '2022-06-09T06:26', 'Curve25519/32byte random key', NULL, 'R0hP7CO+BafvhiZrqeEOl8OnX57syGKlUw+GM5OPGq8=', 'A3LswGH0lVpgaQaUpFZhMgW4hWthNTPboMNbwOi1fUJi', '2022-06-09T06:26', 'DR LAL PATH LABS');
INSERT INTO public.hip_request_dtls VALUES ('308914f4-f812-432a-a634-33e60c7554e1', '', 'http://localhost:9091/hiu/health-information/transfer', '2022-07-18T05:56:33.537Z', '2022-08-02T05:56:33.538Z', 'ECDH', 'curve25519', '2022-08-17T05:56:33.537Z', 'Curve25519/32byte random key', NULL, 'Bg3J6wKHk2gjlzRTyFMfQF3gup3rPeHL3xg+p6RtRTI=', 'BGxGZze1vo7d22U0E8cNsrt3L1KmWdjZsNXatnA1P0uqG3vwRJtLv4xcKmNFQcRWvtNZBwbLB77Vtf/8omo7bqY=', '2022-07-18T05:56:25.787Z', 'DR LAL PATH LABS');
INSERT INTO public.hip_request_dtls VALUES ('0743438c-19f2-4ab7-9a78-d466adc5e3e1', '', 'http://localhost:9091/hiu/health-information/transfer', '2022-07-18T06:18:00.896Z', '2022-08-02T06:18:00.896Z', 'ECDH', 'curve25519', '2022-08-17T06:18:00.895Z', 'Curve25519/32byte random key', NULL, 'IJ9zm1luka+oo7NTbJguuNgSDvLaYBMLH4CCTHlq/hQ=', 'BBIphZ4ll+fLCNSAKkv8mDRfqMWTAiee9JNgUVscbR09ciXmYsST2aVOgCOTPazJKyN/95M3DqOtRlNZzEnYa3M=', '2022-07-18T06:17:52.236Z', 'DR LAL PATH LABS');
INSERT INTO public.hip_request_dtls VALUES ('7a8374f2-eed3-43f0-919b-5518f13422ec', '', 'http://localhost:9091/hiu/health-information/transfer', '2022-07-18T07:04:55.040Z', '2022-08-02T07:04:55.040Z', 'ECDH', 'curve25519', '2022-08-17T07:04:55.039Z', 'Curve25519/32byte random key', NULL, 'cK3KB3g05Sr/IcVteI/xf5NVmYgVHIqdj1/w6/Pa5/Y=', 'BEARarkgCGlSt+tJKJAYKdcGeOnpPNV53R5mHFA3DsDWTJmbO5fa9Xcf5Zk8smu0nvGjMjVTgEtwOpPNxcOvaIk=', '2022-07-18T07:04:16.310Z', 'DR LAL PATH LABS');
INSERT INTO public.hip_request_dtls VALUES ('65c0b76b-3935-4ad8-9da1-b46b4f589103', '', 'http://localhost:9091/hiu/health-information/transfer', '2022-07-18T08:22:22.766Z', '2022-08-02T08:22:22.766Z', 'ECDH', 'curve25519', '2022-08-17T08:22:22.766Z', 'Curve25519/32byte random key', NULL, 'oQx97p69/Ml/1Xwyw58AI+ZX8373nnpjWEwobC7qPeU=', 'BFBAnoj1QYwzbcV2n5xIrtMj2zs0Td3P/IM8RaxztwJDQa8A8ImmlclZI4WSyH7wmjzcYLxVff9fN4XbwITvIis=', '2022-07-18T08:22:20.316Z', 'DR LAL PATH LABS');
INSERT INTO public.hip_request_dtls VALUES ('58b11a6a-5fb2-4600-bf75-8ef1147c160b', '', 'http://localhost:9091/hiu/health-information/transfer', '2022-07-18T09:20:18.565Z', '2022-08-02T09:20:18.565Z', 'ECDH', 'curve25519', '2022-08-17T09:20:18.565Z', 'Curve25519/32byte random key', NULL, 'r0Vy2N6Nvwe/ao+REVOXzpHLJWwMu9hsP4bJq7tSnRc=', 'BD15h0/nRNHOYfj8yWhM339B4cilmKeNL5dQ5zNuGIFyRYGUgAPThlPSAv52S1TjOm2etbXRrRaawof0natVos8=', '2022-07-18T09:20:08.583Z', 'DR LAL PATH LABS');


--
-- TOC entry 3789 (class 0 OID 117965)
-- Dependencies: 214
-- Data for Name: medicines_details; Type: TABLE DATA; Schema: public; Owner: sysadmin
--



--
-- TOC entry 3774 (class 0 OID 116726)
-- Dependencies: 199
-- Data for Name: patient_dtls; Type: TABLE DATA; Schema: public; Owner: sysadmin
--

INSERT INTO public.patient_dtls VALUES (1, 'DOCTOR1', 'PATIENT1', '8698434573', 'patient1@gmail.com', 2022071512, 'O+ve', 101, 20, 'Male', '2017-07-10', 'patient1@sbx', '73-3351-1476-1672');
INSERT INTO public.patient_dtls VALUES (2, 'DOCTOR1', 'PATIENT2', '9769425708', 'patient1@gmail.com', 2022071513, 'AB+ve', 102, 21, 'Female', '2017-07-13', 'patient2@sbx', '73-3351-1476-1673');
INSERT INTO public.patient_dtls VALUES (3, 'DOCTOR1', 'PATIENT3', '9970952295', 'patient3@gmail.com', 2022071613, 'A+ve', 103, 22, 'Male', '2017-07-15', 'patient3@sbx', '73-3351-1476-1674');


--
-- TOC entry 3784 (class 0 OID 117608)
-- Dependencies: 209
-- Data for Name: patient_report_dtls; Type: TABLE DATA; Schema: public; Owner: sysadmin
--

INSERT INTO public.patient_report_dtls VALUES (1, 'DOCTOR1', 'PATIENT1', 'Blood Report', '/var/telemedicine/documents/prescription/Blood_Report.pdf', '2022-07-16 20:57:28.489811');
INSERT INTO public.patient_report_dtls VALUES (4, 'DOCTOR1', 'PATIENT2', 'Blood Report', '/var/telemedicine/documents/prescription/Blood_Report.pdf', '2022-07-16 21:36:13.492985');
INSERT INTO public.patient_report_dtls VALUES (7, 'DOCTOR1', 'PATIENT3', 'Blood Report', '/var/telemedicine/documents/prescription/Blood_Report.pdf', '2022-07-16 21:38:07.95985');
INSERT INTO public.patient_report_dtls VALUES (2, 'DOCTOR1', 'PATIENT1', 'Diagnostic Report', '/var/telemedicine/documents/prescription/Diagnostic_Report.pdf', '2022-07-16 21:32:30.211304');
INSERT INTO public.patient_report_dtls VALUES (5, 'DOCTOR1', 'PATIENT2', 'Diagnostic Report', '/var/telemedicine/documents/prescription/Diagnostic_Report.pdf', '2022-07-16 21:36:13.492985');
INSERT INTO public.patient_report_dtls VALUES (8, 'DOCTOR1', 'PATIENT3', 'Diagnostic Report', '/var/telemedicine/documents/prescription/Diagnostic_Report.pdf', '2022-07-16 21:38:07.95985');
INSERT INTO public.patient_report_dtls VALUES (3, 'DOCTOR1', 'PATIENT1', 'ECG Report', '/var/telemedicine/documents/prescription/ECG_Report.pdf', '2022-07-16 21:32:30.211304');
INSERT INTO public.patient_report_dtls VALUES (6, 'DOCTOR1', 'PATIENT2', 'ECG Report', '/var/telemedicine/documents/prescription/ECG_Report.pdf', '2022-07-16 21:36:13.492985');
INSERT INTO public.patient_report_dtls VALUES (9, 'DOCTOR1', 'PATIENT3', 'ECG Report', '/var/telemedicine/documents/prescription/ECG_Report.pdf', '2022-07-16 21:38:07.95985');


--
-- TOC entry 3781 (class 0 OID 117571)
-- Dependencies: 206
-- Data for Name: priscription_dtls; Type: TABLE DATA; Schema: public; Owner: sysadmin
--

INSERT INTO public.priscription_dtls VALUES (1, 'DOCTOR1', 'PATIENT1', 'Fever, Sleep problems', 'Viral bronchitis, Herpangina', 'Crocin can be repeated every four hours., Avoid outside uncooked food items.', 100, 65, 10, '/var/telemedicine/documents/prescription/202207161845_DOCTOR1_PATIENT1.pdf', 1234, 'Crocin 500 mg       (0-0-0-0) x ( day/s)

Asthalin Respule       (0-0-0-0) x ( day/s)

', NULL, NULL, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (7, 'DOCTOR1', 'PATIENT1', 'Test diet', 'Dietetic enteritis of intestine', NULL, 3, 3, 3, NULL, 123, 'Crocin 500 mg', 3, 3, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (8, 'DOCTOR1', 'PATIENT1', 'Test diet', 'Dietetic enteritis of intestine', 'Asthalin Nebulizer to be given every six hours at  6 am, 12 Noon, 6 pm, and 12 Midnight.', 3, 3, 3, NULL, 32323, 'Crocin 500 mg', 3, 3, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (9, 'DOCTOR1', 'PATIENT3', 'Fever, Sleep problems', 'Viral bronchitis, Herpangina', 'Crocin can be repeated every four hours., Avoid outside uncooked food items.', 100, 65, 10, NULL, 1234865, 'Crocin 500 mg       (0-0-0-0) x ( day/s)

Asthalin Respule       (0-0-0-0) x ( day/s)

', NULL, NULL, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (10, 'DOCTOR1', 'PATIENT1', 'Fever defervescence', 'Deferred diagnosis on Axis I', 'Give boiled and cooled water.', 100, 77, 33, NULL, 1658048281075, 'Asthalin Respule', 70, 110, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (11, 'DOCTOR1', 'PATIENT1', 'Headache', 'Headache due to high altitude', 'Avoid junk food.', 98, 100, 80, NULL, 1658049191083, 'Darolac', 90, 120, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (12, 'DOCTOR1', 'PATIENT1', 'Testis normal', '', '', 3, 3, 33, NULL, 1658049744765, '', 3, 3, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (26, 'DOCTOR1', 'PATIENT1', 'Fever', 'Post vaccination fever', 'Avoid spicy and sour items.', 100, 76, 76, NULL, 1658131449617, 'Asthalin Respule', 57, 246, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (14, 'DOCTOR1', 'PATIENT1', 'Test diet', 'Dietetic enteritis of intestine', '', 3, 3, 3, '/var/telemedicine/documents/prescription/202207171547_DOCTOR1_PATIENT1.pdf', 1658053024746, '', 3, 3, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (15, 'DOCTOR1', 'PATIENT1', 'Test diet', 'Dietetic enteritis of intestine', '', 3, 3, 3, '/var/telemedicine/documents/prescription/202207171547_DOCTOR1_PATIENT1.pdf', 1658053073353, '', 3, 3, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (16, 'DOCTOR1', 'PATIENT1', 'Test diet', 'Dietetic enteritis of intestine', '', 3, 3, 3, '/var/telemedicine/documents/prescription/202207171548_DOCTOR1_PATIENT1.pdf', 1658053127940, '', 3, 3, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (17, 'DOCTOR1', 'PATIENT1', 'Fever', 'Fort Bragg Fever', 'Crocin can be repeated every four hours.', 3, 3, 12, '/var/telemedicine/documents/prescription/202207171634_DOCTOR1_PATIENT1.pdf', 1658055842673, 'Asthalin Respule', 23, 3, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (27, 'DOCTOR1', 'PATIENT1', 'Fever', 'Fever of newborn', 'Crocin can be repeated every four hours.', 98, 100, NULL, NULL, 1658131498681, 'Crocin 500 mg', 65, 95, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (28, 'DOCTOR1', 'PATIENT1', 'Fever', 'Fever of newborn', 'Crocin can be repeated every four hours.', 98, 100, NULL, NULL, 1658131511324, 'Crocin 500 mg', 65, 95, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (29, 'DOCTOR1', 'PATIENT1', 'Fever', 'Fever of newborn', 'Give boiled and cooled water.', 100, 86, 76, '/var/telemedicine/documents/prescription/202207181347_DOCTOR1_PATIENT1.pdf', 1658132266742, 'Asthalin Respule', 34, 150, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (20, 'DOCTOR1', 'PATIENT1', 'Fever', 'Fort Bragg Fever', 'Asthalin Nebulizer to be given every six hours at  6 am, 12 Noon, 6 pm, and 12 Midnight.', 96, 66, 78, '/var/telemedicine/documents/prescription/202207181127_DOCTOR1_PATIENT1.pdf', 1658123835937, 'Asthalin Respule', 77, 80, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (37, 'DOCTOR1', 'PATIENT1', 'Fever', 'Trench fever', 'Give plenty of oral fluids.', 100, 88, 87, '/var/telemedicine/documents/prescription/202207181503_DOCTOR1_PATIENT1.pdf', 1658136829632, 'Azilide DT', 76, 135, NULL, '/var/telemedicine/documents/prescription/OPConsultNote_21617801.json');
INSERT INTO public.priscription_dtls VALUES (22, 'DOCTOR1', 'PATIENT2', 'Fever, Sleep problems', 'Viral bronchitis, Herpangina', 'Crocin can be repeated every four hours., Avoid outside uncooked food items.', 100, 65, 10, NULL, 1234567890123, 'Crocin 500 mg       (0-0-0-0) x ( day/s)

Asthalin Respule       (0-0-0-0) x ( day/s)

', 100, 50, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (23, 'DOCTOR1', 'PATIENT1', 'Fever', 'Trench fever', 'Asthalin Nebulizer to be given every six hours at  6 am, 12 Noon, 6 pm, and 12 Midnight.', 99, 36, 56, NULL, 1658126479704, 'Maxtra Tab', 43, 137, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (24, 'DOCTOR1', 'PATIENT1', 'Fever', 'Trench fever', 'Asthalin Nebulizer to be given every six hours at  6 am, 12 Noon, 6 pm, and 12 Midnight.', 99, 36, 56, NULL, 1658126477704, 'Maxtra Tab', 43, 137, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (25, 'DOCTOR1', 'PATIENT1', 'Fever', 'Fever caused by SARS-CoV-2', 'Asthalin Nebulizer to be given every six hours at  6 am, 12 Noon, 6 pm, and 12 Midnight.', 100, 76, 54, '/var/telemedicine/documents/prescription/202207181255_DOCTOR1_PATIENT1.pdf', 1658129151606, 'Asthalin Respule', 35, 35, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (30, 'DOCTOR1', 'PATIENT1', 'Fever', 'Fever of newborn', 'Crocin can be repeated every four hours.', NULL, NULL, NULL, '/var/telemedicine/documents/prescription/202207181353_DOCTOR1_PATIENT1.pdf', 1658132565165, 'Crocin 500 mg', NULL, NULL, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (32, 'DOCTOR1', 'PATIENT1', 'Fever', 'Trench fever', 'Avoid outside uncooked food items.', 100, 33, 45, '/var/telemedicine/documents/prescription/202207181406_DOCTOR1_PATIENT1.pdf', 1658133399877, 'Crocin 500 mg', 45, 234, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (34, 'DOCTOR1', 'PATIENT1', 'Fever', 'Fever caused by SARS-CoV-2', 'Asthalin Nebulizer to be given every six hours at  6 am, 12 Noon, 6 pm, and 12 Midnight.', 100, 54, 44, NULL, 1658135662434, 'Crocin 500 mg', 44, 43, NULL, '/var/telemedicine/documents/prescription/OPConsultNote_20990257.json');
INSERT INTO public.priscription_dtls VALUES (33, 'DOCTOR1', 'PATIENT1', 'Fever', 'Post vaccination fever', 'Give plenty of oral fluids.', 100, 67, 88, '/var/telemedicine/documents/prescription/202207181415_DOCTOR1_PATIENT1.pdf', 1658133908896, 'Darolac', 56, 160, NULL, NULL);
INSERT INTO public.priscription_dtls VALUES (13, 'DOCTOR1', 'PATIENT1', 'Test diet', 'Dietetic enteritis of intestine', '', 3, 3, 3, '/var/telemedicine/documents/prescription/202207171527_DOCTOR1_PATIENT1.pdf', 1658051774073, '', 3, 3, NULL, '/var/telemedicine/documents/prescription/OPConsultNote_52894614.json');
INSERT INTO public.priscription_dtls VALUES (36, 'DOCTOR1', 'PATIENT1', 'Fever', 'Fever of newborn', 'Crocin can be repeated every four hours.', 98, 100, 120, '/var/telemedicine/documents/prescription/202207181455_DOCTOR1_PATIENT1.pdf', 1658136293945, 'Crocin 500 mg,Maxtra Tab', 65, 95, NULL, '/var/telemedicine/documents/prescription/OPConsultNote_18425101.json');
INSERT INTO public.priscription_dtls VALUES (38, 'DOCTOR1', 'PATIENT1', 'Fever', 'Fever of newborn', 'Crocin can be repeated every four hours.', 98, 100, 120, '/var/telemedicine/documents/prescription/202207181509_DOCTOR1_PATIENT1.pdf', 1658137119102, 'Crocin 500 mg,Maxtra Tab', 65, 96, NULL, '/var/telemedicine/documents/prescription/OPConsultNote_12979461.json');


--
-- TOC entry 3790 (class 0 OID 118346)
-- Dependencies: 215
-- Data for Name: report_dtls; Type: TABLE DATA; Schema: public; Owner: sysadmin
--

INSERT INTO public.report_dtls VALUES ('DR LAL PATH LABS', 'abc@sbx', '17-8630-6136-7272', '2022051279', 'dr1@gmail.com', 'Dr101', 'MCI1', '9991112222', 'John', 'SMC1', 'Eye', 'Male', '1991-01-01', 'PAT01', '8881112222', 'Patient1');
INSERT INTO public.report_dtls VALUES ('SRL DIAGNOSTICS', 'pqr@sbx', '16-7630-5136-1272', '2021072312', 'dr2@gmail.com', 'Dr102', 'MCI2', '9997776666', 'Maria', 'SMC2', 'Pychologist', 'Female', '1993-03-01', 'PAT02', '9991116666', 'Patient2');
INSERT INTO public.report_dtls VALUES ('METROPOLIS', 'def@sbx', '18-9630-8136-3272', '2021020256', 'dr3@gmail.com', 'Dr103', 'MCI3', '9998883333', 'Steve', 'SMC3', 'Heart', 'Male', '1992-02-01', 'PAT03', '9995553333', 'Patient3');


--
-- TOC entry 3799 (class 0 OID 0)
-- Dependencies: 197
-- Name: advice_seq; Type: SEQUENCE SET; Schema: master; Owner: sysadmin
--

SELECT pg_catalog.setval('master.advice_seq', 1, false);


--
-- TOC entry 3800 (class 0 OID 0)
-- Dependencies: 204
-- Name: consultation_ruling_engine_seq; Type: SEQUENCE SET; Schema: master; Owner: sysadmin
--

SELECT pg_catalog.setval('master.consultation_ruling_engine_seq', 1, false);


--
-- TOC entry 3801 (class 0 OID 0)
-- Dependencies: 211
-- Name: consultation_ruling_engine_sequence; Type: SEQUENCE SET; Schema: master; Owner: sysadmin
--

SELECT pg_catalog.setval('master.consultation_ruling_engine_sequence', 3, true);


--
-- TOC entry 3802 (class 0 OID 0)
-- Dependencies: 200
-- Name: medicines_seq; Type: SEQUENCE SET; Schema: master; Owner: sysadmin
--

SELECT pg_catalog.setval('master.medicines_seq', 1, false);


--
-- TOC entry 3803 (class 0 OID 0)
-- Dependencies: 208
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: sysadmin
--

SELECT pg_catalog.setval('public.hibernate_sequence', 38, true);


--
-- TOC entry 3624 (class 2606 OID 117999)
-- Name: advice advice_pkey; Type: CONSTRAINT; Schema: master; Owner: sysadmin
--

ALTER TABLE ONLY master.advice
    ADD CONSTRAINT advice_pkey PRIMARY KEY (id);


--
-- TOC entry 3634 (class 2606 OID 117979)
-- Name: consultation_ruling_engine consultation_ruling_engine_pkey; Type: CONSTRAINT; Schema: master; Owner: sysadmin
--

ALTER TABLE ONLY master.consultation_ruling_engine
    ADD CONSTRAINT consultation_ruling_engine_pkey PRIMARY KEY (id);


--
-- TOC entry 3628 (class 2606 OID 117989)
-- Name: medicines medicines_pkey; Type: CONSTRAINT; Schema: master; Owner: sysadmin
--

ALTER TABLE ONLY master.medicines
    ADD CONSTRAINT medicines_pkey PRIMARY KEY (id);


--
-- TOC entry 3644 (class 2606 OID 117959)
-- Name: advice_details advice_details_pkey; Type: CONSTRAINT; Schema: public; Owner: sysadmin
--

ALTER TABLE ONLY public.advice_details
    ADD CONSTRAINT advice_details_pkey PRIMARY KEY (advice_id);


--
-- TOC entry 3630 (class 2606 OID 117087)
-- Name: data_request_dtls data_request_dtls_pkey; Type: CONSTRAINT; Schema: public; Owner: sysadmin
--

ALTER TABLE ONLY public.data_request_dtls
    ADD CONSTRAINT data_request_dtls_pkey PRIMARY KEY (transaction_id);


--
-- TOC entry 3632 (class 2606 OID 117096)
-- Name: data_transfer_dtls data_transfer_dtls_pkey; Type: CONSTRAINT; Schema: public; Owner: sysadmin
--

ALTER TABLE ONLY public.data_transfer_dtls
    ADD CONSTRAINT data_transfer_dtls_pkey PRIMARY KEY (id);


--
-- TOC entry 3646 (class 2606 OID 117964)
-- Name: diagnosis_details diagnosis_details_pkey; Type: CONSTRAINT; Schema: public; Owner: sysadmin
--

ALTER TABLE ONLY public.diagnosis_details
    ADD CONSTRAINT diagnosis_details_pkey PRIMARY KEY (diagnosis_id);


--
-- TOC entry 3642 (class 2606 OID 117952)
-- Name: hip_data_dtls hip_data_dtls_pkey; Type: CONSTRAINT; Schema: public; Owner: sysadmin
--

ALTER TABLE ONLY public.hip_data_dtls
    ADD CONSTRAINT hip_data_dtls_pkey PRIMARY KEY (id);


--
-- TOC entry 3638 (class 2606 OID 117591)
-- Name: hip_request_dtls hip_request_dtls_pkey; Type: CONSTRAINT; Schema: public; Owner: sysadmin
--

ALTER TABLE ONLY public.hip_request_dtls
    ADD CONSTRAINT hip_request_dtls_pkey PRIMARY KEY (transaction_id);


--
-- TOC entry 3648 (class 2606 OID 117969)
-- Name: medicines_details medicines_details_pkey; Type: CONSTRAINT; Schema: public; Owner: sysadmin
--

ALTER TABLE ONLY public.medicines_details
    ADD CONSTRAINT medicines_details_pkey PRIMARY KEY (medicine_id);


--
-- TOC entry 3626 (class 2606 OID 116733)
-- Name: patient_dtls patient_dtls_pkey; Type: CONSTRAINT; Schema: public; Owner: sysadmin
--

ALTER TABLE ONLY public.patient_dtls
    ADD CONSTRAINT patient_dtls_pkey PRIMARY KEY (pd_id_pk);


--
-- TOC entry 3640 (class 2606 OID 117615)
-- Name: patient_report_dtls patient_report_dtls_pkey; Type: CONSTRAINT; Schema: public; Owner: sysadmin
--

ALTER TABLE ONLY public.patient_report_dtls
    ADD CONSTRAINT patient_report_dtls_pkey PRIMARY KEY (prd_id_pk);


--
-- TOC entry 3636 (class 2606 OID 117578)
-- Name: priscription_dtls priscription_dtls_pkey; Type: CONSTRAINT; Schema: public; Owner: sysadmin
--

ALTER TABLE ONLY public.priscription_dtls
    ADD CONSTRAINT priscription_dtls_pkey PRIMARY KEY (pd_id_pk);


--
-- TOC entry 3650 (class 2606 OID 118353)
-- Name: report_dtls report_dtls_pkey; Type: CONSTRAINT; Schema: public; Owner: sysadmin
--

ALTER TABLE ONLY public.report_dtls
    ADD CONSTRAINT report_dtls_pkey PRIMARY KEY (labname);


-- Completed on 2022-07-18 15:14:31 IST

--
-- PostgreSQL database dump complete
--

