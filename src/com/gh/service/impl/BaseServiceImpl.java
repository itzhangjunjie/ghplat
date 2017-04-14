package com.gh.service.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.gh.dao.IBaseDao;
import com.gh.service.IBaseService;
import com.gh.util.PageList;

@Service
public class BaseServiceImpl<T> implements IBaseService<T> {

	@Resource
	private IBaseDao<T> baseDao;

	@Override
	public <T> T findObject(String hql) {
		return baseDao.findObject(hql);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.school.dao.BaseDao#findObject(java.lang.String,
	 * java.lang.Object[])
	 */
	@Override
	public <T> T findObject(String hql, Object... objects) {
		return baseDao.findObject(hql, objects);
	}

	@Override
	public void delete(Class<T> t, Long id) throws Exception {
		baseDao.delete(t, id);
	}

	@Override
	public T findObjByProperty(Class<T> clazz, Map<String, Object> properties) throws Exception {
		return baseDao.findObjByProperty(clazz, properties);
	}

	@Override
	public <T> T findObject(Class<T> cls, Serializable id) {
		return baseDao.findObject(cls, id);
	}

	@Override
	public <T> T findObjectBySql(String sql) {
		return baseDao.findObjectBySql(sql);
	}

	@Override
	public <T> T findObjectBySql(String sql, Object... objects) {
		return (T) baseDao.findListBySql(sql, objects);
	}

	@Override
	public <T> List<T> findList(String hql) {
		return baseDao.findList(hql);
	}

	@Override
	public <T> List<T> findList(String hql, Object... objects) {
		return baseDao.findList(hql, objects);
	}

	@Override
	public <T> List<T> findList(Class<T> cls) {
		return baseDao.findList(cls);
	}

	@Override
	public <T> List<T> findListBySql(String sql) {
		return baseDao.findListBySql(sql);
	}

	@Override
	public <T> List<T> findListBySql(String sql, Object... objects) {
		return baseDao.findListBySql(sql, objects);
	}

	@Override
	public <T> void saveObject(T obj) {
		baseDao.saveObject(obj);
	}

	@Override
	public <T> void updateObject(T obj) {
		baseDao.updateObject(obj);
	}

	@Override
	public <T> void saveOrUpdateObject(T obj) {
		baseDao.saveOrUpdateObject(obj);
	}

	@Override
	public int executeSql(String sql) {
		return baseDao.executeSql(sql);
	}

	@Override
	public int executeSql(String sql, Object... objects) {
		return baseDao.executeSql(sql, objects);
	}

	@Override
	public int coutObjects(String hql) {
		return baseDao.coutObjects(hql);
	}

	@Override
	public int countObjects(String hql, Object... objects) {
		return baseDao.countObjects(hql, objects);
	}

	@Override
	public <T> PageList<T> findPageList(String hql, int page, int rows) {
		return baseDao.findPageList(hql, page, rows);
	}

	@Override
	public <T> PageList<T> findPageList(String hql, int page, int rows, Object... objects) {
		return baseDao.findPageList(hql, page, rows, objects);
	}


	@Override
	public void update(T t) throws Exception {
		baseDao.update(t);
	}

	@Override
	public Long save(T t) throws Exception {
		return baseDao.save(t);
	}

	@Override
	public T getById(Class<T> clazz, Long id) throws Exception {
		return baseDao.getById(clazz, id);
	}

	@Override
	public T loadById(Class<T> clazz, Long id) throws Exception {
		return baseDao.loadById(clazz, id);
	}

	@Override
	public Object findUniqueByHql(String hql, Object... params) throws Exception {
		return baseDao.findUniqueByHql(hql, params);
	}

}
