package Rutas;

import dao.*;
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

            Map<String, Object> attributes = new HashMap<>();
            String nombre = request.queryParams("nombre");
            String sector = request.queryParams("sector");
            String nivel = request.queryParams("nivel");
            String latitud = request.queryParams("latitud");
            String longitud = request.queryParams("longitud");

            Encuesta e = new Encuesta();
            e.setNombre(nombre);
            e.setSector(sector);
            e.setNivel(nivel);
            e.setLatitud(latitud);
            e.setLongitud(longitud);
            EncuestaDao.add(e);

            response.redirect("/");

            return new ModelAndView(attributes, "index.ftl");
        }, freeMarkerEngine);

    }

}