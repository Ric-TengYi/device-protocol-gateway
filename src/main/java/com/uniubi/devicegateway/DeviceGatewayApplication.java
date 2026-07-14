package com.uniubi.devicegateway;

import com.uniubi.devicegateway.config.GatewayProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication
@EnableConfigurationProperties(GatewayProperties.class)
public class DeviceGatewayApplication {
    public static void main(String[] args) { SpringApplication.run(DeviceGatewayApplication.class, args); }
}
