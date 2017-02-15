package com.upmcenterprises.threepl.api.controllers;

import com.upmcenterprises.threepl.api.models.Sample;
import com.upmcenterprises.threepl.api.models.SampleRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.OAuth2Request;

import java.util.List;
import java.util.Set;
import java.util.HashSet;

@RestController
public class SampleController {
  
  private SampleRepository sampleRepository;
  
  @Autowired
  public void setSampleRepository(SampleRepository repository) {
    sampleRepository = repository;
  }
  
  /**
   * Gets the samples from the sample table.
   * @return a string enumerating the samples in the sample table.
   */
  @RequestMapping("/samples")
  @ResponseBody
  public String getSamples() {
    String user = "Unknown";
    String roles = "<None>";
    String tempRoles = "";

    try {
      List<Sample> samples = sampleRepository.findAll();
      for (Sample sample: samples) {
        System.out.println(sample.getName() + " : " + sample.getDescription());
      }
      try{
        user = SecurityContextHolder.getContext().getAuthentication().getName();

        for(String group:availableScopes(SecurityContextHolder.getContext().getAuthentication())){
          if(tempRoles.length() > 0){
            tempRoles += ", " + group;
          }
          else{
            tempRoles += group;
          }
        }
      }
      catch(Exception inner_exeption){
        System.out.println("Error getting current user: " + inner_exeption.toString());
      }

      if(tempRoles.length() > 0){
        roles = tempRoles;
      }

      return "Samples logged. For user: " + user + " with roles: " + roles;
    } catch (Exception exception) {
      return "Error getting samples: " + exception.toString();
    }
  }

  private Set<String> availableScopes(Authentication auth){
        Set<String> availableScopes = new HashSet<>();
        if (auth != null)
        {
            OAuth2Request clientAuthentication = ((OAuth2Authentication) auth).getOAuth2Request();
            availableScopes =  clientAuthentication.getScope();
        }
        return availableScopes;
  }
}
