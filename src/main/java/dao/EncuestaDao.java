package dao;

import modelo.Encuesta;

import java.util.List;

public interface EncuestaDao extends IRepositorio<Encuesta, Integer> {

    @Override
    void add(Encuesta user);

    @Override
    Encuesta findOne(Integer id);

    @Override
    List<Encuesta> getAll();

    @Override
    void update(Encuesta user);

    @Override
    void deleteById(Encuesta user);

}
