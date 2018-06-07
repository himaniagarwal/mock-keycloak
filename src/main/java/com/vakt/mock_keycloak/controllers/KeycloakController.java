package com.vakt.mock_keycloak.controllers;

import com.vakt.mock_keycloak.model.Token;
import com.vakt.mock_keycloak.services.KeycloakService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class KeycloakController {

    @Autowired
    private KeycloakService keycloakService;


    @RequestMapping("/keycloak/token")
    public ResponseEntity<Token> getToken(@RequestHeader("code") String code) {
        return ResponseEntity.ok(keycloakService.getToken(code));
    }
}
