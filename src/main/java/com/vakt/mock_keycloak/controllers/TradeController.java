package com.vakt.mock_keycloak.controllers;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TradeController {

    @RequestMapping("/api/trades")
    @PreAuthorize("hasAuthority('MEMBER')")
    public String getTrades() {
        return "Trades";
    }
}
