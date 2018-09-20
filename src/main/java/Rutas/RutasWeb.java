package Rutas;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
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

            String object = request.queryParams("encuestas");

            JsonArray json = (JsonArray) new JsonParser().parse(object);

           System.out.println(json.get(1));

            return null;
        });


        post("/modificar/:id", (request, response) -> {

            Map<String, Object> attributes = new HashMap<>();
            int id = Integer.parseInt(request.params("id"));
            String nombre = request.queryParams("nombre");
            String sector = request.queryParams("sector");
            String nivel = request.queryParams("nivel");
            String latitud = request.queryParams("latitud");
            String longitud = request.queryParams("longitud");

            Encuesta e = EncuestaDao.findOne(id);
            e.setNombre(nombre);
            e.setSector(sector);
            e.setNivel(nivel);
            e.setLatitud(latitud);
            e.setLongitud(longitud);
            EncuestaDao.update(e);

            response.redirect("/");

            return new ModelAndView(attributes, "index.ftl");
        }, freeMarkerEngine);


        post("/eliminar/:id", (request, response) -> {

            Map<String, Object> attributes = new HashMap<>();
            int id = Integer.parseInt(request.params("id"));
            Encuesta e = EncuestaDao.findOne(id);
            EncuestaDao.deleteById(e);

            response.redirect("/");

            return new ModelAndView(attributes, "index.ftl");
        }, freeMarkerEngine);

    }
}