

import freemarker.template.Configuration;
import Rutas.*;
import freemarker.template.Version;
import hibernate.HibernateUtil;
import org.simpleframework.xml.Serializer;
import servicios.ConnectionService;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import encapsulacion.*;
import servicios.*;
import org.simpleframework.xml.core.Persister;
import spark.Request;
import spark.Response;

import java.io.ByteArrayOutputStream;

import static spark.Spark.*;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.*;

import dao.*;
import modelo.*;
import spark.template.freemarker.FreeMarkerEngine;

import javax.imageio.ImageIO;

import static spark.Spark.staticFileLocation;


public class Main {

    public static void main(String[] args) throws Exception {



        try{
            ConnectionService.startDb();
        }
        catch (SQLException e){

            e.printStackTrace();
        }
        final Configuration configuration = new Configuration(new Version(2, 3, 26));

        configuration.setClassForTemplateLoading(Main.class, "/templates");

        System.out.println(configuration.isCacheStorageExplicitlySet());
        staticFileLocation("/public");


        HibernateUtil.buildSessionFactory().openSession().close();



        HibernateUtil.openSession().close();

        FreeMarkerEngine freeMarkerEngine = new FreeMarkerEngine(configuration);
        new RutasWeb(freeMarkerEngine);

    }


}