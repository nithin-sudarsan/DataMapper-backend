package com.example.DataMapperDemo.Controller;

import lombok.RequiredArgsConstructor;
import org.perfios.DataMapper;
import org.perfios.DataMapperImpl;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.nio.charset.StandardCharsets;

@RestController
@RequestMapping("api/dataMapper")
@RequiredArgsConstructor
public class Controller {
    @PostMapping("/file")
    public String mapperDemo(
            @RequestParam("file") MultipartFile file,
            @RequestParam("rules") MultipartFile rules,
            @RequestParam("format") String format
    ) {
        DataMapper dataMapper = new DataMapperImpl();
        String rulesFile = null;
        String inputFile = null;
        String transformed = null;
        try {
            byte[] bytes = file.getBytes();
            inputFile = new String(bytes, StandardCharsets.UTF_8);

            byte[] csv_bytes = rules.getBytes();
            rulesFile = new String(csv_bytes, StandardCharsets.UTF_8);
        } catch (Exception e) {
            System.out.println("Could not upload files: " + e.getMessage());
        }
        if (format.equals("JSON")) {
            transformed = dataMapper.getTransformedString(inputFile, rulesFile, DataMapperImpl.Extension.JSON);
        } else if (format.equals("XML")) {
            transformed = dataMapper.getTransformedString(inputFile, rulesFile, DataMapperImpl.Extension.XML);
        }
        System.out.println(transformed);
        return transformed;
    }
    @PostMapping("/str")
    public String mapperDemo(
            @RequestParam("file") MultipartFile file,
            @RequestParam("rules") String rules,
            @RequestParam("format") String format
    ) {
        DataMapper dataMapper = new DataMapperImpl();
        String inputFile = null;
        String transformed = null;
        try {
            byte[] bytes = file.getBytes();
            inputFile = new String(bytes, StandardCharsets.UTF_8);

        } catch (Exception e) {
            System.out.println("Could not upload files: " + e.getMessage());
        }
        if (format.equals("JSON")) {
            transformed = dataMapper.getTransformedString(inputFile, rules, DataMapperImpl.Extension.JSON);
        } else if (format.equals("XML")) {
            transformed = dataMapper.getTransformedString(inputFile, rules, DataMapperImpl.Extension.XML);
        }
        System.out.println(transformed);
        return transformed;
    }
}

