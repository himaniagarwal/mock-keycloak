--
-- PostgreSQL database dump
--

-- Dumped from database version 10.2
-- Dumped by pg_dump version 10.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    client_template_id character varying(36),
    use_template_config boolean DEFAULT false NOT NULL,
    use_template_scope boolean DEFAULT false NOT NULL,
    use_template_mappers boolean DEFAULT false NOT NULL
);


ALTER TABLE client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE client_default_roles OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE client_node_registrations OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_session_role OWNER TO keycloak;

--
-- Name: client_template; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_template (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255),
    full_scope_allowed boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    bearer_only boolean DEFAULT false NOT NULL,
    public_client boolean DEFAULT false NOT NULL
);


ALTER TABLE client_template OWNER TO keycloak;

--
-- Name: client_template_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_template_attributes (
    template_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE client_template_attributes OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE credential (
    id character varying(36) NOT NULL,
    device character varying(255),
    hash_iterations integer,
    salt bytea,
    type character varying(255),
    value character varying(4000),
    user_id character varying(36),
    created_date bigint,
    counter integer DEFAULT 0,
    digits integer DEFAULT 6,
    period integer DEFAULT 30,
    algorithm character varying(36) DEFAULT NULL::character varying
);


ALTER TABLE credential OWNER TO keycloak;

--
-- Name: credential_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE credential_attribute (
    id character varying(36) NOT NULL,
    credential_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE credential_attribute OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255)
);


ALTER TABLE databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE databasechangeloglock OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE event_entity OWNER TO keycloak;

--
-- Name: fed_credential_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_credential_attribute (
    id character varying(36) NOT NULL,
    credential_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE fed_credential_attribute OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_consent_prot_mapper (
    user_consent_id character varying(36) NOT NULL,
    protocol_mapper_id character varying(36) NOT NULL
);


ALTER TABLE fed_user_consent_prot_mapper OWNER TO keycloak;

--
-- Name: fed_user_consent_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_consent_role (
    user_consent_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE fed_user_consent_role OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_credential (
    id character varying(36) NOT NULL,
    device character varying(255),
    hash_iterations integer,
    salt bytea,
    type character varying(255),
    value character varying(255),
    created_date bigint,
    counter integer DEFAULT 0,
    digits integer DEFAULT 6,
    period integer DEFAULT 30,
    algorithm character varying(36) DEFAULT 'HmacSHA1'::character varying,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36),
    realm_id character varying(36)
);


ALTER TABLE keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(36),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36),
    scope_param_required boolean DEFAULT false NOT NULL
);


ALTER TABLE keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE migration_model (
    id character varying(36) NOT NULL,
    version character varying(36)
);


ALTER TABLE migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(36) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    last_session_refresh integer,
    offline_flag character varying(4) NOT NULL,
    data text
);


ALTER TABLE offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    consent_text character varying(255),
    client_id character varying(36),
    client_template_id character varying(36)
);


ALTER TABLE protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL
);


ALTER TABLE realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE realm_default_groups OWNER TO keycloak;

--
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE realm_default_roles OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255)
);


ALTER TABLE required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL
);


ALTER TABLE resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(36) NOT NULL,
    requester character varying(36) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL
);


ALTER TABLE resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL
);


ALTER TABLE resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    uri character varying(255),
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(36) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE resource_server_scope OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE scope_policy OWNER TO keycloak;

