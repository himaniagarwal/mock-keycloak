package com.vakt.mock_keycloak.services;

import com.vakt.mock_keycloak.model.Token;
import com.vakt.mock_keycloak.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

import static java.util.Optional.empty;

@Service
public class KeycloakService {

    @Autowired
    RestTemplate restTemplate;

    @Value("${keycloak.auth.tokenUrl}")
    private String auth_url;

    @Value("${keycloak.auth.userInfoUrl}")
    private String user_info_url;

    @Value("${keycloak.auth.grant_type}")
    private String grant_type;

    @Value("${keycloak.auth.client_id}")
    private String auth_client_id;

    @Value("${keycloak.auth.client_secret}")
    private String auth_client_secret;


    public Token addAuthentication(String code) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        MultiValueMap<String, String> map= new LinkedMultiValueMap<>();
        map.add("grant_type",grant_type);
        map.add("client_id",auth_client_id);
        map.add("client_secret",auth_client_secret);
        map.add("code",code);
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

        HttpEntity<Token> response = restTemplate.exchange(auth_url, HttpMethod.POST, request , Token.class);
        return response.getBody();

    }

    public Authentication getAuthentication(HttpServletRequest request) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer "+request.getHeader("Authorization"));

        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<User> userResponseEntity = restTemplate.exchange(user_info_url, HttpMethod.POST, entity, User.class);
        List<GrantedAuthority> grantedAuthority = AuthorityUtils.createAuthorityList(userResponseEntity.getBody().getAuthorities());
        return new PreAuthenticatedAuthenticationToken(userResponseEntity.getBody(), empty(), grantedAuthority);
    }
}
