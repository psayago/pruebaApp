package com.example.pruebaApp.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.pruebaApp.model.Greeting;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
public class AppRestController {
	
	ObjectMapper objectMapper = new ObjectMapper();
	Logger log = LoggerFactory.getLogger(AppRestController.class);
	
	@GetMapping(path = "/getBar" )
	public ResponseEntity<JsonNode> getAllBares(){
//		try {
//			Thread.sleep(700);
//		} catch (InterruptedException e) {
//			e.printStackTrace();	
//		}
		Greeting greeting = new Greeting(0, "Hello Ibis");
		
		JsonNode json = objectMapper.valueToTree(greeting);
		
		log.info("Todo funcionando ok ");
		
		return ResponseEntity.ok().body(json);		
	}

}
