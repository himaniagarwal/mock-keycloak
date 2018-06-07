package com.vakt.mock_keycloak.services;

import com.vakt.mock_keycloak.model.Token;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
public class KeycloakService {

    @Autowired
    RestTemplate restTemplate;

    @Value("${keycloak.auth.url}")
    private String auth_url;

    @Value("${keycloak.auth.grant_type}")
    private String grant_type;

    @Value("${keycloak.auth.client_id}")
    private String auth_client_id;

    @Value("${keycloak.auth.client_secret}")
    private String auth_client_secret;


    public Token getToken(String code) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        MultiValueMap<String, String> map= new LinkedMultiValueMap<>();
        map.add("grant_type",grant_type);
        map.add("client_id",auth_client_id);
        map.add("client_secret",auth_client_secret);
        map.add("code",code);
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

        HttpEntity<String> response = restTemplate.exchange(auth_url, HttpMethod.POST, request , String.class);
        System.out.println(response.getBody());
        return new Token();

    }
}
