package lx.edu.config;

import java.nio.charset.StandardCharsets;
import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.client.RestTemplate;


@Configuration
public class RestTemplateConfig {

    @Bean
    public RestTemplate restTemplate() {

        RestTemplate restTemplate = new RestTemplate();

        List<HttpMessageConverter<?>> converters =
                restTemplate.getMessageConverters();

        for(HttpMessageConverter<?> converter : converters) {

            if(converter instanceof StringHttpMessageConverter) {

                ((StringHttpMessageConverter) converter)
                        .setDefaultCharset(StandardCharsets.UTF_8);
            }
        }

        return restTemplate;
    }

}