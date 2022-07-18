package com.example.utility;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import java.io.File;
import java.io.IOException;

public class Demo {

    public static void main(String[] args) {

        ObjectMapper mapper = new ObjectMapper();


        Object respData = new Gson().fromJson("{\"name\": \"rahul\"}", Object.class);

        try {

            // Writing to a file
            mapper.writeValue(new File("D:\\country.json"), respData );

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