--
-- Name: template_scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE template_scope_mapping (
    template_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE template_scope_mapping OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE user_consent OWNER TO keycloak;

--
-- Name: user_consent_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_consent_prot_mapper (
    user_consent_id character varying(36) NOT NULL,
    protocol_mapper_id character varying(36) NOT NULL
);


ALTER TABLE user_consent_prot_mapper OWNER TO keycloak;

--
-- Name: user_consent_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_consent_role (
    user_consent_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE user_consent_role OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(36),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
7d25d5ce-f6b8-491e-bca7-15b1f16cf3d3	\N	auth-cookie	master	aef8c6c1-08d4-46e2-88aa-2a698a8abd37	2	10	f	\N	\N
815b3e3e-9452-4b02-8250-ceff6fec6fec	\N	auth-spnego	master	aef8c6c1-08d4-46e2-88aa-2a698a8abd37	3	20	f	\N	\N
2687b5a6-1f42-4bf5-907e-1646d33adb31	\N	identity-provider-redirector	master	aef8c6c1-08d4-46e2-88aa-2a698a8abd37	2	25	f	\N	\N
0032b58c-84dd-4529-82a5-46cb7efbbbf3	\N	\N	master	aef8c6c1-08d4-46e2-88aa-2a698a8abd37	2	30	t	aee4f43c-5d9e-4010-b8e4-f180871ea7bc	\N
6de90ef2-501f-4c5c-845c-b3bab745a480	\N	auth-username-password-form	master	aee4f43c-5d9e-4010-b8e4-f180871ea7bc	0	10	f	\N	\N
2b7867df-dbf7-48f0-a5f1-285347ad6831	\N	auth-otp-form	master	aee4f43c-5d9e-4010-b8e4-f180871ea7bc	1	20	f	\N	\N
0cafd9fc-4b81-4fb4-8dd3-8f6604dff193	\N	direct-grant-validate-username	master	3ae27946-6f20-47b0-8169-e439850129cc	0	10	f	\N	\N
402f444c-31b4-4bf6-9570-1a0d153bf91a	\N	direct-grant-validate-password	master	3ae27946-6f20-47b0-8169-e439850129cc	0	20	f	\N	\N
adb23e10-8cfa-4456-8a27-3f9dbbe850ed	\N	direct-grant-validate-otp	master	3ae27946-6f20-47b0-8169-e439850129cc	1	30	f	\N	\N
7d4f945d-3900-4724-97d8-88dda4818ac5	\N	registration-page-form	master	d742dba0-a37c-41c7-a2f6-c0460c7b8980	0	10	t	40526619-7061-43d3-8885-c59c7050a3bb	\N
cea0eb47-8b95-4855-bf0e-0d2635891fa0	\N	registration-user-creation	master	40526619-7061-43d3-8885-c59c7050a3bb	0	20	f	\N	\N
041ca85c-105d-499c-a0e8-e989e3cc845a	\N	registration-profile-action	master	40526619-7061-43d3-8885-c59c7050a3bb	0	40	f	\N	\N
8bf511d6-5159-4c7b-bafd-66bea0381e21	\N	registration-password-action	master	40526619-7061-43d3-8885-c59c7050a3bb	0	50	f	\N	\N
34d4c5df-e2dc-44ea-98b3-a95f371a3cc0	\N	registration-recaptcha-action	master	40526619-7061-43d3-8885-c59c7050a3bb	3	60	f	\N	\N
b061676b-6a97-4f7e-981d-39e033a69e03	\N	reset-credentials-choose-user	master	2bf67332-a18f-4608-82ae-f1ec2403199b	0	10	f	\N	\N
954f2dc6-6935-4a2d-b535-4ec297149a26	\N	reset-credential-email	master	2bf67332-a18f-4608-82ae-f1ec2403199b	0	20	f	\N	\N
2a40478d-8800-4600-9918-099160cd9d09	\N	reset-password	master	2bf67332-a18f-4608-82ae-f1ec2403199b	0	30	f	\N	\N
7109b99f-f44e-4f7a-a4d0-3e48b936cf42	\N	reset-otp	master	2bf67332-a18f-4608-82ae-f1ec2403199b	1	40	f	\N	\N
e8689af2-2fd2-4b0c-b9fa-aad0bee15371	\N	client-secret	master	6da1b97e-eed2-4515-a507-2167e1e206d1	2	10	f	\N	\N
3f92b050-f78f-4278-a2fd-dc7c494262cb	\N	client-jwt	master	6da1b97e-eed2-4515-a507-2167e1e206d1	2	20	f	\N	\N
cc01479f-0097-4560-9e51-8772c6650496	\N	client-secret-jwt	master	6da1b97e-eed2-4515-a507-2167e1e206d1	2	30	f	\N	\N
31225140-a6f9-407b-9806-7df4c42e0071	\N	idp-review-profile	master	5ba1b721-3319-48ec-bc80-c5d661fde8da	0	10	f	\N	338a6cd2-4b50-4ea1-ba94-423696ef7b85
dd1f36aa-feef-41b7-9a86-75fdb8cd6692	\N	idp-create-user-if-unique	master	5ba1b721-3319-48ec-bc80-c5d661fde8da	2	20	f	\N	b878dc7d-7f2f-4094-952f-8fbaa87c6bd3
8184a859-95e2-4d93-a1ee-566ef29bd91c	\N	\N	master	5ba1b721-3319-48ec-bc80-c5d661fde8da	2	30	t	121c7f77-bf05-408d-90bb-5f47f70b47b0	\N
d8e18ecc-ce0a-41c9-a493-2b41624b76d5	\N	idp-confirm-link	master	121c7f77-bf05-408d-90bb-5f47f70b47b0	0	10	f	\N	\N
c3b0e28e-b49e-4c40-8a73-8442ccdcf869	\N	idp-email-verification	master	121c7f77-bf05-408d-90bb-5f47f70b47b0	2	20	f	\N	\N
70fd9199-c0d0-4475-871e-80566ace4a6f	\N	\N	master	121c7f77-bf05-408d-90bb-5f47f70b47b0	2	30	t	4fccbb83-d025-42f0-86f7-6a266ae6b2eb	\N
038213d6-701b-4de2-9f08-2c8002c69b20	\N	idp-username-password-form	master	4fccbb83-d025-42f0-86f7-6a266ae6b2eb	0	10	f	\N	\N
1375acad-9c8d-4961-a6d8-11d85a2a0aed	\N	auth-otp-form	master	4fccbb83-d025-42f0-86f7-6a266ae6b2eb	1	20	f	\N	\N
fcbcdb9d-0b3e-48c1-a532-525702c0b9d2	\N	http-basic-authenticator	master	70b35186-957f-431d-bb4a-881f874802cf	0	10	f	\N	\N
e52cba5c-54f4-413c-98ae-70292a1ca87a	\N	docker-http-basic-authenticator	master	3992c0c9-0a8a-4a96-a129-7234ef4f3150	0	10	f	\N	\N
4e33a1df-0c4d-43d5-a42f-cba521e50e45	\N	idp-confirm-link	SpringBootKeyCloak	5b63ad4d-7998-4218-8bcf-8d95583114db	0	10	f	\N	\N
2294e8df-f274-4c4f-a808-ec554bc8170d	\N	idp-email-verification	SpringBootKeyCloak	5b63ad4d-7998-4218-8bcf-8d95583114db	2	20	f	\N	\N
7860cdae-6b53-49d1-8c71-7d23a4532726	\N	\N	SpringBootKeyCloak	5b63ad4d-7998-4218-8bcf-8d95583114db	2	30	t	26fddc2f-c3a0-4e6d-babc-165da634e54d	\N
ff409c3d-d5b0-460b-b80d-37e22d8b1f60	\N	idp-username-password-form	SpringBootKeyCloak	26fddc2f-c3a0-4e6d-babc-165da634e54d	0	10	f	\N	\N
05ea5f8f-19c1-4575-badd-f4eceb687034	\N	auth-otp-form	SpringBootKeyCloak	26fddc2f-c3a0-4e6d-babc-165da634e54d	1	20	f	\N	\N
a9563b00-46b7-4c24-9e87-f4c51344676e	\N	auth-cookie	SpringBootKeyCloak	a9d9b593-7c45-4937-8072-80971ba01dbc	2	10	f	\N	\N
5d7dda0f-03b9-4c35-ad48-e41d7502165c	\N	auth-spnego	SpringBootKeyCloak	a9d9b593-7c45-4937-8072-80971ba01dbc	3	20	f	\N	\N
0c241800-5b32-465f-9599-9e3883c0bc46	\N	identity-provider-redirector	SpringBootKeyCloak	a9d9b593-7c45-4937-8072-80971ba01dbc	2	25	f	\N	\N
1eedc3d1-c867-43e7-b76e-9c5fe20f7d87	\N	\N	SpringBootKeyCloak	a9d9b593-7c45-4937-8072-80971ba01dbc	2	30	t	c6ea947b-5fd5-4298-acb2-f0b0ad39444e	\N
be23bea0-4711-4643-b8dd-ab61caf73cc9	\N	client-secret	SpringBootKeyCloak	af189c43-11e8-4845-9d23-1e56631ba136	2	10	f	\N	\N
bae9f081-9696-43bf-8e65-6fadd9c88041	\N	client-jwt	SpringBootKeyCloak	af189c43-11e8-4845-9d23-1e56631ba136	2	20	f	\N	\N
bb515467-22ad-47d5-9e75-af8144eba2d3	\N	client-secret-jwt	SpringBootKeyCloak	af189c43-11e8-4845-9d23-1e56631ba136	2	30	f	\N	\N
c0090119-cef1-441d-81da-e8bd47b701cd	\N	direct-grant-validate-username	SpringBootKeyCloak	58142a0a-c745-4ec8-b5ca-5a5d94117b41	0	10	f	\N	\N
07681541-a7cf-490f-bea7-a2f15b890f69	\N	direct-grant-validate-password	SpringBootKeyCloak	58142a0a-c745-4ec8-b5ca-5a5d94117b41	0	20	f	\N	\N
3eb8d15b-7f77-451b-963f-90cdbb682794	\N	direct-grant-validate-otp	SpringBootKeyCloak	58142a0a-c745-4ec8-b5ca-5a5d94117b41	1	30	f	\N	\N
55888979-a58b-4f64-b48e-72a860fbc406	\N	docker-http-basic-authenticator	SpringBootKeyCloak	83ed90e2-1778-42d2-b206-402604ff03df	0	10	f	\N	\N
8859ceeb-c20b-4dc3-8589-9fa1629fc26c	\N	idp-review-profile	SpringBootKeyCloak	f4ca7d92-89ab-4322-b0f5-dd674f42723e	0	10	f	\N	d2c98b9d-9f4d-4ff0-abf8-c32d4206e208
39e62cc9-9c63-4cc6-aba7-7988a335e2a9	\N	idp-create-user-if-unique	SpringBootKeyCloak	f4ca7d92-89ab-4322-b0f5-dd674f42723e	2	20	f	\N	c5be56c1-b174-4f14-9125-00ece9b02216
f4395bce-665e-4025-a16e-cac09ce9a7ca	\N	\N	SpringBootKeyCloak	f4ca7d92-89ab-4322-b0f5-dd674f42723e	2	30	t	5b63ad4d-7998-4218-8bcf-8d95583114db	\N
e981f4b4-e1eb-4e20-b6f3-1f9823d6863b	\N	auth-username-password-form	SpringBootKeyCloak	c6ea947b-5fd5-4298-acb2-f0b0ad39444e	0	10	f	\N	\N
9f869282-e41a-4c0d-a045-729f0ebf0af7	\N	auth-otp-form	SpringBootKeyCloak	c6ea947b-5fd5-4298-acb2-f0b0ad39444e	1	20	f	\N	\N
d4737ebb-3800-4ca9-8ffc-cf395bff0863	\N	registration-page-form	SpringBootKeyCloak	e1b62786-af39-42de-a93a-acf66af648cd	0	10	t	2ee3af37-2972-41ed-810a-1aff0001583d	\N
b37c88b1-63f4-425c-9b39-b4d76dafb49b	\N	registration-user-creation	SpringBootKeyCloak	2ee3af37-2972-41ed-810a-1aff0001583d	0	20	f	\N	\N
5fd5eb45-816a-4641-8d1d-8e036b82e56c	\N	registration-profile-action	SpringBootKeyCloak	2ee3af37-2972-41ed-810a-1aff0001583d	0	40	f	\N	\N
e2b31d91-d217-429e-b82a-9c605d438903	\N	registration-password-action	SpringBootKeyCloak	2ee3af37-2972-41ed-810a-1aff0001583d	0	50	f	\N	\N
f317cc83-7af9-46a8-8aa5-64037afea8d1	\N	registration-recaptcha-action	SpringBootKeyCloak	2ee3af37-2972-41ed-810a-1aff0001583d	3	60	f	\N	\N
8379dab1-c295-446c-9cd5-006953d13ebe	\N	reset-credentials-choose-user	SpringBootKeyCloak	ba5218d8-6cd8-4562-b382-e051c7af7a78	0	10	f	\N	\N
2dd832d2-ced6-4354-98d1-3fd95abae960	\N	reset-credential-email	SpringBootKeyCloak	ba5218d8-6cd8-4562-b382-e051c7af7a78	0	20	f	\N	\N
ce45dfb0-542e-4826-b6b8-d8ec578eed6a	\N	reset-password	SpringBootKeyCloak	ba5218d8-6cd8-4562-b382-e051c7af7a78	0	30	f	\N	\N
f7e9781e-dd83-463b-97bd-5c0db76fd625	\N	reset-otp	SpringBootKeyCloak	ba5218d8-6cd8-4562-b382-e051c7af7a78	1	40	f	\N	\N
8c646b39-3d02-46bf-b2ef-3164ba1b72ff	\N	http-basic-authenticator	SpringBootKeyCloak	285dfc2f-3823-4c40-afb9-aa1011e2a58e	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
aef8c6c1-08d4-46e2-88aa-2a698a8abd37	browser	browser based authentication	master	basic-flow	t	t
aee4f43c-5d9e-4010-b8e4-f180871ea7bc	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
3ae27946-6f20-47b0-8169-e439850129cc	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
d742dba0-a37c-41c7-a2f6-c0460c7b8980	registration	registration flow	master	basic-flow	t	t
40526619-7061-43d3-8885-c59c7050a3bb	registration form	registration form	master	form-flow	f	t
2bf67332-a18f-4608-82ae-f1ec2403199b	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
6da1b97e-eed2-4515-a507-2167e1e206d1	clients	Base authentication for clients	master	client-flow	t	t
5ba1b721-3319-48ec-bc80-c5d661fde8da	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
121c7f77-bf05-408d-90bb-5f47f70b47b0	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
4fccbb83-d025-42f0-86f7-6a266ae6b2eb	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
70b35186-957f-431d-bb4a-881f874802cf	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
3992c0c9-0a8a-4a96-a129-7234ef4f3150	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
5b63ad4d-7998-4218-8bcf-8d95583114db	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	SpringBootKeyCloak	basic-flow	f	t
26fddc2f-c3a0-4e6d-babc-165da634e54d	Verify Existing Account by Re-authentication	Reauthentication of existing account	SpringBootKeyCloak	basic-flow	f	t
a9d9b593-7c45-4937-8072-80971ba01dbc	browser	browser based authentication	SpringBootKeyCloak	basic-flow	t	t
af189c43-11e8-4845-9d23-1e56631ba136	clients	Base authentication for clients	SpringBootKeyCloak	client-flow	t	t
58142a0a-c745-4ec8-b5ca-5a5d94117b41	direct grant	OpenID Connect Resource Owner Grant	SpringBootKeyCloak	basic-flow	t	t
83ed90e2-1778-42d2-b206-402604ff03df	docker auth	Used by Docker clients to authenticate against the IDP	SpringBootKeyCloak	basic-flow	t	t
f4ca7d92-89ab-4322-b0f5-dd674f42723e	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	SpringBootKeyCloak	basic-flow	t	t
c6ea947b-5fd5-4298-acb2-f0b0ad39444e	forms	Username, password, otp and other auth forms.	SpringBootKeyCloak	basic-flow	f	t
e1b62786-af39-42de-a93a-acf66af648cd	registration	registration flow	SpringBootKeyCloak	basic-flow	t	t
2ee3af37-2972-41ed-810a-1aff0001583d	registration form	registration form	SpringBootKeyCloak	form-flow	f	t
ba5218d8-6cd8-4562-b382-e051c7af7a78	reset credentials	Reset credentials for a user if they forgot their password or something	SpringBootKeyCloak	basic-flow	t	t
285dfc2f-3823-4c40-afb9-aa1011e2a58e	saml ecp	SAML ECP Profile Authentication Flow	SpringBootKeyCloak	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY authenticator_config (id, alias, realm_id) FROM stdin;
338a6cd2-4b50-4ea1-ba94-423696ef7b85	review profile config	master
b878dc7d-7f2f-4094-952f-8fbaa87c6bd3	create unique user config	master
c5be56c1-b174-4f14-9125-00ece9b02216	create unique user config	SpringBootKeyCloak
d2c98b9d-9f4d-4ff0-abf8-c32d4206e208	review profile config	SpringBootKeyCloak
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY authenticator_config_entry (authenticator_id, value, name) FROM stdin;
338a6cd2-4b50-4ea1-ba94-423696ef7b85	missing	update.profile.on.first.login
b878dc7d-7f2f-4094-952f-8fbaa87c6bd3	false	require.password.update.after.registration
c5be56c1-b174-4f14-9125-00ece9b02216	false	require.password.update.after.registration
d2c98b9d-9f4d-4ff0-abf8-c32d4206e208	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, client_template_id, use_template_config, use_template_scope, use_template_mappers) FROM stdin;
a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	t	master-realm	0	f	631b23dc-dc0a-404b-b3ea-a282e62e7120	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	\N	f	f	f
cf524dc9-a8c9-48f8-9d27-cde21540af72	t	f	account	0	f	c7e5e736-0a5e-4860-8adf-fda16ed1c85b	/auth/realms/master/account	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	\N	\N	\N	t	f	f	\N	f	f	f
cedf9f44-af93-41b6-941a-8139f712b663	t	f	broker	0	f	e5f7d614-550f-46d0-9e1c-fc7294fc0253	\N	f	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	\N	f	f	f
162d497a-6ba1-4a71-a14d-4ec45b457ae6	t	f	security-admin-console	0	t	062f80b6-9ed4-454b-9a4a-f72b1959ccb0	/auth/admin/master/console/index.html	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	\N	\N	\N	t	f	f	\N	f	f	f
f4adffef-cb04-4c85-837a-594bcf345e75	t	f	admin-cli	0	t	7c462862-2ff3-41c0-b9c3-616ffa6a158d	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	\N	f	f	f
7339dc51-b089-4891-8917-fc48dbf1ed2e	t	t	SpringBootKeyCloak-realm	0	f	2d6ddf6d-8ae1-4b8f-a5ad-d43361cae2c1	\N	t	\N	f	master	\N	0	f	f	SpringBootKeyCloak Realm	f	client-secret	\N	\N	\N	t	f	f	\N	f	f	f
0a7b8751-0939-430f-b9b0-450d5b8e0a36	t	f	security-admin-console	0	t	**********	/auth/admin/SpringBootKeyCloak/console/index.html	f	\N	f	SpringBootKeyCloak	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	\N	\N	\N	t	f	f	\N	f	f	f
65488c37-d3e4-4ee3-b1a1-76e404c6658a	t	t	demo	0	f	**********	http://localhost:8080	f	\N	f	SpringBootKeyCloak	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	\N	f	f	f
eafa763b-e07b-4bd0-b6a3-7a2061f7b627	t	f	broker	0	f	**********	\N	f	\N	f	SpringBootKeyCloak	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	\N	f	f	f
6410d274-5f23-45e8-94fe-753fbec9fb58	t	t	login-app	0	f	d09df836-bec8-4b52-8415-24920353ebc0	\N	f	\N	f	SpringBootKeyCloak	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	\N	f	f	f
1bed78cc-2952-4fff-8a42-4f06039e5543	t	f	realm-management	0	f	**********	\N	f	\N	f	SpringBootKeyCloak	openid-connect	0	f	f	${client_realm-management}	t	client-secret	\N	\N	\N	t	f	f	\N	f	f	f
b9c482ca-a12c-4af3-9e70-07c23d98a085	t	f	admin-cli	0	t	**********	\N	f	\N	f	SpringBootKeyCloak	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	\N	f	f	f
9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	t	f	account	0	f	**********	/auth/realms/SpringBootKeyCloak/account	f	\N	f	SpringBootKeyCloak	openid-connect	0	f	f	${client_account}	f	client-secret	\N	\N	\N	t	f	f	\N	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client_attributes (client_id, value, name) FROM stdin;
65488c37-d3e4-4ee3-b1a1-76e404c6658a	false	saml.assertion.signature
65488c37-d3e4-4ee3-b1a1-76e404c6658a	false	saml.force.post.binding
65488c37-d3e4-4ee3-b1a1-76e404c6658a	false	saml.multivalued.roles
65488c37-d3e4-4ee3-b1a1-76e404c6658a	false	saml.encrypt
65488c37-d3e4-4ee3-b1a1-76e404c6658a	false	saml_force_name_id_format
65488c37-d3e4-4ee3-b1a1-76e404c6658a	false	saml.client.signature
65488c37-d3e4-4ee3-b1a1-76e404c6658a	false	saml.authnstatement
65488c37-d3e4-4ee3-b1a1-76e404c6658a	false	saml.server.signature
65488c37-d3e4-4ee3-b1a1-76e404c6658a	false	saml.server.signature.keyinfo.ext
65488c37-d3e4-4ee3-b1a1-76e404c6658a	false	saml.onetimeuse.condition
6410d274-5f23-45e8-94fe-753fbec9fb58	false	saml.assertion.signature
6410d274-5f23-45e8-94fe-753fbec9fb58	false	saml.force.post.binding
6410d274-5f23-45e8-94fe-753fbec9fb58	false	saml.multivalued.roles
6410d274-5f23-45e8-94fe-753fbec9fb58	false	saml.encrypt
6410d274-5f23-45e8-94fe-753fbec9fb58	false	saml_force_name_id_format
6410d274-5f23-45e8-94fe-753fbec9fb58	false	saml.client.signature
6410d274-5f23-45e8-94fe-753fbec9fb58	false	saml.authnstatement
6410d274-5f23-45e8-94fe-753fbec9fb58	false	saml.server.signature
6410d274-5f23-45e8-94fe-753fbec9fb58	false	saml.server.signature.keyinfo.ext
6410d274-5f23-45e8-94fe-753fbec9fb58	false	exclude.session.state.from.auth.response
6410d274-5f23-45e8-94fe-753fbec9fb58	false	saml.onetimeuse.condition
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client_default_roles (client_id, role_id) FROM stdin;
cf524dc9-a8c9-48f8-9d27-cde21540af72	575dcaa1-2cf2-45c3-979f-d22892300b68
cf524dc9-a8c9-48f8-9d27-cde21540af72	1574210b-6a8c-4cdd-8fcc-67dd8e69263b
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_template; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client_template (id, name, realm_id, description, protocol, full_scope_allowed, consent_required, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, service_accounts_enabled, frontchannel_logout, bearer_only, public_client) FROM stdin;
\.


--
-- Data for Name: client_template_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client_template_attributes (template_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
160a4bea-af28-462b-8f04-6e41b0ac7ca1	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
1d0af6db-5fc3-4881-8fe9-54b28ff6cca6	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
94b8b4ba-2a75-4d53-82a3-05ae183b3029	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
edba44b1-099f-41fe-9c6e-a0bad3d50af4	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
53bb939f-81b3-436f-97d4-00bef101a15c	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
83b1c096-123a-4ee4-ba59-deb3087ba497	Allowed Client Templates	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
d03d2aac-2229-47a6-91e7-335851a7cc89	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
83385cdf-2549-4b03-b80e-429fa716a401	Allowed Client Templates	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
792d04b4-7b16-4cc0-b59e-887d0b501bbd	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
370ad9cb-3120-4d93-b9bf-68505f749c20	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
519ad2f4-4321-4bbc-a05c-b26562ba5225	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
f10b2e12-4502-456c-ade7-f290c24df449	Allowed Protocol Mapper Types	SpringBootKeyCloak	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeyCloak	anonymous
cba69f5c-e507-4d2c-b423-b2b1743b0c4b	Trusted Hosts	SpringBootKeyCloak	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeyCloak	anonymous
9476949f-fbaf-4852-b0ef-434cfedafc84	Allowed Protocol Mapper Types	SpringBootKeyCloak	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeyCloak	authenticated
3a2f95e7-34ac-4d1b-ad23-827007a82f48	Allowed Client Templates	SpringBootKeyCloak	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeyCloak	authenticated
2dc48014-deaf-4761-86d3-0158eb3227c2	Full Scope Disabled	SpringBootKeyCloak	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeyCloak	anonymous
03ff3fa9-cda9-4a42-8662-b78f3b969f10	Max Clients Limit	SpringBootKeyCloak	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeyCloak	anonymous
fc28c3e0-f686-4b24-8805-218a67aa16eb	Allowed Client Templates	SpringBootKeyCloak	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeyCloak	anonymous
f07e810e-debb-4e15-8631-d95cefeda987	Consent Required	SpringBootKeyCloak	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeyCloak	anonymous
a701f69b-62cd-4543-b9f8-bfdeef1884e4	hmac-generated	SpringBootKeyCloak	hmac-generated	org.keycloak.keys.KeyProvider	SpringBootKeyCloak	\N
45c2db2d-969e-482d-bd7b-c42820b7a354	aes-generated	SpringBootKeyCloak	aes-generated	org.keycloak.keys.KeyProvider	SpringBootKeyCloak	\N
70e25b1b-653b-40c6-a30c-9b47e9d2da72	rsa-generated	SpringBootKeyCloak	rsa-generated	org.keycloak.keys.KeyProvider	SpringBootKeyCloak	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY component_config (id, component_id, name, value) FROM stdin;
4a0ba0c9-fa67-4b01-b55e-833948b5491f	edba44b1-099f-41fe-9c6e-a0bad3d50af4	max-clients	200
adff089b-14e0-4777-befd-0718fafd1d95	d03d2aac-2229-47a6-91e7-335851a7cc89	allowed-protocol-mapper-types	oidc-address-mapper
f19dd30e-1246-4e2e-8b7b-a73a1074e925	d03d2aac-2229-47a6-91e7-335851a7cc89	allowed-protocol-mapper-types	saml-user-property-mapper
ece90e9e-6773-4123-9e8b-4af15cca4c1e	d03d2aac-2229-47a6-91e7-335851a7cc89	allowed-protocol-mapper-types	oidc-full-name-mapper
2a868d0d-ca28-4cc3-9ccf-a7ad3f85e163	d03d2aac-2229-47a6-91e7-335851a7cc89	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3afb6eb4-37f0-45b4-847d-860c0939ea68	d03d2aac-2229-47a6-91e7-335851a7cc89	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
6e1118ea-24b7-415f-a5fa-8b6a5105a49f	d03d2aac-2229-47a6-91e7-335851a7cc89	allowed-protocol-mapper-types	saml-role-list-mapper
74c4fbec-3bae-403c-93f1-e81b97c0372b	d03d2aac-2229-47a6-91e7-335851a7cc89	allowed-protocol-mapper-types	saml-user-attribute-mapper
5fe4227f-ca77-421b-8e67-515113ee3a30	d03d2aac-2229-47a6-91e7-335851a7cc89	consent-required-for-all-mappers	true
092268c8-3e66-4ac3-bc51-ba51426c7767	d03d2aac-2229-47a6-91e7-335851a7cc89	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a186128b-f42c-499b-b442-657e78e4e5ea	53bb939f-81b3-436f-97d4-00bef101a15c	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
56d0d082-2adf-4549-ab74-3867dd88aadd	53bb939f-81b3-436f-97d4-00bef101a15c	allowed-protocol-mapper-types	saml-user-attribute-mapper
4561bbd6-0fe4-4e8b-bf3b-9801d2644629	53bb939f-81b3-436f-97d4-00bef101a15c	allowed-protocol-mapper-types	saml-role-list-mapper
05f54c97-8df0-44b1-a48f-812c0bba1c95	53bb939f-81b3-436f-97d4-00bef101a15c	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d6e7e960-264a-46a2-8a25-f134fa083253	53bb939f-81b3-436f-97d4-00bef101a15c	allowed-protocol-mapper-types	oidc-full-name-mapper
6bc913da-9980-4e3e-8a31-4c7afcacce22	53bb939f-81b3-436f-97d4-00bef101a15c	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
9dd55732-ef5b-48c2-9237-841ae97932fa	53bb939f-81b3-436f-97d4-00bef101a15c	allowed-protocol-mapper-types	oidc-address-mapper
371f4593-b519-4b99-bda2-4531d66f919d	53bb939f-81b3-436f-97d4-00bef101a15c	allowed-protocol-mapper-types	saml-user-property-mapper
b0d510e1-a91e-43b3-8371-f5e2c9a73845	53bb939f-81b3-436f-97d4-00bef101a15c	consent-required-for-all-mappers	true
9a08535a-8ae6-42e0-b518-3593c5d54ed9	160a4bea-af28-462b-8f04-6e41b0ac7ca1	host-sending-registration-request-must-match	true
a8947830-d4a8-4de7-a0f8-4f042e0c2a9d	160a4bea-af28-462b-8f04-6e41b0ac7ca1	client-uris-must-match	true
68c84945-a3b4-4d13-8a58-1802e4e030fe	370ad9cb-3120-4d93-b9bf-68505f749c20	kid	e17fc3df-c07a-4c62-a68c-7ac014efc2bc
6d934a88-a39b-4c46-a9c1-7c913254e4e9	370ad9cb-3120-4d93-b9bf-68505f749c20	priority	100
990b6a6e-f483-49ee-8a2e-07b4e1a6a559	370ad9cb-3120-4d93-b9bf-68505f749c20	secret	fSCpoBDF08g2Npigib3Jo_4651duYoAJAgA7ebj66yM
5adc4df7-c0b0-4870-ba10-62954a5776eb	519ad2f4-4321-4bbc-a05c-b26562ba5225	secret	JDxzZprdMn2iFmjQquxJQQ
776bd76b-92bc-4615-8711-6b32a2eefcda	519ad2f4-4321-4bbc-a05c-b26562ba5225	priority	100
51db0306-60bf-4076-a581-a30ae6e2b9d4	519ad2f4-4321-4bbc-a05c-b26562ba5225	kid	b4df79b9-6455-43b9-b18c-05f19b67742b
224e42a6-3d5b-4ebe-8d19-51c10e121e60	792d04b4-7b16-4cc0-b59e-887d0b501bbd	privateKey	MIIEowIBAAKCAQEApd+OqVVfxU3X0/2cD7GVCRgYYozV4gdV83YB19bY19SQxf/L8dQRgckSZl+af+y7fKkzlU/8TwWKactrBm/pCOg4MKqt8F0sM3atCw3mwdiFgd7AziTeR46tMHIVWri4cSVT+8323cobGXredUAei2SDda2mdipUuiNver+4Z9Ggb7sXnZGWjUQOXqsGRhJRNneAso1WeA4HAospgvSewv8baI9ehVnCe4beZHjipqYUCG8pu/WrWoQz0yNkQZ1hwGGdg8aifnNWfQszoej7XQlYJ5Y4Mll7jafncSn0B+xU1jpR0dqCDKuAyY/W9caX5/iProjHgpd8JpGnmNT7wwIDAQABAoIBAFuHL45qyKzz1kto3uud/vIEtLf0pLTTfW8ZR80VBZSa+8P18VCgx4RJMnkA+hzqwU35g7g5aa0lDopwL79ek0VR9meMVuySTSicrMGzywhd9NWD1/ooR+tOZGyeFwB3e3cbtOr2bOlXc3qs3QHv/qrGLPALgRYlJ5mKoiImlpfaJJabL5hjZKYwH8L7YpYjtPJYdX6yxj1Nz6Ilul9Mzuzb4eftg3yV563c32jAm2nPS7+uM/hS8Rm3+IVSbolYkH1fRzJN2H8mg4FTfaEaIKAlsJkJuEj1I48ZQcfbPjTniv6dh9zr4/KmVyj/o8AoaWsfgp/Dc6JNF9BncpHX6BkCgYEA5fktVwMDXgNLr5LimnXE9+iZdjnt9O82ElsSUkzItbub31cF6bz9xfE8SKTIOGliIDIy8DAvAvoJGj5zi5OQnRq5HxxL4NHtCCi6OQHK72qTuNGeFAZOdewbylbS3xjFcoUTpk7LzUoDXYh6021IfMCWZXjXHtkmE4zWmxmmqH0CgYEAuKVDUIuVWzVDh23XvkfvqCodf6vEUekXEODxwR/vVxp+0PpULR7iRjwe125Swpacv40UolOVQ52vluY5TS54adn+zDEefx+sKs7KiKmegyRxRUVYbal7IR/aan9YELiaOU94N6OCdOroAZ6FHprcknB0ObCQjelwi0xs7KyjqT8CgYEAoLRYt7Y2UysQZ7fIPFHR+7+CBfkDTScgbQFRM0vO8hgRG6gvTKAx4nHqQ4VLGQijdoY9zFSPdZAOblV33vCWnQKAnLnkWE26SvpS7+VNz7J1WjC5O5sQlx0Qanvzzcz8pUNTcOMdTe7LnT/zPO3gOrVGI9Cm2zq5fe3sReRN7u0CgYAsWhYHPOANXofv+eR+okzgue0IA7xOaIzP0xh+6SrWY1je3aJmjCqR8FMAMFHUx9Sy9jJko2sRKMlKl9Zfwa/OzTw00/+dTYBPcAiaNxQKMDC9EOEixjj7Rely90+yBIWXCo2336CwcNR1vxv+s/gTfMuOJ+kxDUepThxD5VwShQKBgAGmt2GS6DD5oGX/KS90QxUP4kLrHEbsaVc89rnb3YdE2jP3gb+Yjbf7fOUPDmyP7SS5/u/yXQgmuIQ9obfaryIYOg3yiCfhGIqUocZLvmUGCVtM7qwtzItba4yjl/Z4OoYEz8U6vfShxUzvyQ7w0tPgFo/PJewVuuDCVxOJR5yY
7e1e5e48-dbd8-46c5-a298-4bbb168c4db8	792d04b4-7b16-4cc0-b59e-887d0b501bbd	priority	100
dc3ea668-8c58-4b35-8c82-29663dc042a2	792d04b4-7b16-4cc0-b59e-887d0b501bbd	certificate	MIICmzCCAYMCBgFjsi2oWDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMTgwNTMwMTc1MDI2WhcNMjgwNTMwMTc1MjA2WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCl346pVV/FTdfT/ZwPsZUJGBhijNXiB1XzdgHX1tjX1JDF/8vx1BGByRJmX5p/7Lt8qTOVT/xPBYppy2sGb+kI6Dgwqq3wXSwzdq0LDebB2IWB3sDOJN5Hjq0wchVauLhxJVP7zfbdyhsZet51QB6LZIN1raZ2KlS6I296v7hn0aBvuxedkZaNRA5eqwZGElE2d4CyjVZ4DgcCiymC9J7C/xtoj16FWcJ7ht5keOKmphQIbym79atahDPTI2RBnWHAYZ2DxqJ+c1Z9CzOh6PtdCVgnljgyWXuNp+dxKfQH7FTWOlHR2oIMq4DJj9b1xpfn+I+uiMeCl3wmkaeY1PvDAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAneWQOa24vuTuUdDpO1yd08APnZy7+/vfcGJgn4+EGN3SC7CLIxMjz4Hw1sxtKM6WBl/aqViSoyjdCGagSaM/XWdHqXhSSdwLVlubSEah03ZJoPJN8VvdtM0PCPRyjQy4Ahh4Pr8S09IVYiLxiyXrkG2SXY5kZOGbFJm1OIAvOQ1lg8+LZ72L+a4rG63WPYuaWnLaZaBDd+GpUhNZj0MTvRFMXBs9IutbZ0Rjj4yi4u8p4YFadYuZbHoVbEsLfSbNXiKK9GWJnsfkZ0UH+vk0VGT9Z2Q0Yze661Ohx/TU8UADQ9YdVz001JF5PNqvCWqKJqebylK4BQRfWz1AscA+I=
7c11ffb0-cdb7-4ae3-ae3a-f3f09ca68612	f10b2e12-4502-456c-ade7-f290c24df449	allowed-protocol-mapper-types	saml-user-attribute-mapper
76d5c9f7-9360-48d3-b874-573ad5cad367	f10b2e12-4502-456c-ade7-f290c24df449	allowed-protocol-mapper-types	oidc-full-name-mapper
d8a05229-3502-4ab3-9be2-7ee598f68ad8	f10b2e12-4502-456c-ade7-f290c24df449	allowed-protocol-mapper-types	oidc-address-mapper
28af47a6-2ff6-46e1-9349-ee8628e38102	f10b2e12-4502-456c-ade7-f290c24df449	consent-required-for-all-mappers	true
0c06893d-04e6-4bed-aedb-d7434c88c855	f10b2e12-4502-456c-ade7-f290c24df449	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0ae57745-a742-4675-87df-58b07bbc0159	f10b2e12-4502-456c-ade7-f290c24df449	allowed-protocol-mapper-types	saml-user-property-mapper
72556fc8-e6c7-4ff8-bcd1-1e44194a58c9	f10b2e12-4502-456c-ade7-f290c24df449	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f80cb9d5-20c7-4c4b-a922-4c5029c967f4	f10b2e12-4502-456c-ade7-f290c24df449	allowed-protocol-mapper-types	saml-role-list-mapper
b79e49e9-a8ab-46df-9cc7-6217151e5e6d	f10b2e12-4502-456c-ade7-f290c24df449	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
f078a301-aa4b-4c78-8240-d4d9f52c275e	a701f69b-62cd-4543-b9f8-bfdeef1884e4	secret	lVxV7uxaYaJBi5r5CI6xxUceaoSeKsADDdBkw9odYcQ
76ae5954-561b-4a71-8682-c85db9d7282c	a701f69b-62cd-4543-b9f8-bfdeef1884e4	kid	3e26288c-b58b-475f-b73b-07f3e40a8039
ef6e80bd-674d-4b59-a380-f7e53c4e1f9f	a701f69b-62cd-4543-b9f8-bfdeef1884e4	priority	100
79761d3f-fc84-4061-8e7c-a47f5a0acf74	cba69f5c-e507-4d2c-b423-b2b1743b0c4b	client-uris-must-match	true
ee8f9e12-6e41-4222-8236-0bbd34ed5faa	cba69f5c-e507-4d2c-b423-b2b1743b0c4b	host-sending-registration-request-must-match	true
28e639e5-edba-4a57-8baf-c30e925ef2b6	9476949f-fbaf-4852-b0ef-434cfedafc84	allowed-protocol-mapper-types	saml-user-attribute-mapper
9928d26b-cd12-4e6a-ada9-cf29eb6bee1f	9476949f-fbaf-4852-b0ef-434cfedafc84	allowed-protocol-mapper-types	saml-role-list-mapper
1c869cce-8d5d-4c37-a1fa-19cdbfc4c190	9476949f-fbaf-4852-b0ef-434cfedafc84	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c5f9e044-7690-411a-981e-0f6e173ea8d2	9476949f-fbaf-4852-b0ef-434cfedafc84	allowed-protocol-mapper-types	saml-user-property-mapper
a387c01e-6640-46e1-b3ad-9baff8808c52	9476949f-fbaf-4852-b0ef-434cfedafc84	consent-required-for-all-mappers	true
465173d2-945c-42a1-ba1f-cba63dbc3509	9476949f-fbaf-4852-b0ef-434cfedafc84	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
03f12618-820b-470b-aa01-9b559c5fa726	9476949f-fbaf-4852-b0ef-434cfedafc84	allowed-protocol-mapper-types	oidc-address-mapper
17a45c3c-8a71-461e-980e-fabea5300c47	9476949f-fbaf-4852-b0ef-434cfedafc84	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
176bdb1a-d735-4d2f-b35e-509c6a279212	9476949f-fbaf-4852-b0ef-434cfedafc84	allowed-protocol-mapper-types	oidc-full-name-mapper
d591d7e6-80a2-4779-9745-bbd3f159b5ba	45c2db2d-969e-482d-bd7b-c42820b7a354	kid	2e0d80f5-f475-4529-80bb-12108fbf7738
05348873-76e7-49eb-8836-14990be50916	45c2db2d-969e-482d-bd7b-c42820b7a354	secret	ck4lkYPvGEuHm0cAjhOf5Q
cd6f0b53-2623-431f-9de0-78ce0f655626	45c2db2d-969e-482d-bd7b-c42820b7a354	priority	100
c05d042b-44af-4301-8057-52461ec7077f	70e25b1b-653b-40c6-a30c-9b47e9d2da72	privateKey	MIIEpAIBAAKCAQEArREY6/XVWGHIoyhVdwl4CQSMXLM1ejxBU6GGXTi5MUmCX7nkvF2VTihz2Kb4GqToZ0CQa97g5Lj0KqN9ebHksnI5sHXk7QzHZLOwbkzCqoCDGpR0oB7uhY61e+ptRJiIdIdxAZrqseSiQy2mUFUCKVMVqbYuq/y2+HlTgOBf78sW8Po83QBAST5FpYZ/Apw7GXHja4IvfjS+J8C9lhvj2neySd3v80mTN1CZ27GPq3012gjaLr0Q0y0PfO6AFTeTrw18cUPjrFw174FWiM/WLGooW2k5Ku7fOJ+TgCxkcxnjYnaAtghf4B3Ud5ketMyh6MIxsSLU2g37QdHqptSrEwIDAQABAoIBAQCeRfeTu7QL6wlRZU6b2XYEUTuIf4AVtMtNj3fRA1IiKAbqQphUSAWGf+pKJZDa1RuRafNqI19q7VanM/NJew4av+nQXlEpFTm497gPd3XD9llv0nrCAOfEDtocZCzfwdtxLniDrkiavexDIZlq+ANNBaXXGjyenzQ6EsLyJsC2C3NxBd2zzckeSvIkTzZ43yRU4iGz982Gw/yPhQ8GwxYNxoeECw5EIyC5f1BR9JUw+ZypIq60Ai8NIBd8p/I50mseu+1Rx+84S7EysxxPKvgeVCRe6aw+Bqv97HgWdCL9NAneEDIK4DoO3a/hcEogmxdcL4EPaZT5rDYD04wBYXUxAoGBAOmH4Z75o4JtkHN9J0SwGe10N8BQR2IOqSEWdwP01hK5Ba0zKSwKlL5P0n3se1hFTyqxqRJG61/iuFuwVJogBzHVlHKJ75qdXj40ApTcXG0bXjZdu9fwWicVM2Lnljilk9GuFJmzaHyLac8gxeDbJ/edyDHrox+snHrnTDpGfMC7AoGBAL236+xQlNmEyJQnjf2qUM1qsyln9hnTTJs2LS+vXhU6fWFZuGPpLcYgj6tP4392R3n29lycqXJgVmhfnxwY791U+zklOB2/JRYcyQ0nnd2oqM45Dn3EQgbnGw+SGykEOMaIn2z3XUGQUrEkk7H1Cup1l4K0Po5XgZsBnfsEe6WJAoGAbr+qGCJ7kJc1Mg/gV4rMQPgkmGd58t7RBogI2S97dlWYg5MHq4M5FyfzwxQrSqlT6gNnEuvfJBH5LEJrXMxjnRaU19zibIjE8Orpbn8yteuMumupcbbiijZbsEPz0dl0SLQtwNZ8btQO0dPRA9nrElsZXdNKAPNzIjYeyGQ1NZECgYEAkOCmEmWK9f0Xq0P1g7QPVn7X6JPSdPBOPO0HXrXd8/ohizkXvXxxDy8IZ7tvMIQjmzkD879TCtwUwEndWHiWm//shTwt+VFhwdwjkJ8jSAUnO6yIq3Q3M8xCdwaNJSprLPliPbU9CvdqnoofG7PULS21kQOSDeM3Pybh/LH0tnkCgYBJMjaoZIXPE/0OA2vXp1KeP6O/BmEFuxJM4glkF6pMRm7jMklgIsx3QvhvSNkJ2dz8FiQKN5RbvkQksnaeuRj01S8fTBGi/xbyiKUFltKEym/OZdHQA3dAmZefA8zH1O6+mPIbQpwLL4xaYss9WkX1ZnNMB1gqcxXBjA3ptTx6/w==
83ac5853-5aca-4095-a60e-9547273bd5b5	70e25b1b-653b-40c6-a30c-9b47e9d2da72	priority	100
76f539b8-30b4-48d3-8c91-8c772c45a31a	70e25b1b-653b-40c6-a30c-9b47e9d2da72	certificate	MIICszCCAZsCBgFjsi+KxjANBgkqhkiG9w0BAQsFADAdMRswGQYDVQQDDBJTcHJpbmdCb290S2V5Q2xvYWswHhcNMTgwNTMwMTc1MjMwWhcNMjgwNTMwMTc1NDEwWjAdMRswGQYDVQQDDBJTcHJpbmdCb290S2V5Q2xvYWswggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCtERjr9dVYYcijKFV3CXgJBIxcszV6PEFToYZdOLkxSYJfueS8XZVOKHPYpvgapOhnQJBr3uDkuPQqo315seSycjmwdeTtDMdks7BuTMKqgIMalHSgHu6FjrV76m1EmIh0h3EBmuqx5KJDLaZQVQIpUxWpti6r/Lb4eVOA4F/vyxbw+jzdAEBJPkWlhn8CnDsZceNrgi9+NL4nwL2WG+Pad7JJ3e/zSZM3UJnbsY+rfTXaCNouvRDTLQ987oAVN5OvDXxxQ+OsXDXvgVaIz9YsaihbaTkq7t84n5OALGRzGeNidoC2CF/gHdR3mR60zKHowjGxItTaDftB0eqm1KsTAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEVZFFHPdzXwGB7YBaoJQ5YyHYseVerfA7jNm4Aa8pgiLgzh3ZKoY94MonUpGFE/4IGoHm76NvOta8B1azzlYgI1UL/HPf+uPDZRUOZR8BIjixcs4BT4uCG40TrI9ZDDF5rlWPQnPmrz1sIfZI8B83sRbUQ4+6D6VUpUgGISGJ2ggf0M9pmEKvXMAk8t2DGwbnD0Ir0+ZrPEPEQzX9hzfIzTyfczh1DhqD8R5rcO3VNeY7FBhI77gSG8sppaO33d9sMT0J1imZMGhViGj3v/ivtq7mZHFB04vbAO/5Q44d+r193/CjpiSqFh2SwpAEVYrNzJNJ7IwGmuLyQbdepbvgI=
56b9793d-0ce2-4115-8c33-9ec9e327269d	03ff3fa9-cda9-4a42-8662-b78f3b969f10	max-clients	200
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY composite_role (composite, child_role) FROM stdin;
b17d5b14-822c-411e-afd6-4df0ccaa49e7	d7ccc468-d9d2-4e71-97b4-6855d48bf919
b17d5b14-822c-411e-afd6-4df0ccaa49e7	97d8eb7f-ffb8-4415-87ee-69ecd4f1184f
b17d5b14-822c-411e-afd6-4df0ccaa49e7	70f35a85-8120-4371-a1cf-45fa76b4e757
b17d5b14-822c-411e-afd6-4df0ccaa49e7	8dc65e44-9a17-4f2e-b249-a7e51e255217
b17d5b14-822c-411e-afd6-4df0ccaa49e7	eade2bbd-d9dd-4375-9f24-22e8f9b3c58c
b17d5b14-822c-411e-afd6-4df0ccaa49e7	db58c4d5-940d-4c94-8d6e-3ac5bcc81602
b17d5b14-822c-411e-afd6-4df0ccaa49e7	bd7f9850-63ea-41c5-8fa0-360927991da7
b17d5b14-822c-411e-afd6-4df0ccaa49e7	9c00209c-c004-4c89-8603-77a8c96135e7
b17d5b14-822c-411e-afd6-4df0ccaa49e7	e1c00198-0f3d-4b1c-a771-fe7b6de0614e
b17d5b14-822c-411e-afd6-4df0ccaa49e7	a3301922-a433-4024-822c-4faf12706845
b17d5b14-822c-411e-afd6-4df0ccaa49e7	da9b79a4-cb13-41c4-8028-e87fc269c888
b17d5b14-822c-411e-afd6-4df0ccaa49e7	09b891db-0e65-468e-8a0c-1aaf41255efe
b17d5b14-822c-411e-afd6-4df0ccaa49e7	a31057a4-8a05-4e16-a9fb-93069fde892c
b17d5b14-822c-411e-afd6-4df0ccaa49e7	779d7656-27cb-4635-94a4-7e87db27ce4f
b17d5b14-822c-411e-afd6-4df0ccaa49e7	2775b78e-3554-4cf4-aaf4-7dd12cff935d
b17d5b14-822c-411e-afd6-4df0ccaa49e7	bc3f9e34-a8a0-4096-98e1-23a629a7b900
b17d5b14-822c-411e-afd6-4df0ccaa49e7	d9fd2b35-fd61-4ac0-8efb-37dacc83e5ac
b17d5b14-822c-411e-afd6-4df0ccaa49e7	336d9dd7-bdc1-4dd3-a702-5517a2e89ce1
8dc65e44-9a17-4f2e-b249-a7e51e255217	336d9dd7-bdc1-4dd3-a702-5517a2e89ce1
8dc65e44-9a17-4f2e-b249-a7e51e255217	2775b78e-3554-4cf4-aaf4-7dd12cff935d
eade2bbd-d9dd-4375-9f24-22e8f9b3c58c	bc3f9e34-a8a0-4096-98e1-23a629a7b900
1574210b-6a8c-4cdd-8fcc-67dd8e69263b	b6bdda9e-6577-4fa7-8ca4-ef0a2ef4d875
b17d5b14-822c-411e-afd6-4df0ccaa49e7	85015fe6-93bb-4f29-9982-c2aa88f76569
b17d5b14-822c-411e-afd6-4df0ccaa49e7	4f04e0b5-d7a2-416e-b908-3aa5deb57442
b17d5b14-822c-411e-afd6-4df0ccaa49e7	274ac771-ed5e-4712-9c4c-4c7731afa531
b17d5b14-822c-411e-afd6-4df0ccaa49e7	8e9c1998-e40d-4720-9ec6-d5018c5ea9d1
b17d5b14-822c-411e-afd6-4df0ccaa49e7	f1b9d336-a271-4711-9652-9cf5bf1ddc40
b17d5b14-822c-411e-afd6-4df0ccaa49e7	1ac253ad-86ea-4f99-849c-47663398fb21
b17d5b14-822c-411e-afd6-4df0ccaa49e7	6e2100ab-a017-41a4-a47a-b6081af578fa
b17d5b14-822c-411e-afd6-4df0ccaa49e7	118af1aa-a487-4819-bcf0-5bb6f3c896c6
b17d5b14-822c-411e-afd6-4df0ccaa49e7	a797a5d0-1e36-43fd-8060-831329620ae8
b17d5b14-822c-411e-afd6-4df0ccaa49e7	8ec55ccf-98a6-429a-a293-1b145d115361
b17d5b14-822c-411e-afd6-4df0ccaa49e7	ac753e4c-6ac8-4335-846f-2b7f124ad0aa
b17d5b14-822c-411e-afd6-4df0ccaa49e7	27ac6996-a1e3-4d17-97b8-5296bbe3eef2
b17d5b14-822c-411e-afd6-4df0ccaa49e7	a734db72-06dd-4d0c-99b1-c715fac03e35
b17d5b14-822c-411e-afd6-4df0ccaa49e7	00bc756c-172d-4a41-b6f7-ff9aa2a5ea32
b17d5b14-822c-411e-afd6-4df0ccaa49e7	9fa593b8-ee7f-4574-a7ce-ea31c26505f7
b17d5b14-822c-411e-afd6-4df0ccaa49e7	352dd068-9e2a-4f30-812e-5f9e5c40e513
b17d5b14-822c-411e-afd6-4df0ccaa49e7	07d00426-6501-4fd9-8762-e11eb0ecbfe1
b17d5b14-822c-411e-afd6-4df0ccaa49e7	e3c618b6-9774-4e87-8338-4f6e5328ea17
8e9c1998-e40d-4720-9ec6-d5018c5ea9d1	9fa593b8-ee7f-4574-a7ce-ea31c26505f7
8e9c1998-e40d-4720-9ec6-d5018c5ea9d1	e3c618b6-9774-4e87-8338-4f6e5328ea17
f1b9d336-a271-4711-9652-9cf5bf1ddc40	352dd068-9e2a-4f30-812e-5f9e5c40e513
1e4be939-1e43-488d-8e9b-a3795c1b5a89	9ecc68ef-85f4-40ec-a6f2-c81fdca75091
1e4be939-1e43-488d-8e9b-a3795c1b5a89	e4c91880-f3b6-46d2-ba33-4df88898c4db
87bee7ed-5679-4df9-ad88-5ff216f5bd23	8115f3c8-069d-4d8d-9fba-ab0dd9300fd9
71e3c67d-43f8-444d-9357-fd0b88d6b05c	9ecc68ef-85f4-40ec-a6f2-c81fdca75091
71e3c67d-43f8-444d-9357-fd0b88d6b05c	17e16aea-57dc-49c4-8a48-4eab76f05551
71e3c67d-43f8-444d-9357-fd0b88d6b05c	c305af1a-6785-4beb-86f6-42de784f7116
71e3c67d-43f8-444d-9357-fd0b88d6b05c	75dce5ff-fe19-4ff4-8603-4042108b5ded
71e3c67d-43f8-444d-9357-fd0b88d6b05c	c50780a5-952a-473b-9770-caf296873881
71e3c67d-43f8-444d-9357-fd0b88d6b05c	1e4be939-1e43-488d-8e9b-a3795c1b5a89
71e3c67d-43f8-444d-9357-fd0b88d6b05c	60385c89-37f6-4b51-ad2e-136c1c36fccf
71e3c67d-43f8-444d-9357-fd0b88d6b05c	608a3e76-b96a-4e17-bc39-c22e8ada3b47
71e3c67d-43f8-444d-9357-fd0b88d6b05c	4c7a6f46-2c3b-433d-a713-3c03f3b14457
71e3c67d-43f8-444d-9357-fd0b88d6b05c	e4c91880-f3b6-46d2-ba33-4df88898c4db
71e3c67d-43f8-444d-9357-fd0b88d6b05c	39fd159a-8348-4ab2-86b2-b4aa603219e5
71e3c67d-43f8-444d-9357-fd0b88d6b05c	8115f3c8-069d-4d8d-9fba-ab0dd9300fd9
71e3c67d-43f8-444d-9357-fd0b88d6b05c	87bee7ed-5679-4df9-ad88-5ff216f5bd23
71e3c67d-43f8-444d-9357-fd0b88d6b05c	c1a01825-0655-4dc8-9eb1-2810a9041a3b
71e3c67d-43f8-444d-9357-fd0b88d6b05c	cccf5a3e-abdb-433b-a2d4-0a4eb78c6c94
71e3c67d-43f8-444d-9357-fd0b88d6b05c	4639297c-00fc-4412-9f95-1205b9ef9132
71e3c67d-43f8-444d-9357-fd0b88d6b05c	94f4746b-ecca-48f7-8ea2-a3f4ad95291d
71e3c67d-43f8-444d-9357-fd0b88d6b05c	942d9048-3d3f-4ddb-93ca-4f2b90304c42
e16bcd42-358a-417e-a9a9-7d694391f47d	13a931a9-5aa8-4b94-943f-4e753e0dbb4f
b17d5b14-822c-411e-afd6-4df0ccaa49e7	18669573-2803-411a-b385-d7a7892338c8
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY credential (id, device, hash_iterations, salt, type, value, user_id, created_date, counter, digits, period, algorithm) FROM stdin;
cbbe7fa8-6f04-4bef-b52f-59c11b4e76cb	\N	27500	\\xcf73a7c70365a98b37455ab9c240616a	password	ajNxuC4y4YpA1Z45cmEGw8dvYQqbWkCg5gjt9bwzleP/ImyGZ4fHUppJJpoW1XVZgNvzK+KfjmX16rHEmkV/sQ==	b27f542c-87e3-47b1-9f13-be0351b7fab3	\N	0	0	0	pbkdf2-sha256
574a733a-1230-4024-ae1a-719c22b35d4b	\N	27500	\\x53b85a28c01a87a0f5a6abfe3c32aae3	password	z3/c4VB+VoRJNBjYqPz2e34TDDBbdkYTbo2Lkm6v8HBQpIprHedASce2EXnr8s6ElldogDWbxTSV1sTvOXaKiA==	e50d26ad-3724-4f05-badb-b2bcfd74fe34	1527702884536	0	0	0	pbkdf2-sha256
8fdf291a-77c8-406c-aa6c-aaf631c869b3	\N	27500	\\x2ff994e8ad89a55b401722cda7cff0ab	password	SuzbgrVOSPFr467LjQE87lb93NFxrBZeFaDAWMf+5QIAAp/FXK4B5pM/AYRHGcoXo7LXvoQqaUlFTOv4fYtAwA==	30439bb8-1a26-4700-8703-2db7196d654c	1527702914598	0	0	0	pbkdf2-sha256
\.


--
-- Data for Name: credential_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY credential_attribute (id, credential_id, name, value) FROM stdin;
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels) FROM stdin;
1.0.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2018-05-30 17:52:01.315042	1	EXECUTED	7:00a57f7a6fb456639b34e62972e0ec02	createTable (x29), addPrimaryKey (x21), addUniqueConstraint (x9), addForeignKeyConstraint (x32)		\N	3.4.1	\N	\N
1.0.0.Final	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2018-05-30 17:52:01.399742	2	MARK_RAN	7:f061c3934594ee60a9b2343f5100ae4e	createTable (x29), addPrimaryKey (x21), addUniqueConstraint (x6), addForeignKeyConstraint (x30)		\N	3.4.1	\N	\N
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2018-05-30 17:52:01.456104	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete (x3), createTable (x3), addColumn (x5), addPrimaryKey (x3), addForeignKeyConstraint (x3), customChange		\N	3.4.1	\N	\N
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2018-05-30 17:52:01.466222	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn		\N	3.4.1	\N	\N
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2018-05-30 17:52:01.561729	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete (x4), createTable (x8), addColumn (x2), addPrimaryKey (x6), addForeignKeyConstraint (x9), addUniqueConstraint (x2), addColumn, dropForeignKeyConstraint (x2), dropUniqueConstraint, renameColumn (x3), addUniqueConstraint, addForeignKeyConstra...		\N	3.4.1	\N	\N
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2018-05-30 17:52:01.57626	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete (x4), createTable (x8), addColumn (x2), addPrimaryKey (x6), addForeignKeyConstraint (x9), addUniqueConstraint (x2), addColumn, dropForeignKeyConstraint (x2), dropUniqueConstraint, renameColumn (x3), customChange, dropForeignKeyConstraint, d...		\N	3.4.1	\N	\N
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2018-05-30 17:52:01.669095	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete (x5), createTable (x3), addColumn, createTable (x4), addPrimaryKey (x7), addForeignKeyConstraint (x6), renameColumn, addColumn (x2), update, dropColumn, dropForeignKeyConstraint, renameColumn, addForeignKeyConstraint, dropForeignKeyConstrai...		\N	3.4.1	\N	\N
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2018-05-30 17:52:01.683375	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete (x5), createTable (x3), addColumn, createTable (x4), addPrimaryKey (x7), addForeignKeyConstraint (x6), renameColumn, addUniqueConstraint, addColumn (x2), update, dropColumn, dropForeignKeyConstraint, renameColumn, addForeignKeyConstraint, r...		\N	3.4.1	\N	\N
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2018-05-30 17:52:01.693174	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update (x3)		\N	3.4.1	\N	\N
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2018-05-30 17:52:01.810278	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete (x6), createTable (x7), addColumn, createTable, addColumn (x2), update, dropDefaultValue, dropColumn, addColumn, update (x4), addPrimaryKey (x4), dropPrimaryKey, dropColumn, addPrimaryKey (x4), addForeignKeyConstraint (x8), dropDefaultValue...		\N	3.4.1	\N	\N
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2018-05-30 17:52:01.887075	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete (x7), addColumn (x5), dropColumn, renameTable (x2), update (x10), createTable (x3), customChange, dropPrimaryKey, addPrimaryKey (x4), addForeignKeyConstraint (x2), dropColumn, addColumn		\N	3.4.1	\N	\N
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2018-05-30 17:52:01.897727	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete (x7), addColumn (x5), dropColumn, renameTable, dropForeignKeyConstraint, renameTable, addForeignKeyConstraint, update (x10), createTable (x3), customChange, dropPrimaryKey, addPrimaryKey (x4), addForeignKeyConstraint (x2), dropColumn, addCo...		\N	3.4.1	\N	\N
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2018-05-30 17:52:01.987736	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete (x7), dropDefaultValue, dropColumn, addColumn (x3)		\N	3.4.1	\N	\N
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2018-05-30 17:52:02.031613	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn (x3), createTable (x2), addPrimaryKey (x2)		\N	3.4.1	\N	\N
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2018-05-30 17:52:02.034158	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete (x2)		\N	3.4.1	\N	\N
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2018-05-30 17:52:02.036676	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey (x2), addColumn, update, dropColumn, addColumn, update, dropColumn, addPrimaryKey (x2)		\N	3.4.1	\N	\N
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2018-05-30 17:52:02.039713	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	Empty		\N	3.4.1	\N	\N
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2018-05-30 17:52:02.098524	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable (x5), addColumn (x2), dropDefaultValue, dropColumn, addPrimaryKey, addForeignKeyConstraint, addPrimaryKey, addForeignKeyConstraint, addPrimaryKey, addForeignKeyConstraint, addPrimaryKey, addForeignKeyConstraint (x2), addUniqueConstrain...		\N	3.4.1	\N	\N
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2018-05-30 17:52:02.165559	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn, createTable (x3), dropNotNullConstraint, addColumn (x2), createTable, addPrimaryKey, addUniqueConstraint, addForeignKeyConstraint (x5), addPrimaryKey, addForeignKeyConstraint (x2), addPrimaryKey, addForeignKeyConstraint, update		\N	3.4.1	\N	\N
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2018-05-30 17:52:02.172451	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue, update		\N	3.4.1	\N	\N
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2018-05-30 17:52:02.177019	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn, createTable (x3), dropNotNullConstraint, addColumn (x2), createTable, addPrimaryKey, addUniqueConstraint, addForeignKeyConstraint (x5), addPrimaryKey, addForeignKeyConstraint (x2), addPrimaryKey, addForeignKeyConstraint, update		\N	3.4.1	\N	\N
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2018-05-30 17:52:02.181208	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue, update		\N	3.4.1	\N	\N
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2018-05-30 17:52:02.197569	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update (x9), customChange, dropForeignKeyConstraint (x2), dropUniqueConstraint, dropTable, dropForeignKeyConstraint (x2), dropTable, dropForeignKeyConstraint (x2), dropUniqueConstraint, dropTable, createIndex		\N	3.4.1	\N	\N
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2018-05-30 17:52:02.203676	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType (x3)		\N	3.4.1	\N	\N
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2018-05-30 17:52:02.206091	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType (x2)		\N	3.4.1	\N	\N
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2018-05-30 17:52:02.231701	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex (x11)		\N	3.4.1	\N	\N
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2018-05-30 17:52:02.297009	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable, addPrimaryKey, addUniqueConstraint, createTable, addPrimaryKey, addForeignKeyConstraint, addUniqueConstraint, createTable, addPrimaryKey, addForeignKeyConstraint, addUniqueConstraint, createTable, addPrimaryKey, addForeignKeyConstrain...		\N	3.4.1	\N	\N
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2018-05-30 17:52:02.301835	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update		\N	3.4.1	\N	\N
2.1.0	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2018-05-30 17:52:02.352363	29	EXECUTED	7:e01599a82bf8d6dc22a9da506e22e868	createTable (x11), addPrimaryKey (x11), addForeignKeyConstraint (x2)		\N	3.4.1	\N	\N
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2018-05-30 17:52:02.37151	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn, createTable (x2), modifyDataType, addForeignKeyConstraint (x2)		\N	3.4.1	\N	\N
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2018-05-30 17:52:02.395025	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable, addPrimaryKey, dropDefaultValue, dropColumn, addColumn (x2), customChange, dropColumn (x4), addColumn		\N	3.4.1	\N	\N
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2018-05-30 17:52:02.400834	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.4.1	\N	\N
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2018-05-30 17:52:02.405901	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange, modifyDataType		\N	3.4.1	\N	\N
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2018-05-30 17:52:02.432623	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType (x13), addColumn, sql, dropColumn, renameColumn, modifyDataType (x2)		\N	3.4.1	\N	\N
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2018-05-30 17:52:02.456888	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType (x5), dropUniqueConstraint, modifyDataType (x3), addUniqueConstraint, dropPrimaryKey, modifyDataType, addNotNullConstraint, addPrimaryKey, modifyDataType (x5), dropUniqueConstraint, modifyDataType, addUniqueConstraint, modifyDataType		\N	3.4.1	\N	\N
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2018-05-30 17:52:02.475852	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn		\N	3.4.1	\N	\N
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2018-05-30 17:52:02.481367	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint		\N	3.4.1	\N	\N
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2018-05-30 17:52:02.485068	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn		\N	3.4.1	\N	\N
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2018-05-30 17:52:02.495222	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn		\N	3.4.1	\N	\N
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2018-05-30 17:52:02.497016	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint		\N	3.4.1	\N	\N
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2018-05-30 17:52:02.499235	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex, addNotNullConstraint, createIndex		\N	3.4.1	\N	\N
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2018-05-30 17:52:02.602465	42	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn, dropPrimaryKey, dropColumn, addPrimaryKey, createTable, addPrimaryKey, addForeignKeyConstraint, createIndex (x45)		\N	3.4.1	\N	\N
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2018-05-30 17:52:02.617681	43	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn		\N	3.4.1	\N	\N
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2018-05-30 17:52:02.62176	44	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn (x3)		\N	3.4.1	\N	\N
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2018-05-30 17:52:02.625677	45	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.4.1	\N	\N
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2018-05-30 17:52:02.627963	46	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex (x3)		\N	3.4.1	\N	\N
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2018-05-30 17:52:02.65641	47	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint (x3), dropUniqueConstraint (x3), dropForeignKeyConstraint, dropColumn, dropForeignKeyConstraint, dropColumn, dropForeignKeyConstraint, dropColumn, dropPrimaryKey, dropUniqueConstraint, dropColumn, renameColumn (x4), addUniqueC...		\N	3.4.1	\N	\N
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2018-05-30 17:52:02.671122	48	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn		\N	3.4.1	\N	\N
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2018-05-30 17:52:02.709272	49	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey (x7), dropForeignKeyConstraint, addPrimaryKey, addForeignKeyConstraint, addNotNullConstraint, addPrimaryKey, addNotNullConstraint, addPrimaryKey, addNotNullConstraint, addPrimaryKey, addNotNullConstraint, addPrimaryKey, addNotNullCon...		\N	3.4.1	\N	\N
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2018-05-30 17:52:02.738347	50	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex (x11)		\N	3.4.1	\N	\N
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2018-05-30 17:52:02.741966	51	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType		\N	3.4.1	\N	\N
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2018-05-30 17:52:02.74474	52	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update		\N	3.4.1	\N	\N
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2018-05-30 17:52:02.747205	53	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update		\N	3.4.1	\N	\N
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2018-05-30 17:52:02.753448	54	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable, addPrimaryKey		\N	3.4.1	\N	\N
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2018-05-30 17:52:02.758124	55	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable		\N	3.4.1	\N	\N
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2018-05-30 17:52:02.793823	56	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint, dropNotNullConstraint, addColumn, addUniqueConstraint, addColumn, dropNotNullConstraint, createIndex, addColumn, update (x2), dropPrimaryKey, addPrimaryKey		\N	3.4.1	\N	\N
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2018-05-30 17:52:02.828905	57	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable, addPrimaryKey, addForeignKeyConstraint (x3), addUniqueConstraint, addColumn (x4), createTable, addPrimaryKey, addForeignKeyConstraint		\N	3.4.1	\N	\N
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_credential_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY fed_credential_attribute (id, credential_id, name, value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY fed_user_consent_prot_mapper (user_consent_id, protocol_mapper_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY fed_user_consent_role (user_consent_id, role_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY fed_user_credential (id, device, hash_iterations, salt, type, value, created_date, counter, digits, period, algorithm, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm, scope_param_required) FROM stdin;
b17d5b14-822c-411e-afd6-4df0ccaa49e7	master	f	${role_admin}	admin	master	\N	master	f
d7ccc468-d9d2-4e71-97b4-6855d48bf919	master	f	${role_create-realm}	create-realm	master	\N	master	f
97d8eb7f-ffb8-4415-87ee-69ecd4f1184f	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_create-client}	create-client	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
70f35a85-8120-4371-a1cf-45fa76b4e757	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_view-realm}	view-realm	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
8dc65e44-9a17-4f2e-b249-a7e51e255217	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_view-users}	view-users	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
eade2bbd-d9dd-4375-9f24-22e8f9b3c58c	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_view-clients}	view-clients	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
db58c4d5-940d-4c94-8d6e-3ac5bcc81602	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_view-events}	view-events	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
bd7f9850-63ea-41c5-8fa0-360927991da7	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_view-identity-providers}	view-identity-providers	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
9c00209c-c004-4c89-8603-77a8c96135e7	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_view-authorization}	view-authorization	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
e1c00198-0f3d-4b1c-a771-fe7b6de0614e	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_manage-realm}	manage-realm	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
a3301922-a433-4024-822c-4faf12706845	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_manage-users}	manage-users	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
da9b79a4-cb13-41c4-8028-e87fc269c888	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_manage-clients}	manage-clients	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
09b891db-0e65-468e-8a0c-1aaf41255efe	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_manage-events}	manage-events	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
a31057a4-8a05-4e16-a9fb-93069fde892c	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_manage-identity-providers}	manage-identity-providers	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
779d7656-27cb-4635-94a4-7e87db27ce4f	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_manage-authorization}	manage-authorization	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
2775b78e-3554-4cf4-aaf4-7dd12cff935d	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_query-users}	query-users	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
bc3f9e34-a8a0-4096-98e1-23a629a7b900	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_query-clients}	query-clients	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
d9fd2b35-fd61-4ac0-8efb-37dacc83e5ac	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_query-realms}	query-realms	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
336d9dd7-bdc1-4dd3-a702-5517a2e89ce1	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_query-groups}	query-groups	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
575dcaa1-2cf2-45c3-979f-d22892300b68	cf524dc9-a8c9-48f8-9d27-cde21540af72	t	${role_view-profile}	view-profile	master	cf524dc9-a8c9-48f8-9d27-cde21540af72	\N	f
1574210b-6a8c-4cdd-8fcc-67dd8e69263b	cf524dc9-a8c9-48f8-9d27-cde21540af72	t	${role_manage-account}	manage-account	master	cf524dc9-a8c9-48f8-9d27-cde21540af72	\N	f
b6bdda9e-6577-4fa7-8ca4-ef0a2ef4d875	cf524dc9-a8c9-48f8-9d27-cde21540af72	t	${role_manage-account-links}	manage-account-links	master	cf524dc9-a8c9-48f8-9d27-cde21540af72	\N	f
298d0fd0-db19-4049-a359-6c22060175e2	cedf9f44-af93-41b6-941a-8139f712b663	t	${role_read-token}	read-token	master	cedf9f44-af93-41b6-941a-8139f712b663	\N	f
85015fe6-93bb-4f29-9982-c2aa88f76569	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	t	${role_impersonation}	impersonation	master	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N	f
6c78737f-b02b-4ed7-8b72-decfb4cb726f	master	f	${role_offline-access}	offline_access	master	\N	master	t
96857654-4eda-468a-a622-60b4224db42a	master	f	${role_uma_authorization}	uma_authorization	master	\N	master	f
4f04e0b5-d7a2-416e-b908-3aa5deb57442	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_create-client}	create-client	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
274ac771-ed5e-4712-9c4c-4c7731afa531	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_view-realm}	view-realm	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
8e9c1998-e40d-4720-9ec6-d5018c5ea9d1	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_view-users}	view-users	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
f1b9d336-a271-4711-9652-9cf5bf1ddc40	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_view-clients}	view-clients	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
1ac253ad-86ea-4f99-849c-47663398fb21	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_view-events}	view-events	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
6e2100ab-a017-41a4-a47a-b6081af578fa	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_view-identity-providers}	view-identity-providers	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
118af1aa-a487-4819-bcf0-5bb6f3c896c6	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_view-authorization}	view-authorization	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
a797a5d0-1e36-43fd-8060-831329620ae8	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_manage-realm}	manage-realm	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
8ec55ccf-98a6-429a-a293-1b145d115361	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_manage-users}	manage-users	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
ac753e4c-6ac8-4335-846f-2b7f124ad0aa	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_manage-clients}	manage-clients	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
27ac6996-a1e3-4d17-97b8-5296bbe3eef2	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_manage-events}	manage-events	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
a734db72-06dd-4d0c-99b1-c715fac03e35	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_manage-identity-providers}	manage-identity-providers	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
00bc756c-172d-4a41-b6f7-ff9aa2a5ea32	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_manage-authorization}	manage-authorization	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
9fa593b8-ee7f-4574-a7ce-ea31c26505f7	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_query-users}	query-users	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
352dd068-9e2a-4f30-812e-5f9e5c40e513	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_query-clients}	query-clients	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
07d00426-6501-4fd9-8762-e11eb0ecbfe1	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_query-realms}	query-realms	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
e3c618b6-9774-4e87-8338-4f6e5328ea17	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_query-groups}	query-groups	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
063442b9-4f67-4770-b8fc-6cf0af5b4462	SpringBootKeyCloak	f	${role_offline-access}	offline_access	SpringBootKeyCloak	\N	SpringBootKeyCloak	t
fef9f73a-e516-4984-bf5e-06aaf31f0477	SpringBootKeyCloak	f	These are non-vakt members	Customer	SpringBootKeyCloak	\N	SpringBootKeyCloak	f
764b0ae8-9433-42fb-b232-92109948f487	SpringBootKeyCloak	f	${role_uma_authorization}	uma_authorization	SpringBootKeyCloak	\N	SpringBootKeyCloak	f
e784a675-df65-4cfc-bde7-807d3b808f42	SpringBootKeyCloak	f	These are vakt-members	Member	SpringBootKeyCloak	\N	SpringBootKeyCloak	t
9ecc68ef-85f4-40ec-a6f2-c81fdca75091	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_query-groups}	query-groups	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
17e16aea-57dc-49c4-8a48-4eab76f05551	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_query-realms}	query-realms	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
c305af1a-6785-4beb-86f6-42de784f7116	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_manage-authorization}	manage-authorization	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
c50780a5-952a-473b-9770-caf296873881	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_manage-clients}	manage-clients	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
75dce5ff-fe19-4ff4-8603-4042108b5ded	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_manage-users}	manage-users	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
1e4be939-1e43-488d-8e9b-a3795c1b5a89	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_view-users}	view-users	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
608a3e76-b96a-4e17-bc39-c22e8ada3b47	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_create-client}	create-client	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
60385c89-37f6-4b51-ad2e-136c1c36fccf	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_view-identity-providers}	view-identity-providers	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
4c7a6f46-2c3b-433d-a713-3c03f3b14457	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_manage-events}	manage-events	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
e4c91880-f3b6-46d2-ba33-4df88898c4db	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_query-users}	query-users	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
8115f3c8-069d-4d8d-9fba-ab0dd9300fd9	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_query-clients}	query-clients	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
39fd159a-8348-4ab2-86b2-b4aa603219e5	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_impersonation}	impersonation	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
87bee7ed-5679-4df9-ad88-5ff216f5bd23	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_view-clients}	view-clients	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
71e3c67d-43f8-444d-9357-fd0b88d6b05c	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_realm-admin}	realm-admin	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
c1a01825-0655-4dc8-9eb1-2810a9041a3b	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_view-authorization}	view-authorization	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
cccf5a3e-abdb-433b-a2d4-0a4eb78c6c94	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_view-events}	view-events	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
94f4746b-ecca-48f7-8ea2-a3f4ad95291d	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_manage-identity-providers}	manage-identity-providers	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
4639297c-00fc-4412-9f95-1205b9ef9132	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_manage-realm}	manage-realm	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
942d9048-3d3f-4ddb-93ca-4f2b90304c42	1bed78cc-2952-4fff-8a42-4f06039e5543	t	${role_view-realm}	view-realm	SpringBootKeyCloak	1bed78cc-2952-4fff-8a42-4f06039e5543	\N	f
e132e410-0300-4717-befd-4ef9293091a8	6410d274-5f23-45e8-94fe-753fbec9fb58	t	\N	CUSTOMER	SpringBootKeyCloak	6410d274-5f23-45e8-94fe-753fbec9fb58	\N	t
9211a950-6584-476d-b0f0-b2b66a98fbc9	6410d274-5f23-45e8-94fe-753fbec9fb58	t	\N	MEMBER	SpringBootKeyCloak	6410d274-5f23-45e8-94fe-753fbec9fb58	\N	t
5a366fc8-c614-4517-b9b7-1d59aced130c	eafa763b-e07b-4bd0-b6a3-7a2061f7b627	t	${role_read-token}	read-token	SpringBootKeyCloak	eafa763b-e07b-4bd0-b6a3-7a2061f7b627	\N	f
e16bcd42-358a-417e-a9a9-7d694391f47d	9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	t	${role_manage-account}	manage-account	SpringBootKeyCloak	9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	\N	f
13a931a9-5aa8-4b94-943f-4e753e0dbb4f	9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	t	${role_manage-account-links}	manage-account-links	SpringBootKeyCloak	9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	\N	f
fbecb1cf-3235-42b1-bea1-f0c8744741c2	9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	t	${role_view-profile}	view-profile	SpringBootKeyCloak	9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	\N	f
18669573-2803-411a-b385-d7a7892338c8	7339dc51-b089-4891-8917-fc48dbf1ed2e	t	${role_impersonation}	impersonation	master	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N	f
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY migration_model (id, version) FROM stdin;
SINGLETON	3.4.2
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY offline_user_session (user_session_id, user_id, realm_id, last_session_refresh, offline_flag, data) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY protocol_mapper (id, name, protocol, protocol_mapper_name, consent_required, consent_text, client_id, client_template_id) FROM stdin;
c0490f99-f702-47a0-9520-386103fc96dc	role list	saml	saml-role-list-mapper	f	\N	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N
80ec2de8-659c-4dec-b170-0b31b0a7e720	username	openid-connect	oidc-usermodel-property-mapper	t	${username}	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N
4824be97-14e5-46de-b83b-bd2b7cfc9e91	email	openid-connect	oidc-usermodel-property-mapper	t	${email}	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N
b6aa23ad-6920-46c5-ab9b-4d42b35ad9d0	given name	openid-connect	oidc-usermodel-property-mapper	t	${givenName}	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N
bff31a99-0225-423f-a8f0-02fadb9c2cd3	family name	openid-connect	oidc-usermodel-property-mapper	t	${familyName}	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N
be231f65-7950-4a12-a609-b5871b92623a	full name	openid-connect	oidc-full-name-mapper	t	${fullName}	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	\N
b66422ca-bc4b-4425-9e20-6270d53c426e	role list	saml	saml-role-list-mapper	f	\N	cf524dc9-a8c9-48f8-9d27-cde21540af72	\N
9a7617cd-44e2-4a8c-a05b-b05aa114b5d3	username	openid-connect	oidc-usermodel-property-mapper	t	${username}	cf524dc9-a8c9-48f8-9d27-cde21540af72	\N
4a1b3c8e-89e0-426f-9b5e-131c0779e65b	email	openid-connect	oidc-usermodel-property-mapper	t	${email}	cf524dc9-a8c9-48f8-9d27-cde21540af72	\N
a9573809-99fb-4af1-ad0b-894364cc77ce	given name	openid-connect	oidc-usermodel-property-mapper	t	${givenName}	cf524dc9-a8c9-48f8-9d27-cde21540af72	\N
61df9dfd-5ef7-4a11-8bd8-78908a9f08f0	family name	openid-connect	oidc-usermodel-property-mapper	t	${familyName}	cf524dc9-a8c9-48f8-9d27-cde21540af72	\N
72edd40e-1c15-4f97-8fa0-ac3b11096f2f	full name	openid-connect	oidc-full-name-mapper	t	${fullName}	cf524dc9-a8c9-48f8-9d27-cde21540af72	\N
9906306b-f3b1-45bf-bc20-66683ba9bafd	role list	saml	saml-role-list-mapper	f	\N	cedf9f44-af93-41b6-941a-8139f712b663	\N
529fd941-0124-421a-8714-e800503326a1	username	openid-connect	oidc-usermodel-property-mapper	t	${username}	cedf9f44-af93-41b6-941a-8139f712b663	\N
1c6435e3-78ae-4913-b6af-92c8e845a204	email	openid-connect	oidc-usermodel-property-mapper	t	${email}	cedf9f44-af93-41b6-941a-8139f712b663	\N
b7f28ec0-e7ef-4f91-bb3c-eaf9b0c9e99c	given name	openid-connect	oidc-usermodel-property-mapper	t	${givenName}	cedf9f44-af93-41b6-941a-8139f712b663	\N
63797afa-3ca3-44bb-8c42-f0265a486ca5	family name	openid-connect	oidc-usermodel-property-mapper	t	${familyName}	cedf9f44-af93-41b6-941a-8139f712b663	\N
0ac12e6f-5f26-4022-a5da-7a2c6a021361	full name	openid-connect	oidc-full-name-mapper	t	${fullName}	cedf9f44-af93-41b6-941a-8139f712b663	\N
e6bf192b-7cf9-43ed-be15-43bd8ba80276	role list	saml	saml-role-list-mapper	f	\N	162d497a-6ba1-4a71-a14d-4ec45b457ae6	\N
805d7b5a-9a1c-45bb-afa0-7fd5b61c7ce5	username	openid-connect	oidc-usermodel-property-mapper	t	${username}	162d497a-6ba1-4a71-a14d-4ec45b457ae6	\N
a0532f64-cef6-499f-a5b4-8d86d7e65ce2	email	openid-connect	oidc-usermodel-property-mapper	t	${email}	162d497a-6ba1-4a71-a14d-4ec45b457ae6	\N
f1ea2bf6-9823-4c8a-be7a-1352785d3e5b	given name	openid-connect	oidc-usermodel-property-mapper	t	${givenName}	162d497a-6ba1-4a71-a14d-4ec45b457ae6	\N
a3ccf020-feae-4c19-8a9e-ac13459b7112	family name	openid-connect	oidc-usermodel-property-mapper	t	${familyName}	162d497a-6ba1-4a71-a14d-4ec45b457ae6	\N
0fcf2155-8334-44e1-ad4d-58b57d121bc9	full name	openid-connect	oidc-full-name-mapper	t	${fullName}	162d497a-6ba1-4a71-a14d-4ec45b457ae6	\N
0d892a2f-6b01-49b5-95e6-a87e2b20daff	locale	openid-connect	oidc-usermodel-attribute-mapper	f	${locale}	162d497a-6ba1-4a71-a14d-4ec45b457ae6	\N
71973f51-9ce1-408a-b34a-0d23bcf36182	role list	saml	saml-role-list-mapper	f	\N	f4adffef-cb04-4c85-837a-594bcf345e75	\N
9346d727-0cf4-4ed8-bf34-35cb28288257	username	openid-connect	oidc-usermodel-property-mapper	t	${username}	f4adffef-cb04-4c85-837a-594bcf345e75	\N
4e984b69-6681-4626-8532-e50554c0db1b	email	openid-connect	oidc-usermodel-property-mapper	t	${email}	f4adffef-cb04-4c85-837a-594bcf345e75	\N
1df5e92a-295a-4847-b597-d780e5bf454f	given name	openid-connect	oidc-usermodel-property-mapper	t	${givenName}	f4adffef-cb04-4c85-837a-594bcf345e75	\N
c4c4085d-a7a3-41db-8332-4d6423e2fafb	family name	openid-connect	oidc-usermodel-property-mapper	t	${familyName}	f4adffef-cb04-4c85-837a-594bcf345e75	\N
637a96ca-d6df-4c4a-a5e6-95234b093a1c	full name	openid-connect	oidc-full-name-mapper	t	${fullName}	f4adffef-cb04-4c85-837a-594bcf345e75	\N
f42803e4-4a00-4d98-bb68-3289467c6848	role list	saml	saml-role-list-mapper	f	\N	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N
b16f092e-1c49-42a9-a034-422968d3f01d	username	openid-connect	oidc-usermodel-property-mapper	t	${username}	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N
f6855fb7-56d6-43ca-b281-f5d9c222d57c	email	openid-connect	oidc-usermodel-property-mapper	t	${email}	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N
b3d45c2d-a6d1-428f-9f45-0588af519f06	given name	openid-connect	oidc-usermodel-property-mapper	t	${givenName}	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N
5143e7f2-001d-47f0-b573-eba51d35821a	family name	openid-connect	oidc-usermodel-property-mapper	t	${familyName}	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N
70710c5a-2062-44b5-b679-f1942cf05560	full name	openid-connect	oidc-full-name-mapper	t	${fullName}	7339dc51-b089-4891-8917-fc48dbf1ed2e	\N
fe9212b5-7c83-404e-8f27-620590a4b04a	role list	saml	saml-role-list-mapper	f	\N	0a7b8751-0939-430f-b9b0-450d5b8e0a36	\N
92a6309c-c567-460e-9c1f-86433fb85d5e	family name	openid-connect	oidc-usermodel-property-mapper	t	${familyName}	0a7b8751-0939-430f-b9b0-450d5b8e0a36	\N
06141e7d-4400-449e-9ce1-f23cd954d8e7	given name	openid-connect	oidc-usermodel-property-mapper	t	${givenName}	0a7b8751-0939-430f-b9b0-450d5b8e0a36	\N
bab1a602-9d2b-46db-8bb7-264e0ad17c46	username	openid-connect	oidc-usermodel-property-mapper	t	${username}	0a7b8751-0939-430f-b9b0-450d5b8e0a36	\N
ecc2910c-0227-41ff-9356-d6d9d9b16ab1	full name	openid-connect	oidc-full-name-mapper	t	${fullName}	0a7b8751-0939-430f-b9b0-450d5b8e0a36	\N
3d8663e5-07af-4870-9a9a-978b7f2e9818	email	openid-connect	oidc-usermodel-property-mapper	t	${email}	0a7b8751-0939-430f-b9b0-450d5b8e0a36	\N
4a0e3ba2-f265-492d-bb38-ca53396a6ada	locale	openid-connect	oidc-usermodel-attribute-mapper	f	${locale}	0a7b8751-0939-430f-b9b0-450d5b8e0a36	\N
f0085db6-d0c1-47d5-8eaa-02e8c3d9c793	family name	openid-connect	oidc-usermodel-property-mapper	t	${familyName}	65488c37-d3e4-4ee3-b1a1-76e404c6658a	\N
a4a108d4-8c63-492f-893a-b441f2529b64	role list	saml	saml-role-list-mapper	f	\N	65488c37-d3e4-4ee3-b1a1-76e404c6658a	\N
39ef8193-3227-4e80-8005-d13a0e004397	given name	openid-connect	oidc-usermodel-property-mapper	t	${givenName}	65488c37-d3e4-4ee3-b1a1-76e404c6658a	\N
b6edaa07-cb36-42f5-9ffa-d7e443b06cd6	full name	openid-connect	oidc-full-name-mapper	t	${fullName}	65488c37-d3e4-4ee3-b1a1-76e404c6658a	\N
8eb418ad-f663-4e50-bcf8-0a7b7ebf3ec8	email	openid-connect	oidc-usermodel-property-mapper	t	${email}	65488c37-d3e4-4ee3-b1a1-76e404c6658a	\N
056da5b0-c399-4037-bff1-b72a45a120ca	username	openid-connect	oidc-usermodel-property-mapper	t	${username}	65488c37-d3e4-4ee3-b1a1-76e404c6658a	\N
c1e82bed-b47a-44bd-a6a4-eace95d2cc55	username	openid-connect	oidc-usermodel-property-mapper	t	${username}	eafa763b-e07b-4bd0-b6a3-7a2061f7b627	\N
0a089618-d5bb-4ee3-9fb6-989f03b3b98c	given name	openid-connect	oidc-usermodel-property-mapper	t	${givenName}	eafa763b-e07b-4bd0-b6a3-7a2061f7b627	\N
2f78e702-858b-4fd7-b9ec-352638bbcd34	email	openid-connect	oidc-usermodel-property-mapper	t	${email}	eafa763b-e07b-4bd0-b6a3-7a2061f7b627	\N
281c33df-a98e-4698-b6f0-d37eaf98b770	full name	openid-connect	oidc-full-name-mapper	t	${fullName}	eafa763b-e07b-4bd0-b6a3-7a2061f7b627	\N
2b93db77-c7e0-4b82-971b-54b3561e86cf	role list	saml	saml-role-list-mapper	f	\N	eafa763b-e07b-4bd0-b6a3-7a2061f7b627	\N
dc640089-785e-40ec-9a91-ba4f77a2d814	family name	openid-connect	oidc-usermodel-property-mapper	t	${familyName}	eafa763b-e07b-4bd0-b6a3-7a2061f7b627	\N
dceb0ce7-0da6-4bf8-abf3-c23289b3ecae	full name	openid-connect	oidc-full-name-mapper	t	${fullName}	6410d274-5f23-45e8-94fe-753fbec9fb58	\N
ffb9c5a4-5a5e-4bc1-bee7-95e5a56e5218	email	openid-connect	oidc-usermodel-property-mapper	t	${email}	6410d274-5f23-45e8-94fe-753fbec9fb58	\N
d75cf70e-36e7-4d3e-8f04-75350610d6e0	given name	openid-connect	oidc-usermodel-property-mapper	t	${givenName}	6410d274-5f23-45e8-94fe-753fbec9fb58	\N
a654590b-8b34-4cf8-b772-21e96ca0a2a8	username	openid-connect	oidc-usermodel-property-mapper	t	${username}	6410d274-5f23-45e8-94fe-753fbec9fb58	\N
fb3da645-ff64-4214-a793-d63c16e9c8cf	family name	openid-connect	oidc-usermodel-property-mapper	t	${familyName}	6410d274-5f23-45e8-94fe-753fbec9fb58	\N
bd63107b-0234-4657-902e-606030a088f7	authorities	openid-connect	oidc-usermodel-client-role-mapper	f	\N	6410d274-5f23-45e8-94fe-753fbec9fb58	\N
c309813e-fc11-42e1-9551-6e75b948eee4	role list	saml	saml-role-list-mapper	f	\N	6410d274-5f23-45e8-94fe-753fbec9fb58	\N
a6834b6e-f021-433d-abe8-440816af026b	role list	saml	saml-role-list-mapper	f	\N	1bed78cc-2952-4fff-8a42-4f06039e5543	\N
15d265bf-f650-4fd1-b4cc-3209e6fed2a0	given name	openid-connect	oidc-usermodel-property-mapper	t	${givenName}	1bed78cc-2952-4fff-8a42-4f06039e5543	\N
2a8e5cf4-f214-4e0f-b251-04d0c493054a	full name	openid-connect	oidc-full-name-mapper	t	${fullName}	1bed78cc-2952-4fff-8a42-4f06039e5543	\N
b4531e0a-2618-4391-9e33-44ea6c5a3c0a	username	openid-connect	oidc-usermodel-property-mapper	t	${username}	1bed78cc-2952-4fff-8a42-4f06039e5543	\N
0ef782de-e019-4e8d-8162-52b407866eee	email	openid-connect	oidc-usermodel-property-mapper	t	${email}	1bed78cc-2952-4fff-8a42-4f06039e5543	\N
f715a34d-4e48-494a-92d1-ee53970f361c	family name	openid-connect	oidc-usermodel-property-mapper	t	${familyName}	1bed78cc-2952-4fff-8a42-4f06039e5543	\N
29a15d1e-bacd-4361-beca-a81fed97cdd6	username	openid-connect	oidc-usermodel-property-mapper	t	${username}	b9c482ca-a12c-4af3-9e70-07c23d98a085	\N
f4f7859c-0a1b-477d-b261-8fd5107937b5	family name	openid-connect	oidc-usermodel-property-mapper	t	${familyName}	b9c482ca-a12c-4af3-9e70-07c23d98a085	\N
d7099dca-caaf-4170-8a4e-87c15d30a18c	role list	saml	saml-role-list-mapper	f	\N	b9c482ca-a12c-4af3-9e70-07c23d98a085	\N
a1fbdc9c-f70f-4a24-9bbc-e274157b82bb	full name	openid-connect	oidc-full-name-mapper	t	${fullName}	b9c482ca-a12c-4af3-9e70-07c23d98a085	\N
49a86a76-9f9c-4f69-9ef3-ca1de1ae7d9f	given name	openid-connect	oidc-usermodel-property-mapper	t	${givenName}	b9c482ca-a12c-4af3-9e70-07c23d98a085	\N
a66c042c-ef52-49bb-8ab8-fb3a8a275a40	email	openid-connect	oidc-usermodel-property-mapper	t	${email}	b9c482ca-a12c-4af3-9e70-07c23d98a085	\N
c86e9db5-1f25-449a-9a92-c4ba6c6a01fb	username	openid-connect	oidc-usermodel-property-mapper	t	${username}	9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	\N
cc1ef1cf-9a29-4b9b-bf8c-1e3738122224	role list	saml	saml-role-list-mapper	f	\N	9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	\N
9815244e-4a3a-49f4-af33-0f04f69999c0	given name	openid-connect	oidc-usermodel-property-mapper	t	${givenName}	9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	\N
ca74a093-cf46-419d-9fea-6b26901e77ec	email	openid-connect	oidc-usermodel-property-mapper	t	${email}	9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	\N
0d25eb52-be59-4496-8ef6-4040705c345e	full name	openid-connect	oidc-full-name-mapper	t	${fullName}	9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	\N
445bbcb5-b8f8-4662-ac47-e5cf29440022	family name	openid-connect	oidc-usermodel-property-mapper	t	${familyName}	9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
c0490f99-f702-47a0-9520-386103fc96dc	false	single
c0490f99-f702-47a0-9520-386103fc96dc	Basic	attribute.nameformat
c0490f99-f702-47a0-9520-386103fc96dc	Role	attribute.name
80ec2de8-659c-4dec-b170-0b31b0a7e720	true	userinfo.token.claim
80ec2de8-659c-4dec-b170-0b31b0a7e720	username	user.attribute
80ec2de8-659c-4dec-b170-0b31b0a7e720	true	id.token.claim
80ec2de8-659c-4dec-b170-0b31b0a7e720	true	access.token.claim
80ec2de8-659c-4dec-b170-0b31b0a7e720	preferred_username	claim.name
80ec2de8-659c-4dec-b170-0b31b0a7e720	String	jsonType.label
4824be97-14e5-46de-b83b-bd2b7cfc9e91	true	userinfo.token.claim
4824be97-14e5-46de-b83b-bd2b7cfc9e91	email	user.attribute
4824be97-14e5-46de-b83b-bd2b7cfc9e91	true	id.token.claim
4824be97-14e5-46de-b83b-bd2b7cfc9e91	true	access.token.claim
4824be97-14e5-46de-b83b-bd2b7cfc9e91	email	claim.name
4824be97-14e5-46de-b83b-bd2b7cfc9e91	String	jsonType.label
b6aa23ad-6920-46c5-ab9b-4d42b35ad9d0	true	userinfo.token.claim
b6aa23ad-6920-46c5-ab9b-4d42b35ad9d0	firstName	user.attribute
b6aa23ad-6920-46c5-ab9b-4d42b35ad9d0	true	id.token.claim
b6aa23ad-6920-46c5-ab9b-4d42b35ad9d0	true	access.token.claim
b6aa23ad-6920-46c5-ab9b-4d42b35ad9d0	given_name	claim.name
b6aa23ad-6920-46c5-ab9b-4d42b35ad9d0	String	jsonType.label
bff31a99-0225-423f-a8f0-02fadb9c2cd3	true	userinfo.token.claim
bff31a99-0225-423f-a8f0-02fadb9c2cd3	lastName	user.attribute
bff31a99-0225-423f-a8f0-02fadb9c2cd3	true	id.token.claim
bff31a99-0225-423f-a8f0-02fadb9c2cd3	true	access.token.claim
bff31a99-0225-423f-a8f0-02fadb9c2cd3	family_name	claim.name
bff31a99-0225-423f-a8f0-02fadb9c2cd3	String	jsonType.label
be231f65-7950-4a12-a609-b5871b92623a	true	id.token.claim
be231f65-7950-4a12-a609-b5871b92623a	true	access.token.claim
b66422ca-bc4b-4425-9e20-6270d53c426e	false	single
b66422ca-bc4b-4425-9e20-6270d53c426e	Basic	attribute.nameformat
b66422ca-bc4b-4425-9e20-6270d53c426e	Role	attribute.name
9a7617cd-44e2-4a8c-a05b-b05aa114b5d3	true	userinfo.token.claim
9a7617cd-44e2-4a8c-a05b-b05aa114b5d3	username	user.attribute
9a7617cd-44e2-4a8c-a05b-b05aa114b5d3	true	id.token.claim
9a7617cd-44e2-4a8c-a05b-b05aa114b5d3	true	access.token.claim
9a7617cd-44e2-4a8c-a05b-b05aa114b5d3	preferred_username	claim.name
9a7617cd-44e2-4a8c-a05b-b05aa114b5d3	String	jsonType.label
4a1b3c8e-89e0-426f-9b5e-131c0779e65b	true	userinfo.token.claim
4a1b3c8e-89e0-426f-9b5e-131c0779e65b	email	user.attribute
4a1b3c8e-89e0-426f-9b5e-131c0779e65b	true	id.token.claim
4a1b3c8e-89e0-426f-9b5e-131c0779e65b	true	access.token.claim
4a1b3c8e-89e0-426f-9b5e-131c0779e65b	email	claim.name
4a1b3c8e-89e0-426f-9b5e-131c0779e65b	String	jsonType.label
a9573809-99fb-4af1-ad0b-894364cc77ce	true	userinfo.token.claim
a9573809-99fb-4af1-ad0b-894364cc77ce	firstName	user.attribute
a9573809-99fb-4af1-ad0b-894364cc77ce	true	id.token.claim
a9573809-99fb-4af1-ad0b-894364cc77ce	true	access.token.claim
a9573809-99fb-4af1-ad0b-894364cc77ce	given_name	claim.name
a9573809-99fb-4af1-ad0b-894364cc77ce	String	jsonType.label
61df9dfd-5ef7-4a11-8bd8-78908a9f08f0	true	userinfo.token.claim
61df9dfd-5ef7-4a11-8bd8-78908a9f08f0	lastName	user.attribute
61df9dfd-5ef7-4a11-8bd8-78908a9f08f0	true	id.token.claim
61df9dfd-5ef7-4a11-8bd8-78908a9f08f0	true	access.token.claim
61df9dfd-5ef7-4a11-8bd8-78908a9f08f0	family_name	claim.name
61df9dfd-5ef7-4a11-8bd8-78908a9f08f0	String	jsonType.label
72edd40e-1c15-4f97-8fa0-ac3b11096f2f	true	id.token.claim
72edd40e-1c15-4f97-8fa0-ac3b11096f2f	true	access.token.claim
9906306b-f3b1-45bf-bc20-66683ba9bafd	false	single
9906306b-f3b1-45bf-bc20-66683ba9bafd	Basic	attribute.nameformat
9906306b-f3b1-45bf-bc20-66683ba9bafd	Role	attribute.name
529fd941-0124-421a-8714-e800503326a1	true	userinfo.token.claim
529fd941-0124-421a-8714-e800503326a1	username	user.attribute
529fd941-0124-421a-8714-e800503326a1	true	id.token.claim
529fd941-0124-421a-8714-e800503326a1	true	access.token.claim
529fd941-0124-421a-8714-e800503326a1	preferred_username	claim.name
529fd941-0124-421a-8714-e800503326a1	String	jsonType.label
1c6435e3-78ae-4913-b6af-92c8e845a204	true	userinfo.token.claim
1c6435e3-78ae-4913-b6af-92c8e845a204	email	user.attribute
1c6435e3-78ae-4913-b6af-92c8e845a204	true	id.token.claim
1c6435e3-78ae-4913-b6af-92c8e845a204	true	access.token.claim
1c6435e3-78ae-4913-b6af-92c8e845a204	email	claim.name
1c6435e3-78ae-4913-b6af-92c8e845a204	String	jsonType.label
b7f28ec0-e7ef-4f91-bb3c-eaf9b0c9e99c	true	userinfo.token.claim
b7f28ec0-e7ef-4f91-bb3c-eaf9b0c9e99c	firstName	user.attribute
b7f28ec0-e7ef-4f91-bb3c-eaf9b0c9e99c	true	id.token.claim
b7f28ec0-e7ef-4f91-bb3c-eaf9b0c9e99c	true	access.token.claim
b7f28ec0-e7ef-4f91-bb3c-eaf9b0c9e99c	given_name	claim.name
b7f28ec0-e7ef-4f91-bb3c-eaf9b0c9e99c	String	jsonType.label
63797afa-3ca3-44bb-8c42-f0265a486ca5	true	userinfo.token.claim
63797afa-3ca3-44bb-8c42-f0265a486ca5	lastName	user.attribute
63797afa-3ca3-44bb-8c42-f0265a486ca5	true	id.token.claim
63797afa-3ca3-44bb-8c42-f0265a486ca5	true	access.token.claim
63797afa-3ca3-44bb-8c42-f0265a486ca5	family_name	claim.name
63797afa-3ca3-44bb-8c42-f0265a486ca5	String	jsonType.label
0ac12e6f-5f26-4022-a5da-7a2c6a021361	true	id.token.claim
0ac12e6f-5f26-4022-a5da-7a2c6a021361	true	access.token.claim
e6bf192b-7cf9-43ed-be15-43bd8ba80276	false	single
e6bf192b-7cf9-43ed-be15-43bd8ba80276	Basic	attribute.nameformat
e6bf192b-7cf9-43ed-be15-43bd8ba80276	Role	attribute.name
805d7b5a-9a1c-45bb-afa0-7fd5b61c7ce5	true	userinfo.token.claim
805d7b5a-9a1c-45bb-afa0-7fd5b61c7ce5	username	user.attribute
805d7b5a-9a1c-45bb-afa0-7fd5b61c7ce5	true	id.token.claim
805d7b5a-9a1c-45bb-afa0-7fd5b61c7ce5	true	access.token.claim
805d7b5a-9a1c-45bb-afa0-7fd5b61c7ce5	preferred_username	claim.name
805d7b5a-9a1c-45bb-afa0-7fd5b61c7ce5	String	jsonType.label
a0532f64-cef6-499f-a5b4-8d86d7e65ce2	true	userinfo.token.claim
a0532f64-cef6-499f-a5b4-8d86d7e65ce2	email	user.attribute
a0532f64-cef6-499f-a5b4-8d86d7e65ce2	true	id.token.claim
a0532f64-cef6-499f-a5b4-8d86d7e65ce2	true	access.token.claim
a0532f64-cef6-499f-a5b4-8d86d7e65ce2	email	claim.name
a0532f64-cef6-499f-a5b4-8d86d7e65ce2	String	jsonType.label
f1ea2bf6-9823-4c8a-be7a-1352785d3e5b	true	userinfo.token.claim
f1ea2bf6-9823-4c8a-be7a-1352785d3e5b	firstName	user.attribute
f1ea2bf6-9823-4c8a-be7a-1352785d3e5b	true	id.token.claim
f1ea2bf6-9823-4c8a-be7a-1352785d3e5b	true	access.token.claim
f1ea2bf6-9823-4c8a-be7a-1352785d3e5b	given_name	claim.name
f1ea2bf6-9823-4c8a-be7a-1352785d3e5b	String	jsonType.label
a3ccf020-feae-4c19-8a9e-ac13459b7112	true	userinfo.token.claim
a3ccf020-feae-4c19-8a9e-ac13459b7112	lastName	user.attribute
a3ccf020-feae-4c19-8a9e-ac13459b7112	true	id.token.claim
a3ccf020-feae-4c19-8a9e-ac13459b7112	true	access.token.claim
a3ccf020-feae-4c19-8a9e-ac13459b7112	family_name	claim.name
a3ccf020-feae-4c19-8a9e-ac13459b7112	String	jsonType.label
0fcf2155-8334-44e1-ad4d-58b57d121bc9	true	id.token.claim
0fcf2155-8334-44e1-ad4d-58b57d121bc9	true	access.token.claim
0d892a2f-6b01-49b5-95e6-a87e2b20daff	true	userinfo.token.claim
0d892a2f-6b01-49b5-95e6-a87e2b20daff	locale	user.attribute
0d892a2f-6b01-49b5-95e6-a87e2b20daff	true	id.token.claim
0d892a2f-6b01-49b5-95e6-a87e2b20daff	true	access.token.claim
0d892a2f-6b01-49b5-95e6-a87e2b20daff	locale	claim.name
0d892a2f-6b01-49b5-95e6-a87e2b20daff	String	jsonType.label
71973f51-9ce1-408a-b34a-0d23bcf36182	false	single
71973f51-9ce1-408a-b34a-0d23bcf36182	Basic	attribute.nameformat
71973f51-9ce1-408a-b34a-0d23bcf36182	Role	attribute.name
9346d727-0cf4-4ed8-bf34-35cb28288257	true	userinfo.token.claim
9346d727-0cf4-4ed8-bf34-35cb28288257	username	user.attribute
9346d727-0cf4-4ed8-bf34-35cb28288257	true	id.token.claim
9346d727-0cf4-4ed8-bf34-35cb28288257	true	access.token.claim
9346d727-0cf4-4ed8-bf34-35cb28288257	preferred_username	claim.name
9346d727-0cf4-4ed8-bf34-35cb28288257	String	jsonType.label
4e984b69-6681-4626-8532-e50554c0db1b	true	userinfo.token.claim
4e984b69-6681-4626-8532-e50554c0db1b	email	user.attribute
4e984b69-6681-4626-8532-e50554c0db1b	true	id.token.claim
4e984b69-6681-4626-8532-e50554c0db1b	true	access.token.claim
4e984b69-6681-4626-8532-e50554c0db1b	email	claim.name
4e984b69-6681-4626-8532-e50554c0db1b	String	jsonType.label
1df5e92a-295a-4847-b597-d780e5bf454f	true	userinfo.token.claim
1df5e92a-295a-4847-b597-d780e5bf454f	firstName	user.attribute
1df5e92a-295a-4847-b597-d780e5bf454f	true	id.token.claim
1df5e92a-295a-4847-b597-d780e5bf454f	true	access.token.claim
1df5e92a-295a-4847-b597-d780e5bf454f	given_name	claim.name
1df5e92a-295a-4847-b597-d780e5bf454f	String	jsonType.label
c4c4085d-a7a3-41db-8332-4d6423e2fafb	true	userinfo.token.claim
c4c4085d-a7a3-41db-8332-4d6423e2fafb	lastName	user.attribute
c4c4085d-a7a3-41db-8332-4d6423e2fafb	true	id.token.claim
c4c4085d-a7a3-41db-8332-4d6423e2fafb	true	access.token.claim
c4c4085d-a7a3-41db-8332-4d6423e2fafb	family_name	claim.name
c4c4085d-a7a3-41db-8332-4d6423e2fafb	String	jsonType.label
637a96ca-d6df-4c4a-a5e6-95234b093a1c	true	id.token.claim
637a96ca-d6df-4c4a-a5e6-95234b093a1c	true	access.token.claim
f42803e4-4a00-4d98-bb68-3289467c6848	false	single
f42803e4-4a00-4d98-bb68-3289467c6848	Basic	attribute.nameformat
f42803e4-4a00-4d98-bb68-3289467c6848	Role	attribute.name
b16f092e-1c49-42a9-a034-422968d3f01d	true	userinfo.token.claim
b16f092e-1c49-42a9-a034-422968d3f01d	username	user.attribute
b16f092e-1c49-42a9-a034-422968d3f01d	true	id.token.claim
b16f092e-1c49-42a9-a034-422968d3f01d	true	access.token.claim
b16f092e-1c49-42a9-a034-422968d3f01d	preferred_username	claim.name
b16f092e-1c49-42a9-a034-422968d3f01d	String	jsonType.label
f6855fb7-56d6-43ca-b281-f5d9c222d57c	true	userinfo.token.claim
f6855fb7-56d6-43ca-b281-f5d9c222d57c	email	user.attribute
f6855fb7-56d6-43ca-b281-f5d9c222d57c	true	id.token.claim
f6855fb7-56d6-43ca-b281-f5d9c222d57c	true	access.token.claim
f6855fb7-56d6-43ca-b281-f5d9c222d57c	email	claim.name
f6855fb7-56d6-43ca-b281-f5d9c222d57c	String	jsonType.label
b3d45c2d-a6d1-428f-9f45-0588af519f06	true	userinfo.token.claim
b3d45c2d-a6d1-428f-9f45-0588af519f06	firstName	user.attribute
b3d45c2d-a6d1-428f-9f45-0588af519f06	true	id.token.claim
b3d45c2d-a6d1-428f-9f45-0588af519f06	true	access.token.claim
b3d45c2d-a6d1-428f-9f45-0588af519f06	given_name	claim.name
b3d45c2d-a6d1-428f-9f45-0588af519f06	String	jsonType.label
5143e7f2-001d-47f0-b573-eba51d35821a	true	userinfo.token.claim
5143e7f2-001d-47f0-b573-eba51d35821a	lastName	user.attribute
5143e7f2-001d-47f0-b573-eba51d35821a	true	id.token.claim
5143e7f2-001d-47f0-b573-eba51d35821a	true	access.token.claim
5143e7f2-001d-47f0-b573-eba51d35821a	family_name	claim.name
5143e7f2-001d-47f0-b573-eba51d35821a	String	jsonType.label
70710c5a-2062-44b5-b679-f1942cf05560	true	id.token.claim
70710c5a-2062-44b5-b679-f1942cf05560	true	access.token.claim
fe9212b5-7c83-404e-8f27-620590a4b04a	false	single
fe9212b5-7c83-404e-8f27-620590a4b04a	Basic	attribute.nameformat
fe9212b5-7c83-404e-8f27-620590a4b04a	Role	attribute.name
92a6309c-c567-460e-9c1f-86433fb85d5e	true	userinfo.token.claim
92a6309c-c567-460e-9c1f-86433fb85d5e	lastName	user.attribute
92a6309c-c567-460e-9c1f-86433fb85d5e	true	id.token.claim
92a6309c-c567-460e-9c1f-86433fb85d5e	true	access.token.claim
92a6309c-c567-460e-9c1f-86433fb85d5e	family_name	claim.name
92a6309c-c567-460e-9c1f-86433fb85d5e	String	jsonType.label
06141e7d-4400-449e-9ce1-f23cd954d8e7	true	userinfo.token.claim
06141e7d-4400-449e-9ce1-f23cd954d8e7	firstName	user.attribute
06141e7d-4400-449e-9ce1-f23cd954d8e7	true	id.token.claim
06141e7d-4400-449e-9ce1-f23cd954d8e7	true	access.token.claim
06141e7d-4400-449e-9ce1-f23cd954d8e7	given_name	claim.name
06141e7d-4400-449e-9ce1-f23cd954d8e7	String	jsonType.label
bab1a602-9d2b-46db-8bb7-264e0ad17c46	true	userinfo.token.claim
bab1a602-9d2b-46db-8bb7-264e0ad17c46	username	user.attribute
bab1a602-9d2b-46db-8bb7-264e0ad17c46	true	id.token.claim
bab1a602-9d2b-46db-8bb7-264e0ad17c46	true	access.token.claim
bab1a602-9d2b-46db-8bb7-264e0ad17c46	preferred_username	claim.name
bab1a602-9d2b-46db-8bb7-264e0ad17c46	String	jsonType.label
ecc2910c-0227-41ff-9356-d6d9d9b16ab1	true	id.token.claim
ecc2910c-0227-41ff-9356-d6d9d9b16ab1	true	access.token.claim
ecc2910c-0227-41ff-9356-d6d9d9b16ab1	true	userinfo.token.claim
3d8663e5-07af-4870-9a9a-978b7f2e9818	true	userinfo.token.claim
3d8663e5-07af-4870-9a9a-978b7f2e9818	email	user.attribute
3d8663e5-07af-4870-9a9a-978b7f2e9818	true	id.token.claim
3d8663e5-07af-4870-9a9a-978b7f2e9818	true	access.token.claim
3d8663e5-07af-4870-9a9a-978b7f2e9818	email	claim.name
3d8663e5-07af-4870-9a9a-978b7f2e9818	String	jsonType.label
4a0e3ba2-f265-492d-bb38-ca53396a6ada	true	userinfo.token.claim
4a0e3ba2-f265-492d-bb38-ca53396a6ada	locale	user.attribute
4a0e3ba2-f265-492d-bb38-ca53396a6ada	true	id.token.claim
4a0e3ba2-f265-492d-bb38-ca53396a6ada	true	access.token.claim
4a0e3ba2-f265-492d-bb38-ca53396a6ada	locale	claim.name
4a0e3ba2-f265-492d-bb38-ca53396a6ada	String	jsonType.label
f0085db6-d0c1-47d5-8eaa-02e8c3d9c793	true	userinfo.token.claim
f0085db6-d0c1-47d5-8eaa-02e8c3d9c793	lastName	user.attribute
f0085db6-d0c1-47d5-8eaa-02e8c3d9c793	true	id.token.claim
f0085db6-d0c1-47d5-8eaa-02e8c3d9c793	true	access.token.claim
f0085db6-d0c1-47d5-8eaa-02e8c3d9c793	family_name	claim.name
f0085db6-d0c1-47d5-8eaa-02e8c3d9c793	String	jsonType.label
a4a108d4-8c63-492f-893a-b441f2529b64	false	single
a4a108d4-8c63-492f-893a-b441f2529b64	Basic	attribute.nameformat
a4a108d4-8c63-492f-893a-b441f2529b64	Role	attribute.name
39ef8193-3227-4e80-8005-d13a0e004397	true	userinfo.token.claim
39ef8193-3227-4e80-8005-d13a0e004397	firstName	user.attribute
39ef8193-3227-4e80-8005-d13a0e004397	true	id.token.claim
39ef8193-3227-4e80-8005-d13a0e004397	true	access.token.claim
39ef8193-3227-4e80-8005-d13a0e004397	given_name	claim.name
39ef8193-3227-4e80-8005-d13a0e004397	String	jsonType.label
b6edaa07-cb36-42f5-9ffa-d7e443b06cd6	true	id.token.claim
b6edaa07-cb36-42f5-9ffa-d7e443b06cd6	true	access.token.claim
b6edaa07-cb36-42f5-9ffa-d7e443b06cd6	true	userinfo.token.claim
8eb418ad-f663-4e50-bcf8-0a7b7ebf3ec8	true	userinfo.token.claim
8eb418ad-f663-4e50-bcf8-0a7b7ebf3ec8	email	user.attribute
8eb418ad-f663-4e50-bcf8-0a7b7ebf3ec8	true	id.token.claim
8eb418ad-f663-4e50-bcf8-0a7b7ebf3ec8	true	access.token.claim
8eb418ad-f663-4e50-bcf8-0a7b7ebf3ec8	email	claim.name
8eb418ad-f663-4e50-bcf8-0a7b7ebf3ec8	String	jsonType.label
056da5b0-c399-4037-bff1-b72a45a120ca	true	userinfo.token.claim
056da5b0-c399-4037-bff1-b72a45a120ca	username	user.attribute
056da5b0-c399-4037-bff1-b72a45a120ca	true	id.token.claim
056da5b0-c399-4037-bff1-b72a45a120ca	true	access.token.claim
056da5b0-c399-4037-bff1-b72a45a120ca	preferred_username	claim.name
056da5b0-c399-4037-bff1-b72a45a120ca	String	jsonType.label
c1e82bed-b47a-44bd-a6a4-eace95d2cc55	true	userinfo.token.claim
c1e82bed-b47a-44bd-a6a4-eace95d2cc55	username	user.attribute
c1e82bed-b47a-44bd-a6a4-eace95d2cc55	true	id.token.claim
c1e82bed-b47a-44bd-a6a4-eace95d2cc55	true	access.token.claim
c1e82bed-b47a-44bd-a6a4-eace95d2cc55	preferred_username	claim.name
c1e82bed-b47a-44bd-a6a4-eace95d2cc55	String	jsonType.label
0a089618-d5bb-4ee3-9fb6-989f03b3b98c	true	userinfo.token.claim
0a089618-d5bb-4ee3-9fb6-989f03b3b98c	firstName	user.attribute
0a089618-d5bb-4ee3-9fb6-989f03b3b98c	true	id.token.claim
0a089618-d5bb-4ee3-9fb6-989f03b3b98c	true	access.token.claim
0a089618-d5bb-4ee3-9fb6-989f03b3b98c	given_name	claim.name
0a089618-d5bb-4ee3-9fb6-989f03b3b98c	String	jsonType.label
2f78e702-858b-4fd7-b9ec-352638bbcd34	true	userinfo.token.claim
2f78e702-858b-4fd7-b9ec-352638bbcd34	email	user.attribute
2f78e702-858b-4fd7-b9ec-352638bbcd34	true	id.token.claim
2f78e702-858b-4fd7-b9ec-352638bbcd34	true	access.token.claim
2f78e702-858b-4fd7-b9ec-352638bbcd34	email	claim.name
2f78e702-858b-4fd7-b9ec-352638bbcd34	String	jsonType.label
281c33df-a98e-4698-b6f0-d37eaf98b770	true	id.token.claim
281c33df-a98e-4698-b6f0-d37eaf98b770	true	access.token.claim
281c33df-a98e-4698-b6f0-d37eaf98b770	true	userinfo.token.claim
2b93db77-c7e0-4b82-971b-54b3561e86cf	false	single
2b93db77-c7e0-4b82-971b-54b3561e86cf	Basic	attribute.nameformat
2b93db77-c7e0-4b82-971b-54b3561e86cf	Role	attribute.name
dc640089-785e-40ec-9a91-ba4f77a2d814	true	userinfo.token.claim
dc640089-785e-40ec-9a91-ba4f77a2d814	lastName	user.attribute
dc640089-785e-40ec-9a91-ba4f77a2d814	true	id.token.claim
dc640089-785e-40ec-9a91-ba4f77a2d814	true	access.token.claim
dc640089-785e-40ec-9a91-ba4f77a2d814	family_name	claim.name
dc640089-785e-40ec-9a91-ba4f77a2d814	String	jsonType.label
dceb0ce7-0da6-4bf8-abf3-c23289b3ecae	true	id.token.claim
dceb0ce7-0da6-4bf8-abf3-c23289b3ecae	true	access.token.claim
dceb0ce7-0da6-4bf8-abf3-c23289b3ecae	true	userinfo.token.claim
ffb9c5a4-5a5e-4bc1-bee7-95e5a56e5218	true	userinfo.token.claim
ffb9c5a4-5a5e-4bc1-bee7-95e5a56e5218	email	user.attribute
ffb9c5a4-5a5e-4bc1-bee7-95e5a56e5218	true	id.token.claim
ffb9c5a4-5a5e-4bc1-bee7-95e5a56e5218	true	access.token.claim
ffb9c5a4-5a5e-4bc1-bee7-95e5a56e5218	email	claim.name
ffb9c5a4-5a5e-4bc1-bee7-95e5a56e5218	String	jsonType.label
d75cf70e-36e7-4d3e-8f04-75350610d6e0	true	userinfo.token.claim
d75cf70e-36e7-4d3e-8f04-75350610d6e0	firstName	user.attribute
d75cf70e-36e7-4d3e-8f04-75350610d6e0	true	id.token.claim
d75cf70e-36e7-4d3e-8f04-75350610d6e0	true	access.token.claim
d75cf70e-36e7-4d3e-8f04-75350610d6e0	given_name	claim.name
d75cf70e-36e7-4d3e-8f04-75350610d6e0	String	jsonType.label
a654590b-8b34-4cf8-b772-21e96ca0a2a8	true	userinfo.token.claim
a654590b-8b34-4cf8-b772-21e96ca0a2a8	username	user.attribute
a654590b-8b34-4cf8-b772-21e96ca0a2a8	true	id.token.claim
a654590b-8b34-4cf8-b772-21e96ca0a2a8	true	access.token.claim
a654590b-8b34-4cf8-b772-21e96ca0a2a8	preferred_username	claim.name
a654590b-8b34-4cf8-b772-21e96ca0a2a8	String	jsonType.label
fb3da645-ff64-4214-a793-d63c16e9c8cf	true	userinfo.token.claim
fb3da645-ff64-4214-a793-d63c16e9c8cf	lastName	user.attribute
fb3da645-ff64-4214-a793-d63c16e9c8cf	true	id.token.claim
fb3da645-ff64-4214-a793-d63c16e9c8cf	true	access.token.claim
fb3da645-ff64-4214-a793-d63c16e9c8cf	family_name	claim.name
fb3da645-ff64-4214-a793-d63c16e9c8cf	String	jsonType.label
bd63107b-0234-4657-902e-606030a088f7	true	multivalued
bd63107b-0234-4657-902e-606030a088f7	true	userinfo.token.claim
bd63107b-0234-4657-902e-606030a088f7	true	id.token.claim
bd63107b-0234-4657-902e-606030a088f7	true	access.token.claim
bd63107b-0234-4657-902e-606030a088f7	authorities	claim.name
bd63107b-0234-4657-902e-606030a088f7	String	jsonType.label
bd63107b-0234-4657-902e-606030a088f7	login-app	usermodel.clientRoleMapping.clientId
c309813e-fc11-42e1-9551-6e75b948eee4	false	single
c309813e-fc11-42e1-9551-6e75b948eee4	Basic	attribute.nameformat
c309813e-fc11-42e1-9551-6e75b948eee4	Role	attribute.name
a6834b6e-f021-433d-abe8-440816af026b	false	single
a6834b6e-f021-433d-abe8-440816af026b	Basic	attribute.nameformat
a6834b6e-f021-433d-abe8-440816af026b	Role	attribute.name
15d265bf-f650-4fd1-b4cc-3209e6fed2a0	true	userinfo.token.claim
15d265bf-f650-4fd1-b4cc-3209e6fed2a0	firstName	user.attribute
15d265bf-f650-4fd1-b4cc-3209e6fed2a0	true	id.token.claim
15d265bf-f650-4fd1-b4cc-3209e6fed2a0	true	access.token.claim
15d265bf-f650-4fd1-b4cc-3209e6fed2a0	given_name	claim.name
15d265bf-f650-4fd1-b4cc-3209e6fed2a0	String	jsonType.label
2a8e5cf4-f214-4e0f-b251-04d0c493054a	true	id.token.claim
2a8e5cf4-f214-4e0f-b251-04d0c493054a	true	access.token.claim
2a8e5cf4-f214-4e0f-b251-04d0c493054a	true	userinfo.token.claim
b4531e0a-2618-4391-9e33-44ea6c5a3c0a	true	userinfo.token.claim
b4531e0a-2618-4391-9e33-44ea6c5a3c0a	username	user.attribute
b4531e0a-2618-4391-9e33-44ea6c5a3c0a	true	id.token.claim
b4531e0a-2618-4391-9e33-44ea6c5a3c0a	true	access.token.claim
b4531e0a-2618-4391-9e33-44ea6c5a3c0a	preferred_username	claim.name
b4531e0a-2618-4391-9e33-44ea6c5a3c0a	String	jsonType.label
0ef782de-e019-4e8d-8162-52b407866eee	true	userinfo.token.claim
0ef782de-e019-4e8d-8162-52b407866eee	email	user.attribute
0ef782de-e019-4e8d-8162-52b407866eee	true	id.token.claim
0ef782de-e019-4e8d-8162-52b407866eee	true	access.token.claim
0ef782de-e019-4e8d-8162-52b407866eee	email	claim.name
0ef782de-e019-4e8d-8162-52b407866eee	String	jsonType.label
f715a34d-4e48-494a-92d1-ee53970f361c	true	userinfo.token.claim
f715a34d-4e48-494a-92d1-ee53970f361c	lastName	user.attribute
f715a34d-4e48-494a-92d1-ee53970f361c	true	id.token.claim
f715a34d-4e48-494a-92d1-ee53970f361c	true	access.token.claim
f715a34d-4e48-494a-92d1-ee53970f361c	family_name	claim.name
f715a34d-4e48-494a-92d1-ee53970f361c	String	jsonType.label
29a15d1e-bacd-4361-beca-a81fed97cdd6	true	userinfo.token.claim
29a15d1e-bacd-4361-beca-a81fed97cdd6	username	user.attribute
29a15d1e-bacd-4361-beca-a81fed97cdd6	true	id.token.claim
29a15d1e-bacd-4361-beca-a81fed97cdd6	true	access.token.claim
29a15d1e-bacd-4361-beca-a81fed97cdd6	preferred_username	claim.name
29a15d1e-bacd-4361-beca-a81fed97cdd6	String	jsonType.label
f4f7859c-0a1b-477d-b261-8fd5107937b5	true	userinfo.token.claim
f4f7859c-0a1b-477d-b261-8fd5107937b5	lastName	user.attribute
f4f7859c-0a1b-477d-b261-8fd5107937b5	true	id.token.claim
f4f7859c-0a1b-477d-b261-8fd5107937b5	true	access.token.claim
f4f7859c-0a1b-477d-b261-8fd5107937b5	family_name	claim.name
f4f7859c-0a1b-477d-b261-8fd5107937b5	String	jsonType.label
d7099dca-caaf-4170-8a4e-87c15d30a18c	false	single
d7099dca-caaf-4170-8a4e-87c15d30a18c	Basic	attribute.nameformat
d7099dca-caaf-4170-8a4e-87c15d30a18c	Role	attribute.name
a1fbdc9c-f70f-4a24-9bbc-e274157b82bb	true	id.token.claim
a1fbdc9c-f70f-4a24-9bbc-e274157b82bb	true	access.token.claim
a1fbdc9c-f70f-4a24-9bbc-e274157b82bb	true	userinfo.token.claim
49a86a76-9f9c-4f69-9ef3-ca1de1ae7d9f	true	userinfo.token.claim
49a86a76-9f9c-4f69-9ef3-ca1de1ae7d9f	firstName	user.attribute
49a86a76-9f9c-4f69-9ef3-ca1de1ae7d9f	true	id.token.claim
49a86a76-9f9c-4f69-9ef3-ca1de1ae7d9f	true	access.token.claim
49a86a76-9f9c-4f69-9ef3-ca1de1ae7d9f	given_name	claim.name
49a86a76-9f9c-4f69-9ef3-ca1de1ae7d9f	String	jsonType.label
a66c042c-ef52-49bb-8ab8-fb3a8a275a40	true	userinfo.token.claim
a66c042c-ef52-49bb-8ab8-fb3a8a275a40	email	user.attribute
a66c042c-ef52-49bb-8ab8-fb3a8a275a40	true	id.token.claim
a66c042c-ef52-49bb-8ab8-fb3a8a275a40	true	access.token.claim
a66c042c-ef52-49bb-8ab8-fb3a8a275a40	email	claim.name
a66c042c-ef52-49bb-8ab8-fb3a8a275a40	String	jsonType.label
c86e9db5-1f25-449a-9a92-c4ba6c6a01fb	true	userinfo.token.claim
c86e9db5-1f25-449a-9a92-c4ba6c6a01fb	username	user.attribute
c86e9db5-1f25-449a-9a92-c4ba6c6a01fb	true	id.token.claim
c86e9db5-1f25-449a-9a92-c4ba6c6a01fb	true	access.token.claim
c86e9db5-1f25-449a-9a92-c4ba6c6a01fb	preferred_username	claim.name
c86e9db5-1f25-449a-9a92-c4ba6c6a01fb	String	jsonType.label
cc1ef1cf-9a29-4b9b-bf8c-1e3738122224	false	single
cc1ef1cf-9a29-4b9b-bf8c-1e3738122224	Basic	attribute.nameformat
cc1ef1cf-9a29-4b9b-bf8c-1e3738122224	Role	attribute.name
9815244e-4a3a-49f4-af33-0f04f69999c0	true	userinfo.token.claim
9815244e-4a3a-49f4-af33-0f04f69999c0	firstName	user.attribute
9815244e-4a3a-49f4-af33-0f04f69999c0	true	id.token.claim
9815244e-4a3a-49f4-af33-0f04f69999c0	true	access.token.claim
9815244e-4a3a-49f4-af33-0f04f69999c0	given_name	claim.name
9815244e-4a3a-49f4-af33-0f04f69999c0	String	jsonType.label
ca74a093-cf46-419d-9fea-6b26901e77ec	true	userinfo.token.claim
ca74a093-cf46-419d-9fea-6b26901e77ec	email	user.attribute
ca74a093-cf46-419d-9fea-6b26901e77ec	true	id.token.claim
ca74a093-cf46-419d-9fea-6b26901e77ec	true	access.token.claim
ca74a093-cf46-419d-9fea-6b26901e77ec	email	claim.name
ca74a093-cf46-419d-9fea-6b26901e77ec	String	jsonType.label
0d25eb52-be59-4496-8ef6-4040705c345e	true	id.token.claim
0d25eb52-be59-4496-8ef6-4040705c345e	true	access.token.claim
0d25eb52-be59-4496-8ef6-4040705c345e	true	userinfo.token.claim
445bbcb5-b8f8-4662-ac47-e5cf29440022	true	userinfo.token.claim
445bbcb5-b8f8-4662-ac47-e5cf29440022	lastName	user.attribute
445bbcb5-b8f8-4662-ac47-e5cf29440022	true	id.token.claim
445bbcb5-b8f8-4662-ac47-e5cf29440022	true	access.token.claim
445bbcb5-b8f8-4662-ac47-e5cf29440022	family_name	claim.name
445bbcb5-b8f8-4662-ac47-e5cf29440022	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	a7c7a9e9-192e-484f-9cb5-fa258ef2b58a	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	aef8c6c1-08d4-46e2-88aa-2a698a8abd37	d742dba0-a37c-41c7-a2f6-c0460c7b8980	3ae27946-6f20-47b0-8169-e439850129cc	2bf67332-a18f-4608-82ae-f1ec2403199b	6da1b97e-eed2-4515-a507-2167e1e206d1	2592000	f	900	t	f	3992c0c9-0a8a-4a96-a129-7234ef4f3150	0	f
SpringBootKeyCloak	60	300	300	\N	\N	\N	t	f	0	\N	SpringBootKeyCloak	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	7339dc51-b089-4891-8917-fc48dbf1ed2e	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	a9d9b593-7c45-4937-8072-80971ba01dbc	e1b62786-af39-42de-a93a-acf66af648cd	58142a0a-c745-4ec8-b5ca-5a5d94117b41	ba5218d8-6cd8-4562-b382-e051c7af7a78	af189c43-11e8-4845-9d23-1e56631ba136	2592000	f	900	t	f	83ed90e2-1778-42d2-b206-402604ff03df	0	f
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY realm_attribute (name, value, realm_id) FROM stdin;
_browser_header.xContentTypeOptions	nosniff	master
_browser_header.xRobotsTag	none	master
_browser_header.xFrameOptions	SAMEORIGIN	master
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	master
_browser_header.xXSSProtection	1; mode=block	master
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	master
bruteForceProtected	false	master
permanentLockout	false	master
maxFailureWaitSeconds	900	master
minimumQuickLoginWaitSeconds	60	master
waitIncrementSeconds	60	master
quickLoginCheckMilliSeconds	1000	master
maxDeltaTimeSeconds	43200	master
failureFactor	30	master
displayName	Keycloak	master
displayNameHtml	<div class="kc-logo-text"><span>Keycloak</span></div>	master
_browser_header.xContentTypeOptions	nosniff	SpringBootKeyCloak
_browser_header.xRobotsTag	none	SpringBootKeyCloak
_browser_header.xFrameOptions	SAMEORIGIN	SpringBootKeyCloak
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	SpringBootKeyCloak
_browser_header.xXSSProtection	1; mode=block	SpringBootKeyCloak
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	SpringBootKeyCloak
bruteForceProtected	false	SpringBootKeyCloak
permanentLockout	false	SpringBootKeyCloak
maxFailureWaitSeconds	900	SpringBootKeyCloak
minimumQuickLoginWaitSeconds	60	SpringBootKeyCloak
waitIncrementSeconds	60	SpringBootKeyCloak
quickLoginCheckMilliSeconds	1000	SpringBootKeyCloak
maxDeltaTimeSeconds	43200	SpringBootKeyCloak
failureFactor	30	SpringBootKeyCloak
actionTokenGeneratedByAdminLifespan	43200	SpringBootKeyCloak
actionTokenGeneratedByUserLifespan	300	SpringBootKeyCloak
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY realm_default_roles (realm_id, role_id) FROM stdin;
master	6c78737f-b02b-4ed7-8b72-decfb4cb726f
master	96857654-4eda-468a-a622-60b4224db42a
SpringBootKeyCloak	e784a675-df65-4cfc-bde7-807d3b808f42
SpringBootKeyCloak	fef9f73a-e516-4984-bf5e-06aaf31f0477
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
SpringBootKeyCloak	jboss-logging
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	SpringBootKeyCloak
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY redirect_uris (client_id, value) FROM stdin;
cf524dc9-a8c9-48f8-9d27-cde21540af72	/auth/realms/master/account/*
162d497a-6ba1-4a71-a14d-4ec45b457ae6	/auth/admin/master/console/*
0a7b8751-0939-430f-b9b0-450d5b8e0a36	/auth/admin/SpringBootKeyCloak/console/*
65488c37-d3e4-4ee3-b1a1-76e404c6658a	http://localhost:8080/*
6410d274-5f23-45e8-94fe-753fbec9fb58	http://localhost:8080/*
9ccc10df-9c49-4d54-b4d5-4d1e25be29ca	/auth/realms/SpringBootKeyCloak/account/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id) FROM stdin;
64a2f8f2-84cc-4df3-a125-b1425ea41c58	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL
c2174072-f911-4262-905e-943df0bb3561	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE
14124ec4-7ce5-4101-bf56-dd2b330684cc	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP
8dd13754-96c6-47ff-a007-6ff20361187a	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD
f9819e03-9cb8-4d0a-8c99-0c263e2d9487	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions
775d830d-c953-4975-846b-83e8279c121f	CONFIGURE_TOTP	Configure OTP	SpringBootKeyCloak	t	f	CONFIGURE_TOTP
82f72e78-eeab-47a2-8dd8-a14f65bd96f7	UPDATE_PASSWORD	Update Password	SpringBootKeyCloak	t	f	UPDATE_PASSWORD
245b11c5-023a-47f3-bdd1-8c05056256dd	UPDATE_PROFILE	Update Profile	SpringBootKeyCloak	t	f	UPDATE_PROFILE
90b847b6-6f27-4908-b0ee-7f0f7a382703	VERIFY_EMAIL	Verify Email	SpringBootKeyCloak	t	f	VERIFY_EMAIL
40e087da-3fe7-4a98-8fd2-7a8871d6f55e	terms_and_conditions	Terms and Conditions	SpringBootKeyCloak	f	f	terms_and_conditions
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY resource_policy (resource_id, policy_id) FROM stdin;
1810345f-3ba3-42e7-a5e4-5885472c447b	342cf2a2-a35c-4a06-a63a-acbeb3d931a6
1810345f-3ba3-42e7-a5e4-5885472c447b	faed5aa0-4abe-46ec-84d0-4dc6b5df39e5
1810345f-3ba3-42e7-a5e4-5885472c447b	d9e3477e-e67f-4306-96d5-02595777507e
f1821392-0b55-4968-8455-bb04b18e0c68	32575489-1f7b-4558-b78a-32939996f90b
f1821392-0b55-4968-8455-bb04b18e0c68	946bd74f-9201-43d5-9073-b414051d9ee3
f1821392-0b55-4968-8455-bb04b18e0c68	ef81b9a2-30e8-4acd-9e50-9bea4330b86b
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY resource_scope (resource_id, scope_id) FROM stdin;
1810345f-3ba3-42e7-a5e4-5885472c447b	0ba6d671-ea88-4f2b-ac33-db554a6c9b3a
1810345f-3ba3-42e7-a5e4-5885472c447b	336c36e6-2430-4cb7-ae0f-e45cd75dae36
1810345f-3ba3-42e7-a5e4-5885472c447b	b9245245-1436-471b-9ad6-841518a81fd4
f1821392-0b55-4968-8455-bb04b18e0c68	0ba6d671-ea88-4f2b-ac33-db554a6c9b3a
f1821392-0b55-4968-8455-bb04b18e0c68	336c36e6-2430-4cb7-ae0f-e45cd75dae36
f1821392-0b55-4968-8455-bb04b18e0c68	b9245245-1436-471b-9ad6-841518a81fd4
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode) FROM stdin;
1bed78cc-2952-4fff-8a42-4f06039e5543	f	0
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id) FROM stdin;
342cf2a2-a35c-4a06-a63a-acbeb3d931a6	map-role.permission.fef9f73a-e516-4984-bf5e-06aaf31f0477	\N	scope	0	0	1bed78cc-2952-4fff-8a42-4f06039e5543
faed5aa0-4abe-46ec-84d0-4dc6b5df39e5	map-role-client-scope.permission.fef9f73a-e516-4984-bf5e-06aaf31f0477	\N	scope	0	0	1bed78cc-2952-4fff-8a42-4f06039e5543
d9e3477e-e67f-4306-96d5-02595777507e	map-role-composite.permission.fef9f73a-e516-4984-bf5e-06aaf31f0477	\N	scope	0	0	1bed78cc-2952-4fff-8a42-4f06039e5543
32575489-1f7b-4558-b78a-32939996f90b	map-role.permission.e784a675-df65-4cfc-bde7-807d3b808f42	\N	scope	0	0	1bed78cc-2952-4fff-8a42-4f06039e5543
946bd74f-9201-43d5-9073-b414051d9ee3	map-role-client-scope.permission.e784a675-df65-4cfc-bde7-807d3b808f42	\N	scope	0	0	1bed78cc-2952-4fff-8a42-4f06039e5543
ef81b9a2-30e8-4acd-9e50-9bea4330b86b	map-role-composite.permission.e784a675-df65-4cfc-bde7-807d3b808f42	\N	scope	0	0	1bed78cc-2952-4fff-8a42-4f06039e5543
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY resource_server_resource (id, name, uri, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
1810345f-3ba3-42e7-a5e4-5885472c447b	role.resource.fef9f73a-e516-4984-bf5e-06aaf31f0477	\N	Role	\N	1bed78cc-2952-4fff-8a42-4f06039e5543	1bed78cc-2952-4fff-8a42-4f06039e5543	f	\N
f1821392-0b55-4968-8455-bb04b18e0c68	role.resource.e784a675-df65-4cfc-bde7-807d3b808f42	\N	Role	\N	1bed78cc-2952-4fff-8a42-4f06039e5543	1bed78cc-2952-4fff-8a42-4f06039e5543	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
b9245245-1436-471b-9ad6-841518a81fd4	map-role	\N	1bed78cc-2952-4fff-8a42-4f06039e5543	\N
336c36e6-2430-4cb7-ae0f-e45cd75dae36	map-role-client-scope	\N	1bed78cc-2952-4fff-8a42-4f06039e5543	\N
0ba6d671-ea88-4f2b-ac33-db554a6c9b3a	map-role-composite	\N	1bed78cc-2952-4fff-8a42-4f06039e5543	\N
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY scope_mapping (client_id, role_id) FROM stdin;
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY scope_policy (scope_id, policy_id) FROM stdin;
b9245245-1436-471b-9ad6-841518a81fd4	342cf2a2-a35c-4a06-a63a-acbeb3d931a6
336c36e6-2430-4cb7-ae0f-e45cd75dae36	faed5aa0-4abe-46ec-84d0-4dc6b5df39e5
0ba6d671-ea88-4f2b-ac33-db554a6c9b3a	d9e3477e-e67f-4306-96d5-02595777507e
b9245245-1436-471b-9ad6-841518a81fd4	32575489-1f7b-4558-b78a-32939996f90b
336c36e6-2430-4cb7-ae0f-e45cd75dae36	946bd74f-9201-43d5-9073-b414051d9ee3
0ba6d671-ea88-4f2b-ac33-db554a6c9b3a	ef81b9a2-30e8-4acd-9e50-9bea4330b86b
\.


--
-- Data for Name: template_scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY template_scope_mapping (template_id, role_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_consent_prot_mapper (user_consent_id, protocol_mapper_id) FROM stdin;
\.


--
-- Data for Name: user_consent_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_consent_role (user_consent_id, role_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
b27f542c-87e3-47b1-9f13-be0351b7fab3	\N	b2e2f80b-1b4c-4633-93fb-3ff73b2844c0	f	t	\N	\N	\N	master	admin	1527702727086	\N	0
e50d26ad-3724-4f05-badb-b2bcfd74fe34	\N	3d57c2ab-ba4d-4182-900c-e213d94058e5	f	t	\N	\N	\N	SpringBootKeyCloak	mtarun	1527702864755	\N	0
30439bb8-1a26-4700-8703-2db7196d654c	\N	33c5b281-7285-471a-b846-80704ae3e356	f	t	\N	\N	\N	SpringBootKeyCloak	phiman	1527702896783	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_role_mapping (role_id, user_id) FROM stdin;
575dcaa1-2cf2-45c3-979f-d22892300b68	b27f542c-87e3-47b1-9f13-be0351b7fab3
96857654-4eda-468a-a622-60b4224db42a	b27f542c-87e3-47b1-9f13-be0351b7fab3
1574210b-6a8c-4cdd-8fcc-67dd8e69263b	b27f542c-87e3-47b1-9f13-be0351b7fab3
6c78737f-b02b-4ed7-8b72-decfb4cb726f	b27f542c-87e3-47b1-9f13-be0351b7fab3
b17d5b14-822c-411e-afd6-4df0ccaa49e7	b27f542c-87e3-47b1-9f13-be0351b7fab3
fef9f73a-e516-4984-bf5e-06aaf31f0477	e50d26ad-3724-4f05-badb-b2bcfd74fe34
e784a675-df65-4cfc-bde7-807d3b808f42	e50d26ad-3724-4f05-badb-b2bcfd74fe34
9211a950-6584-476d-b0f0-b2b66a98fbc9	e50d26ad-3724-4f05-badb-b2bcfd74fe34
fef9f73a-e516-4984-bf5e-06aaf31f0477	30439bb8-1a26-4700-8703-2db7196d654c
e784a675-df65-4cfc-bde7-807d3b808f42	30439bb8-1a26-4700-8703-2db7196d654c
e132e410-0300-4717-befd-4ef9293091a8	30439bb8-1a26-4700-8703-2db7196d654c
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY web_origins (client_id, value) FROM stdin;
65488c37-d3e4-4ee3-b1a1-76e404c6658a	http://localhost:8080
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: fed_user_consent_prot_mapper constr_user_consent_protm_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_consent_prot_mapper
    ADD CONSTRAINT constr_user_consent_protm_pk PRIMARY KEY (user_consent_id, protocol_mapper_id);


--
-- Name: fed_user_consent_role constr_user_consent_role_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_user_consent_role
    ADD CONSTRAINT constr_user_consent_role_pk PRIMARY KEY (user_consent_id, role_id);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: credential_attribute constraint_credential_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY credential_attribute
    ADD CONSTRAINT constraint_credential_attr PRIMARY KEY (id);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: fed_credential_attribute constraint_fed_credential_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_credential_attribute
    ADD CONSTRAINT constraint_fed_credential_attr PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: user_consent_prot_mapper constraint_grntcsnt_prm_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent_prot_mapper
    ADD CONSTRAINT constraint_grntcsnt_prm_pm PRIMARY KEY (user_consent_id, protocol_mapper_id);


--
-- Name: user_consent_role constraint_grntcsnt_role_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent_role
    ADD CONSTRAINT constraint_grntcsnt_role_pm PRIMARY KEY (user_consent_id, role_id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_template_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (template_id, name);


--
-- Name: client_template pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: template_scope_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY template_scope_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (template_id, role_id);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_template uk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template
    ADD CONSTRAINT uk_cli_template UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON authentication_flow USING btree (realm_id);


--
-- Name: idx_client_client_templ_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_client_templ_id ON client USING btree (client_template_id);


--
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_def_roles_client ON client_default_roles USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON client_session USING btree (session_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON component_config USING btree (component_id);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON composite_role USING btree (child_role);


--
-- Name: idx_consent_protmapper; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_consent_protmapper ON user_consent_prot_mapper USING btree (user_consent_id);


--
-- Name: idx_consent_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_consent_role ON user_consent_role USING btree (user_consent_id);


--
-- Name: idx_credential_attr_cred; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_credential_attr_cred ON credential_attribute USING btree (credential_id);


--
-- Name: idx_fed_cred_attr_cred; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fed_cred_attr_cred ON fed_credential_attribute USING btree (credential_id);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON keycloak_role USING btree (realm);


--
-- Name: idx_proto_mapp_client_templ; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_proto_mapp_client_templ ON protocol_mapper USING btree (client_template_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_roles_realm ON realm_default_roles USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON scope_policy USING btree (policy_id);


--
-- Name: idx_templ_scope_mapp_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_templ_scope_mapp_role ON template_scope_mapping USING btree (role_id);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON offline_client_session USING btree (user_session_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON user_attribute USING btree (user_id);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_default_roles fk_8aelwnibji49avxsrtuf6xjow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT fk_8aelwnibji49avxsrtuf6xjow FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: client_template_attributes fk_cl_templ_attr_templ; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template_attributes
    ADD CONSTRAINT fk_cl_templ_attr_templ FOREIGN KEY (template_id) REFERENCES client_template(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES client_session(id);


--
-- Name: client fk_cli_tmplt_client; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client
    ADD CONSTRAINT fk_cli_tmplt_client FOREIGN KEY (client_template_id) REFERENCES client_template(id);


--
-- Name: protocol_mapper fk_cli_tmplt_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper
    ADD CONSTRAINT fk_cli_tmplt_mapper FOREIGN KEY (client_template_id) REFERENCES client_template(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: credential_attribute fk_cred_attr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY credential_attribute
    ADD CONSTRAINT fk_cred_attr FOREIGN KEY (credential_id) REFERENCES credential(id);


--
-- Name: realm_default_groups fk_def_groups_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT fk_def_groups_group FOREIGN KEY (group_id) REFERENCES keycloak_group(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: fed_credential_attribute fk_fed_cred_attr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY fed_credential_attribute
    ADD CONSTRAINT fk_fed_cred_attr FOREIGN KEY (credential_id) REFERENCES fed_user_credential(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES keycloak_role(id);


--
-- Name: user_consent_prot_mapper fk_grntcsnt_prm_gr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent_prot_mapper
    ADD CONSTRAINT fk_grntcsnt_prm_gr FOREIGN KEY (user_consent_id) REFERENCES user_consent(id);


--
-- Name: user_consent_role fk_grntcsnt_role_gr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent_role
    ADD CONSTRAINT fk_grntcsnt_role_gr FOREIGN KEY (user_consent_id) REFERENCES user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES keycloak_group(id);


--
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY group_role_mapping
    ADD CONSTRAINT fk_group_role_role FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: realm_default_roles fk_h4wpd7w4hsoolni3h0sw7btje; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_default_roles
    ADD CONSTRAINT fk_h4wpd7w4hsoolni3h0sw7btje FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES identity_provider_mapper(id);


--
-- Name: keycloak_role fk_kjho5le2c0ral09fl8cm9wfw9; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY keycloak_role
    ADD CONSTRAINT fk_kjho5le2c0ral09fl8cm9wfw9 FOREIGN KEY (client) REFERENCES client(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: scope_mapping fk_p3rh9grku11kqfrs4fltt7rnq; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY scope_mapping
    ADD CONSTRAINT fk_p3rh9grku11kqfrs4fltt7rnq FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES protocol_mapper(id);


--
-- Name: client_template fk_realm_cli_tmplt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY client_template
    ADD CONSTRAINT fk_realm_cli_tmplt FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES user_federation_provider(id);


--
-- Name: template_scope_mapping fk_templ_scope_role; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY template_scope_mapping
    ADD CONSTRAINT fk_templ_scope_role FOREIGN KEY (role_id) REFERENCES keycloak_role(id);


--
-- Name: template_scope_mapping fk_templ_scope_templ; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY template_scope_mapping
    ADD CONSTRAINT fk_templ_scope_templ FOREIGN KEY (template_id) REFERENCES client_template(id);


--
-- Name: realm fk_traf444kk6qrkms7n56aiwq5y; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY realm
    ADD CONSTRAINT fk_traf444kk6qrkms7n56aiwq5y FOREIGN KEY (master_admin_client) REFERENCES client(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

