package com.upmcenterprises.threepl.api.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;

import org.springframework.security.oauth2.provider.token.DefaultAccessTokenConverter;
import org.springframework.security.oauth2.provider.token.store.JwtAccessTokenConverter;

import com.upmcenterprises.threepl.api.authentication.CustomUserAuthenticationConverter;

/**
 * Defines custom configuration for OAuth2.
 */
@Configuration
@EnableResourceServer
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class OauthResourceServerConfiguration
{
    /**
     * Sets the accessTokenConverter to use custom JwtAccessTokenConverter
     *
     * @param jwtAccessTokenConverter Helper that translates between JWT encoded token values and OAuth information
     */
    @Autowired
    public void setJwtAccessTokenConverter(JwtAccessTokenConverter jwtAccessTokenConverter)
    {
        jwtAccessTokenConverter.setAccessTokenConverter(defaultAccessTokenConverter());
    }

    /**
     * Returns a new instance of the TenantAwareJwtAccessTokenConverter
     *
     * @return DefaultAccessTokenConverter
     */
    @Bean
    DefaultAccessTokenConverter defaultAccessTokenConverter()
    {
        DefaultAccessTokenConverter defaultAccessTokenConverter = new DefaultAccessTokenConverter();
        defaultAccessTokenConverter.setUserTokenConverter(new CustomUserAuthenticationConverter());
        return defaultAccessTokenConverter;
    }    

}