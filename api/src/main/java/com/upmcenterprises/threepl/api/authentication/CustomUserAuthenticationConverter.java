package com.upmcenterprises.threepl.api.authentication;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.oauth2.provider.token.UserAuthenticationConverter;
import org.springframework.util.StringUtils;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * A custom implementation of
 * {@link org.springframework.security.oauth2.provider.token.DefaultUserAuthenticationConverter) from the
 * spring-security-oauth project. This custom class was created to allow the spring security Principal object to be
 * created from the JWT 'sub' claim rather that the default of the 'user-name' claim. All code with the exception of
 * the 'sub' claim handling is reused from the original source based on commit b0bb5d3d5960d985c937a632f9c1e55a536568d2.
 */
public class CustomUserAuthenticationConverter implements UserAuthenticationConverter
{
    private Collection<? extends GrantedAuthority> defaultAuthorities;
    private UserDetailsService userDetailsService;

    private static final String SUB_CLAIM = "sub";

    /**
     * Optional {@link UserDetailsService} to use when extracting an {@link Authentication} from the incoming map.
     *
     * @param userDetailsService the userDetailsService to set
     */
    public void setUserDetailsService(UserDetailsService userDetailsService)
    {
        this.userDetailsService = userDetailsService;
    }

    /**
     * Default value for authorities if an Authentication is being created and the input has no data for authorities.
     * Note that unless this property is set, the default Authentication created by {@link #extractAuthentication(Map)}
     * will be unauthenticated.
     *
     * @param defaultAuthorities the defaultAuthorities to set. Default null.
     */
    public void setDefaultAuthorities(String[] defaultAuthorities)
    {
        this.defaultAuthorities = AuthorityUtils.commaSeparatedStringToAuthorityList(StringUtils
            .arrayToCommaDelimitedString(defaultAuthorities));
    }

    public Map<String, ?> convertUserAuthentication(Authentication authentication)
    {
        Map<String, Object> response = new LinkedHashMap<String, Object>();
        response.put(USERNAME, authentication.getName());
        if (authentication.getAuthorities() != null && !authentication.getAuthorities().isEmpty())
        {
            response.put(AUTHORITIES, AuthorityUtils.authorityListToSet(authentication.getAuthorities()));
        }
        return response;
    }

    public Authentication extractAuthentication(Map<String, ?> map)
    {
        if (map.containsKey(SUB_CLAIM))
        {
            Object principal = extractUsername(map);
            Collection<? extends GrantedAuthority> authorities = getAuthorities(map);
            if (userDetailsService != null)
            {
                UserDetails user = userDetailsService.loadUserByUsername((String) map.get(USERNAME));
                authorities = user.getAuthorities();
                principal = user;
            }
            return new UsernamePasswordAuthenticationToken(principal, "N/A", authorities);
        }
        return null;
    }

    private Collection<? extends GrantedAuthority> getAuthorities(Map<String, ?> map)
    {
        if (!map.containsKey(AUTHORITIES))
        {
            return defaultAuthorities;
        }
        Object authorities = map.get(AUTHORITIES);
        if (authorities instanceof String)
        {
            return AuthorityUtils.commaSeparatedStringToAuthorityList((String) authorities);
        }
        if (authorities instanceof Collection)
        {
            return AuthorityUtils.commaSeparatedStringToAuthorityList(StringUtils
                    .collectionToCommaDelimitedString((Collection<?>) authorities));
        }
        throw new IllegalArgumentException("Authorities must be either a String or a Collection");
    }

    /**
     * Extracts the username from the 'sub' claim within a JWT claim map.
     *
     * @param map A {@link Map} containing JWT claims.
     * @return The extracted user name.
     */
    private String extractUsername(Map<String, ?> map)
    {
        String subClaim = (String)map.get(SUB_CLAIM);
        return extractUsername(subClaim);
    }

    /**
     * Extracts the username from a 'sub' claim String.
     *
     * @param subClaim A {@link String} representing a 'sub' claim.
     * @return the username portion of the 'sub' claim.
     */
    private String extractUsername(String subClaim)
    {
        String username = null;
        if (subClaim == null)
        {
            return username;
        }

        int delimiterLocation = subClaim.lastIndexOf("@");
        // The sub claim does not have a domain.
        if (delimiterLocation == -1)
        {
            return subClaim;
        }
        // The sub claim does have a domain.
        else
        {
            username = subClaim.substring(0, delimiterLocation);
        }
        return username;
    }
}