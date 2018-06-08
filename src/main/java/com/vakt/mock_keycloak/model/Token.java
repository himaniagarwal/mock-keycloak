package com.vakt.mock_keycloak.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class Token {

    private String access_token;
    private long expires_in;
    private long refresh_express_in;
    private String refresh_token;
    private String token_type;
    private String not_before_policy;
    private String session_state;

    public Token() {

    }

    @JsonCreator
    public Token(@JsonProperty("access_token") String access_token,
                 @JsonProperty("expires_in") long expires_in,
                 @JsonProperty("refresh_express_in") long refresh_express_in,
                 @JsonProperty("refresh_token") String refresh_token,
                 @JsonProperty("token_type") String token_type,
                 @JsonProperty("not-before-policy") String not_before_policy,
                 @JsonProperty("session_date") String session_state) {
        this.access_token = access_token;
        this.expires_in = expires_in;
        this.refresh_express_in = refresh_express_in;
        this.refresh_token = refresh_token;
        this.token_type = token_type;
        this.not_before_policy = not_before_policy;
        this.session_state = session_state;
    }

    public String getAccess_token() {
        return access_token;
    }

    public void setAccess_token(String access_token) {
        this.access_token = access_token;
    }

    public long getExpires_in() {
        return expires_in;
    }

    public void setExpires_in(long expires_in) {
        this.expires_in = expires_in;
    }

    public long getRefresh_express_in() {
        return refresh_express_in;
    }

    public void setRefresh_express_in(long refresh_express_in) {
        this.refresh_express_in = refresh_express_in;
    }

    public String getRefresh_token() {
        return refresh_token;
    }

    public void setRefresh_token(String refresh_token) {
        this.refresh_token = refresh_token;
    }

    public String getToken_type() {
        return token_type;
    }

    public void setToken_type(String token_type) {
        this.token_type = token_type;
    }

    public String getNot_before_policy() {
        return not_before_policy;
    }

    public void setNot_before_policy(String not_before_policy) {
        this.not_before_policy = not_before_policy;
    }

    public String getSession_state() {
        return session_state;
    }

    public void setSession_state(String session_state) {
        this.session_state = session_state;
    }
}
