package com.vakt.mock_keycloak.controllers;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TradeController {

    @RequestMapping("/api/member")
    @PreAuthorize("hasAuthority('MEMBER')")
    public String member() {
        return "Accessible to members";
    }

    @RequestMapping("/api/customer")
    @PreAuthorize("hasAuthority('CUSTOMER')")
    public String customer() {
        return "Accessible to customers";
    }
}
