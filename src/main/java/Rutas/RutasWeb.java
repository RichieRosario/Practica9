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
            List<Encuesta> encuestas = EncuestaDao.getAll();
            List<Ubicacion> ubicaciones = new ArrayList<>();
            for(Encuesta e : encuestas){
                Ubicacion u = new Ubicacion();
                 if(e.getLatitud() != ""){
                     u.setLatitud(Float.parseFloat(e.getLatitud()));}
                else{
                    u.setLatitud(0.0f);
                }

                if(e.getLongitud()!=""){
                u.setLongitud(Float.parseFloat(e.getLongitud()));}
                else{
                    u.setLongitud(0.0f);
                }
                ubicaciones.add(u);
            }

            attributes.put("ubicaciones", ubicaciones);
            attributes.put("encuestas",encuestas);


            return new ModelAndView(attributes, "index.ftl");
        }, freeMarkerEngine);

        get("/registrarse", (request, response) -> {

            Map<String, Object> attributes = new HashMap<>();
            return new ModelAndView(attributes, "encuesta.ftl");
        }, freeMarkerEngine);

        get("/local", (request, response) -> {

            Map<String, Object> attributes = new HashMap<>();
            return new ModelAndView(attributes, "almacenamientolocal.ftl");
        }, freeMarkerEngine);

        post("/registrarse", "application/json", (request, response) -> {


            String object = request.queryParams("encuestas");

            JsonArray json = (JsonArray) new JsonParser().parse(object);

            json.forEach((obj) ->
            {
                JsonObject jsonObject = obj.getAsJsonObject();
                String nombre = jsonObject.get("nombre").getAsString();
                String sector = jsonObject.get("sector").getAsString();
                String nivel = jsonObject.get("nivel").getAsString();
                String latitud = jsonObject.get("latitud").getAsString();
                String longitud = jsonObject.get("longitud").getAsString();

                Encuesta encuesta = new Encuesta();
                encuesta.setNombre(nombre);
                encuesta.setSector(sector);
                encuesta.setNivel(nivel);
                encuesta.setLatitud(latitud);
                encuesta.setLongitud(longitud);

                System.out.println(encuesta.getId());
                EncuestaDao.add(encuesta);

            });

            return json;
        });

//
//        post("/encuestas/modificar/:id", (request, response) -> {
//
//            Map<String, Object> attributes = new HashMap<>();
//            int id = Integer.parseInt(request.params("id"));
//            String nombre = request.queryParams("nombre");
//            String sector = request.queryParams("sector");
//            String nivel = request.queryParams("nivel");
//            String latitud = request.queryParams("latitud");
//            String longitud = request.queryParams("longitud");
//
//            Encuesta e = EncuestaDao.findOne(id);
//            e.setNombre(nombre);
//            e.setSector(sector);
//            e.setNivel(nivel);
//            e.setLatitud(latitud);
//            e.setLongitud(longitud);
//            EncuestaDao.update(e);
//
//            response.redirect("/");
//
//            return "Ok";
//        });
//
//
//        post("/encuestas/borrar/:id", (request, response) -> {
//
//            Map<String, Object> attributes = new HashMap<>();
//            int id = Integer.parseInt(request.params("id"));
//            Encuesta e = EncuestaDao.findOne(id);
//            EncuestaDao.deleteById(e);
//
//            response.redirect("/");
//
//            return "Ok";
//        });

    }
}