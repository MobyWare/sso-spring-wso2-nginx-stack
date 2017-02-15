package com.upmcenterprises.threepl.api.controllers;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ThreePlController {
  
  @RequestMapping("/")
  public String index() {
    return "Hello from the 3PL Pilot API application.";
  }
}
