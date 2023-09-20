package app.config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/product/productCreate").hasRole("USER")
                .antMatchers("/admin/**").hasRole("ADMIN")
                .antMatchers("/customer/**").hasAnyRole("CUSTOMER", "ADMIN")
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .loginPage("/login")
                .successForwardUrl("/customer/homeCustomer")
                .permitAll()
                .and()
                .logout()
                .permitAll();
    }
}

//    @Bean
//    public DebugFilter debugFilter(FilterChainProxy filterChainProxy) {
//        DebugFilter debugFilter = new DebugFilter();
//        debugFilter.setFilterChainProxy(filterChainProxy); // Set any required properties
//        return debugFilter;
//    }

//    @Bean
//    public AuthenticationSuccessHandler authenticationSuccessHandler() {
//        return (request, response, authentication) -> {
//            // Use Spring's RedirectStrategy to handle the redirect
//            RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
//            redirectStrategy.sendRedirect(request, response, "/customer/homeCustomer"); // Absolute URL path
//        };
//    }

    // You can configure authentication providers (e.g., in-memory, JDBC, custom) here

