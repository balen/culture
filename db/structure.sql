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
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: submission_state_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.submission_state_enum AS ENUM (
    'draft',
    'submitted'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: organization_surveys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organization_surveys (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    survey_id uuid NOT NULL,
    access_code text NOT NULL,
    lock_version integer
);


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organizations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text,
    lock_version integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: survey_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.survey_groups (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name jsonb DEFAULT '{}'::jsonb,
    survey_id uuid NOT NULL,
    lock_version integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    short_code character varying(40)
);


--
-- Name: survey_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.survey_questions (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    question jsonb DEFAULT '{}'::jsonb,
    question_type character varying DEFAULT 'textfield'::character varying,
    group_id uuid NOT NULL,
    deleted_at timestamp(6) without time zone,
    lock_version integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    short_code character varying(40)
);


--
-- Name: survey_responses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.survey_responses (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    submission_id uuid NOT NULL,
    question_id uuid NOT NULL,
    response jsonb,
    response_as_text text,
    lock_version integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    short_code character varying(40)
);


--
-- Name: survey_submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.survey_submissions (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying,
    survey_id uuid NOT NULL,
    lock_version integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    submission_state public.submission_state_enum DEFAULT 'draft'::public.submission_state_enum,
    organization_survey_id uuid NOT NULL
);


--
-- Name: responses_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.responses_view AS
 SELECT sr.id AS response_id,
    sr.question_id,
    sr.response,
    sr.response_as_text,
    sq.short_code,
    o.name AS organization_name,
    os.organization_id,
    os.access_code,
    sq.group_id,
    sg.short_code AS group_short_code,
    ss.id AS submission_id
   FROM (((((public.survey_responses sr
     JOIN public.survey_questions sq ON ((sq.id = sr.question_id)))
     JOIN public.survey_groups sg ON ((sg.id = sq.group_id)))
     JOIN public.survey_submissions ss ON ((ss.id = sr.submission_id)))
     JOIN public.organization_surveys os ON ((os.id = ss.organization_survey_id)))
     JOIN public.organizations o ON ((o.id = os.organization_id)));


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: survey_answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.survey_answers (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    answer jsonb DEFAULT '{}'::jsonb,
    question_id uuid NOT NULL,
    lock_version integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: survey_likert_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.survey_likert_categories (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    label jsonb DEFAULT '{}'::jsonb,
    value integer,
    "order" integer,
    likert_setting_id uuid NOT NULL,
    lock_version integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: survey_likert_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.survey_likert_settings (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    left_label jsonb DEFAULT '{}'::jsonb,
    right_label jsonb DEFAULT '{}'::jsonb,
    question_id uuid NOT NULL,
    lock_version integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: survey_question_variants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.survey_question_variants (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    question jsonb DEFAULT '{}'::jsonb,
    question_id uuid NOT NULL,
    lock_version integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: surveys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.surveys (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name jsonb DEFAULT '{}'::jsonb,
    lock_version integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying(500),
    lock_version integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    email character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp(6) without time zone,
    last_sign_in_at timestamp(6) without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    locked_at timestamp(6) without time zone
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: organization_surveys organization_surveys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_surveys
    ADD CONSTRAINT organization_surveys_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: survey_answers survey_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_answers
    ADD CONSTRAINT survey_answers_pkey PRIMARY KEY (id);


--
-- Name: survey_groups survey_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_groups
    ADD CONSTRAINT survey_groups_pkey PRIMARY KEY (id);


--
-- Name: survey_likert_categories survey_likert_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_likert_categories
    ADD CONSTRAINT survey_likert_categories_pkey PRIMARY KEY (id);


--
-- Name: survey_likert_settings survey_likert_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_likert_settings
    ADD CONSTRAINT survey_likert_settings_pkey PRIMARY KEY (id);


--
-- Name: survey_question_variants survey_question_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_question_variants
    ADD CONSTRAINT survey_question_variants_pkey PRIMARY KEY (id);


--
-- Name: survey_questions survey_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_questions
    ADD CONSTRAINT survey_questions_pkey PRIMARY KEY (id);


--
-- Name: survey_responses survey_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_responses
    ADD CONSTRAINT survey_responses_pkey PRIMARY KEY (id);


--
-- Name: survey_submissions survey_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_submissions
    ADD CONSTRAINT survey_submissions_pkey PRIMARY KEY (id);


--
-- Name: surveys surveys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.surveys
    ADD CONSTRAINT surveys_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_survey_responses_on_submission_id_and_question_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_survey_responses_on_submission_id_and_question_id ON public.survey_responses USING btree (submission_id, question_id);


--
-- Name: index_survey_submissions_on_submission_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_survey_submissions_on_submission_state ON public.survey_submissions USING btree (submission_state);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: survey_responses fk_rails_00f2bfc353; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_responses
    ADD CONSTRAINT fk_rails_00f2bfc353 FOREIGN KEY (submission_id) REFERENCES public.survey_submissions(id);


--
-- Name: survey_likert_categories fk_rails_0131637727; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_likert_categories
    ADD CONSTRAINT fk_rails_0131637727 FOREIGN KEY (likert_setting_id) REFERENCES public.survey_likert_settings(id);


--
-- Name: survey_responses fk_rails_26b13a300f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_responses
    ADD CONSTRAINT fk_rails_26b13a300f FOREIGN KEY (question_id) REFERENCES public.survey_questions(id);


--
-- Name: survey_groups fk_rails_3d35e7baa3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_groups
    ADD CONSTRAINT fk_rails_3d35e7baa3 FOREIGN KEY (survey_id) REFERENCES public.surveys(id);


--
-- Name: survey_submissions fk_rails_422004fc2f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_submissions
    ADD CONSTRAINT fk_rails_422004fc2f FOREIGN KEY (survey_id) REFERENCES public.surveys(id);


--
-- Name: survey_question_variants fk_rails_5e3a06c563; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_question_variants
    ADD CONSTRAINT fk_rails_5e3a06c563 FOREIGN KEY (question_id) REFERENCES public.survey_questions(id);


--
-- Name: survey_questions fk_rails_7170ea9cf7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_questions
    ADD CONSTRAINT fk_rails_7170ea9cf7 FOREIGN KEY (group_id) REFERENCES public.survey_groups(id);


--
-- Name: survey_submissions fk_rails_afe927e3cd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_submissions
    ADD CONSTRAINT fk_rails_afe927e3cd FOREIGN KEY (organization_survey_id) REFERENCES public.organization_surveys(id);


--
-- Name: organization_surveys fk_rails_be5b70f6a5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_surveys
    ADD CONSTRAINT fk_rails_be5b70f6a5 FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: survey_likert_settings fk_rails_bfc3681e1b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_likert_settings
    ADD CONSTRAINT fk_rails_bfc3681e1b FOREIGN KEY (question_id) REFERENCES public.survey_questions(id);


--
-- Name: organization_surveys fk_rails_d535acbb1f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_surveys
    ADD CONSTRAINT fk_rails_d535acbb1f FOREIGN KEY (survey_id) REFERENCES public.surveys(id);


--
-- Name: survey_answers fk_rails_f616ee5949; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.survey_answers
    ADD CONSTRAINT fk_rails_f616ee5949 FOREIGN KEY (question_id) REFERENCES public.survey_questions(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20230502124405'),
('20230502124559'),
('20230502124840'),
('20230502162958'),
('20230502163024'),
('20230502163306'),
('20230502163339'),
('20230502163357'),
('20230502163409'),
('20230502170516'),
('20230502212920'),
('20230502212934'),
('20230502213850'),
('20230503142530'),
('20230503143620'),
('20230508141540'),
('20230622195007');


