package Rutas;

import dao.*;
import jdk.nashorn.internal.parser.JSONParser;
import modelo.*;
import spark.template.freemarker.FreeMarkerEngine;
import spark.ModelAndView;
import spark.QueryParamsMap;
import spark.Session;
import spark.utils.IOUtils;

import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.*;

import javax.imageio.ImageIO;
import javax.servlet.MultipartConfigElement;
import javax.servlet.http.Part;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import static spark.Spark.*;

import static spark.Spark.get;

public class RutasWeb {
    public RutasWeb(final FreeMarkerEngine freeMarkerEngine) {

       EncuestaDaoImpl EncuestaDao = new EncuestaDaoImpl(Encuesta.class);
        get("/", (request, response) -> {

            Map<String, Object> attributes = new HashMap<>();
            return new ModelAndView(attributes, "index.ftl");
        }, freeMarkerEngine);

        post("/registrarse", (request, response) -> {

           Object object = request.queryParams("encuestas");
            System.out.println(object.toString());

            return null;
        });

    }
}