package com.example.demo.weather;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/weather")
public class WeatherRestController {

    @GetMapping("/")
    public String forecast(){
        return "Maybe sun.... Maybe rain... Mabye snow";
    }
}
