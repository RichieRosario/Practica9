package dao;

import hibernate.HibernateUtil;
import modelo.*;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;

import static hibernate.HibernateUtil.getSession;

public class EncuestaDaoImpl extends Repositorio<Encuesta, Integer> implements EncuestaDao {

    private static final Logger logger = LoggerFactory.getLogger(EncuestaDaoImpl.class);
    public EncuestaDaoImpl(Class<Encuesta> encuestaClass){

        super(encuestaClass);
    }

    public void add(Encuesta e){
        super.add(e);
    }


    public Encuesta findOne(Integer id) {
        return super.findOne(id);
    }

    public List<Encuesta> getAll() {

        Session session = null;
        Transaction transaction = null;
        Query query = null;

        try {
            session = HibernateUtil.openSession();


            transaction = session.beginTransaction();

            query = session.createQuery("from Encuesta a");

            return query.list();
        } catch (HibernateException e) {
            transaction.rollback();
            logger.debug("Error al ejecutar un select el objeto en la base de datos.", e);
            return null;
        } finally {
            session.close();
        }

    }

    public void update(Encuesta e) {

        super.update(e);
    }

    public void deleteById(Encuesta e) {
        e.setDeleted(true);
        this.update(e);
    }


}
