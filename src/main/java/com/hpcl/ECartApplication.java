package com.hpcl;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = "com.hpcl") // 🔹 Add this line
public class ECartApplication {
	public static void main(String[] args) {
		SpringApplication.run(ECartApplication.class, args);
		System.out.println("Hello");
	}
}
