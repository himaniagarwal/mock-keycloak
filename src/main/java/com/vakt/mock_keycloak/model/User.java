package com.vakt.mock_keycloak.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Arrays;

public class User {
    private final String id;
    private final String name;
    private final String preferred_username;
    private final String given_name;
    private final String family_name;
    private final String email;
    private final String[] authorities;

    @JsonCreator
    public User(@JsonProperty("sub") String id,
                @JsonProperty("name") String name,
                @JsonProperty("preferred_username") String preferred_username,
                @JsonProperty("given_name") String given_name,
                @JsonProperty("family_name") String family_name,
                @JsonProperty("email") String email,
                @JsonProperty("authorities") String[] authorities) {
        this.id = id;
        this.name = name;
        this.preferred_username = preferred_username;
        this.given_name = given_name;
        this.family_name = family_name;
        this.email = email;
        this.authorities = authorities;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getPreferred_username() {
        return preferred_username;
    }

    public String getGiven_name() {
        return given_name;
    }

    public String getFamily_name() {
        return family_name;
    }

    public String getEmail() {
        return email;
    }

    public String[] getAuthorities() {
        return authorities;
    }

}