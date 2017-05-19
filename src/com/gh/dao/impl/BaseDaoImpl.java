package com.gh.dao.impl;

import java.io.Serializable;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;

import com.gh.dao.IBaseDao;
import com.gh.util.PageList;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Repository;  
  
  
import java.io.Serializable;
import java.util.List;
 
import org.hibernate.Query;
import org.hibernate.ScrollableResults;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
 
@Repository("baseDao")  
@SuppressWarnings("all") 
public class BaseDaoImpl<T>  implements IBaseDao<T> {
 
	@Resource
    private SessionFactory sessionFactory;
 
    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }
	
//	@Resource(name="sessionFactory")
//    public void setHibernateTemplate(SessionFactory sessionFactory){
//		super.setSessionFactory(sessionFactory);
//	}
//    
//    public Session getCSession() {
//        return getSession();
//    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#findObject(java.lang.String)
     */
    @Override
    public <T> T findObject(String hql) {
        List<T> list = findList(hql);
        return (null == list || list.size() == 0) ? null : list.get(0);
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#findObject(java.lang.String,
     * java.lang.Object[])
     */
    @Override
    public <T> T findObject(String hql, Object... objects) {
        List<T> list = findList(hql, objects);
        return (null == list || list.size() == 0) ? null : list.get(0);
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#findObject(java.lang.Class,
     * java.io.Serializable)
     */
    @Override
    public <T> T findObject(Class<T> cls, Serializable id) {
        return (T) getSession().get(cls, id);
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#findObjectBySql(java.lang.String)
     */
    @Override
    public <T> T findObjectBySql(String sql) {
        List<T> list = findListBySql(sql);
        return (null == list || list.size() == 0) ? null : list.get(0);
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#findObjectBySql(java.lang.String,
     * java.lang.Object[])
     */
    @Override
    public <T> T findObjectBySql(String sql, Object... objects) {
        List<T> list = findListBySql(sql, objects);
        return (null == list || list.size() == 0) ? null : list.get(0);
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#findList(java.lang.String)
     */
    @Override
    public <T> List<T> findList(String hql) {
        Query query = getSession().createQuery(hql);
        return query.list();
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#findList(java.lang.String,
     * java.lang.Object[])
     */
    @Override
    public <T> List<T> findList(String hql, Object... objects) {
        Query query = getSession().createQuery(hql);
        setParameter(query, objects);
        return query.list();
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#findList(java.lang.Class)
     */
    @Override
    public <T> List<T> findList(Class<T> cls) {
        String hql = "FROM " + cls.getName();
        return findList(hql);
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#findListBySql(java.lang.String)
     */
    @Override
    public <T> List<T> findListBySql(String sql) {
        Query query = getSession().createSQLQuery(sql);
        return query.list();
    }
 
    @Override
    public List<Map> findMapBySql(String sql) {
        Query query = getSession().createSQLQuery(sql);
        query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
        return query.list();
    }
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#findListBySql(java.lang.String,
     * java.lang.Object[])
     */
    @Override
    public <T> List<T> findListBySql(String sql, Object... objects) {
        Query query = getSession().createSQLQuery(sql);
        setParameter(query, objects);
        return query.list();
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#saveObject(java.lang.Object)
     */
    @Override
    public <T> void saveObject(T obj) {
        getSession().save(obj);
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#updateObject(java.lang.Object)
     */
    @Override
    public <T> void updateObject(T obj) {
        getSession().update(obj);
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#saveOrUpdateObject(java.lang.Object)
     */
    @Override
    public <T> void saveOrUpdateObject(T obj) {
        getSession().saveOrUpdate(obj);
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#executeSql(java.lang.String)
     */
    @Override
    public int executeSql(String sql) {
        Query query = getSession().createSQLQuery(sql);
        return query.executeUpdate();
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#executeSql(java.lang.String,
     * java.lang.Object[])
     */
    @Override
    public int executeSql(String sql, Object... objects) {
        Query query = getSession().createSQLQuery(sql);
        setParameter(query, objects);
        return query.executeUpdate();
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#coutObjects(java.lang.String)
     */
    @Override
    public int coutObjects(String hql) {
        Query query = getSession().createQuery(hql);
        ScrollableResults sr = query.scroll();
        sr.last();
        return sr.getRowNumber() == -1 ? 0 : sr.getRowNumber() + 1;
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#countObjects(java.lang.String,
     * java.lang.Object[])
     */
    @Override
    public int countObjects(String hql, Object... objects) {
        Query query = getSession().createQuery(hql);
        setParameter(query, objects);
        ScrollableResults sr = query.scroll();
        sr.last();
        return sr.getRowNumber() == -1 ? 0 : sr.getRowNumber() + 1;
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#findPageList(java.lang.String, int, int)
     */
    @Override
    public <T> PageList<T> findPageList(String hql, int page, int rows) {
        Query query = getSession().createQuery(hql);
        return findPageList(query, page, rows);
    }
 
    /*
     * (non-Javadoc)
     * 
     * @see com.school.dao.BaseDao#findPageList(java.lang.String, int, int,
     * java.lang.Object[])
     */
    @Override
    public <T> PageList<T> findPageList(String hql, int page, int rows,
            Object... objects) {
        Query query = getSession().createQuery(hql);
        setParameter(query, objects);
        return findPageList(query, page, rows);
    }
 
    <T> PageList<T> findPageList(Query query, int page, int rows) {
        ScrollableResults sr = query.scroll();
        sr.last();
        int count = sr.getRowNumber() == -1 ? 0 : sr.getRowNumber() + 1;
        query.setFirstResult((page - 1) * rows);
        query.setMaxResults(rows);
        return new PageList<T>(page, rows, count, query.list());
    }
 
    void setParameter(Query query, Object... objects) {
        for (int i = 0; i < objects.length; i++) {
            query.setParameter(i, objects[i]);
        }
    }
    
    
    @Override
	public void delete(Class<T> clazz, Long id) throws Exception {
		this.getSession().delete(loadById(clazz, id));
	}

	/*
	 * (�� Javadoc) <p>Title: update</p> <p>Description:����һ����¼ </p>
	 * 
	 * @param t
	 * 
	 * @see com.tcardz.dao.IBaseDao#update(java.lang.Object)
	 */
	@Override
	public void update(T t) throws Exception {
//		Session session = this.getSession().getSessionFactory()
//				.getCurrentSession();
//		
//		session.merge(t);
		this.getSession().update(t);
	}

	/*
	 * (�� Javadoc) <p>Title: save</p> <p>Description:����һ����¼ </p>
	 * 
	 * @param t
	 * 
	 * @see com.tcardz.dao.IBaseDao#save(java.lang.Object)
	 */
	@Override
	public Long save(T t) throws Exception {
		Long id = (Long) this.getSession().save(t);
		return id;
	}

	/*
	 * (�� Javadoc) <p>Title: getById</p> <p>Description: </p>
	 * 
	 * @param t
	 * 
	 * @param id
	 * 
	 * @return
	 * 
	 * @see com.tcardz.dao.IBaseDao#getById(java.lang.Object, java.lang.Long)
	 */
	@Override
	public T getById(Class<T> clazz, Long id) throws Exception {

		return (T) this.getSession().get(clazz, id);
	}

	@Override
	public T loadById(Class<T> clazz, Long id) throws Exception {
		return (T) this.getSession().load(clazz, id);
	}
	
	@Override
	public T findObjByProperty(Class<T> clazz, Map<String, Object> properties)
			throws Exception {
		Session session = this.getSession().getSessionFactory()
				.getCurrentSession();
		Criteria criteria = session.createCriteria(clazz);
		Set<String> keySet = properties.keySet();
		Iterator<String> iterator = keySet.iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			criteria.add(Restrictions.eq(key, properties.get(key)));
		}
		List<T> list = criteria.list();
		if (list.size() > 0) {
			return list.get(0);
		} else {
			return null;
		}
	}

	@Override
	public Object findUniqueByHql(String hql, Object... params)
			throws Exception {
		Session session = getSession();
		Query query = session.createQuery(hql);
		for (int i = 0; i < params.length; i++) {
			query.setParameter(i, params[i]);
		}
		return query.uniqueResult();
	}
	
}  