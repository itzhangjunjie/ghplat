package com.gh.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;

import com.gh.util.PageList;

public interface IBaseService<T> {
	
	 /**
     * 
     * @param hql
     * @return
     */
    @SuppressWarnings("hiding")
	<T> T findObject(String hql);
     
    /**
     * 
     * @param hql
     * @param objects
     * @return
     */
    <T> T findObject(String hql, Object...objects);
     
    /**
     * 
     * @param cls
     * @param id
     * @return
     */
    <T> T findObject(Class<T> cls, Serializable id);
     
    /**
     * 
     * @param sql
     * @return
     */
    <T> T findObjectBySql(String sql);
     
    /**
     * 
     * @param sql
     * @param objects
     * @return
     */
    <T> T findObjectBySql(String sql, Object...objects);
     
    /**
     * 
     * @param hql
     * @return
     */
    <T> List<T> findList(String hql);
     
    /**
     * 
     * @param hql
     * @param objects
     * @return
     */
    <T> List<T> findList(String hql, Object...objects);
     
    /**
     * 
     * @param cls
     * @return
     */
    <T> List<T> findList(Class<T> cls);
     
    /**
     * 
     * @param sql
     * @return
     */
    <T> List<T> findListBySql(String sql);
     
    /**
     * 
     * @param sql
     * @param objects
     * @return
     */
    <T> List<T> findListBySql(String sql, Object...objects);
     
    /**
     * 
     * @param obj
     */
    <T> void saveObject(T obj);
     
    /**
     * 
     * @param obj
     */
    <T> void updateObject(T obj);
     
    /**
     * 
     * @param obj
     */
    <T> void saveOrUpdateObject(T obj);
     
    /**
     * 
     * @param sql
     * @return
     */
    int executeSql(String sql);
     
    /**
     * 
     * @param sql
     * @param objects
     * @return
     */
    int executeSql(String sql, Object...objects);
     
    /**
     * 
     * @param hql
     * @return
     */
    int coutObjects(String hql);
     
    /**
     * 
     * @param hql
     * @param objects
     * @return
     */
    int countObjects(String hql, Object...objects);
     
    /**
     * 
     * @param hql
     * @param page
     * @param rows
     * @return
     */
    <T> PageList<T> findPageList(String hql, int page, int rows);
     
    /**
     * 
     * @param hql
     * @param page
     * @param rows
     * @param objects
     * @return
     */
    <T> PageList<T> findPageList(String hql, int page, int rows, Object...objects);
    
    
    public void delete(Class<T> t ,Long id) throws Exception;

	public void update(T t) throws Exception;

	public Long save(T t) throws Exception;
	

	public  T getById(Class<T> clazz,Long id) throws Exception;
	
	
	public  T loadById(Class<T> clazz,Long id) throws Exception;
	
	public  T findObjByProperty(Class<T> clazz,Map<String , Object> properties) throws Exception;
	
	public Object findUniqueByHql(final String hql,final Object...params)throws Exception;
}
