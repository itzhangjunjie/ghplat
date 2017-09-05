package com.gh.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.util.Map;
import java.util.Properties;

import javax.imageio.ImageIO;

import org.im4java.core.ConvertCmd;
import org.im4java.core.IMOperation;


/**
 * 
 * ImageMagick和im4java处理图片
 * 
 * @author sunlightcs
 * 
 *         2011-6-1
 * 
 *         http://hi.juziku.com/sunlightcs/
 */
public class ImageMagicTools {

	/**
	 * 
	 * ImageMagick的路径
	 */
	// public static String imageMagickPath = null;
	static {
		/**
		 * 
		 * 获取ImageMagick的路径
		 */
		// Properties prop = new PropertiesFile().getPropertiesFile();
		// linux下不要设置此值，不然会报错
		// imageMagickPath = prop.getProperty("imageMagickPath");
	}
	
	/**
	 * 判断系统类型
	 * @return
	 */
	public static boolean isWin(){
		Properties prop = System.getProperties();
		String os = prop.getProperty("os.name");
		if(os.toLowerCase().startsWith("win")){
			return true;
		}
		return false;
	}
	
	/**
	 * 设置ImageMagick的路径
	 */
	public static void searchImageMagicPath(ConvertCmd convert){
		if(isWin()){
			convert.setSearchPath("C:\\Program Files\\ImageMagick-6.8.8-Q16");
		}
	}

	/** 
	 * 保存图片 
	 * @param img 原图路径 
	 * @param dest 目标图路径 
	 * @param top 选择框的左边y坐标 
	 * @param left 选择框的左边x坐标 
	 * @param width 选择框宽度 
	 * @param height 选择框高度 
	 * @return 
	 * @throws Exception 
	 */ 
	public static boolean saveImage(File img, String dest,int top,int left,int width,int height,int maxWidth,Integer newImageWidth) throws Exception { 
		//换算尺度
        BufferedImage sourceImg =ImageIO.read(new FileInputStream(img)); 
        sourceImg.flush();
		top = top*sourceImg.getWidth()/maxWidth;
		left = left*sourceImg.getWidth()/maxWidth;
		width = width*sourceImg.getWidth()/maxWidth;
		height = height*sourceImg.getWidth()/maxWidth;
		height = Math.min(height, sourceImg.getHeight()); 
		width = Math.min(width, sourceImg.getWidth()); 
		if(height <= 0) height = sourceImg.getHeight(); 
		if(width <= 0) width = sourceImg.getWidth(); 
		top = Math.min(Math.max(0, top), sourceImg.getHeight()-height); 
		left = Math.min(Math.max(0, left), sourceImg.getWidth()-width); 
		if(left+width>sourceImg.getWidth()){
			left = sourceImg.getWidth()-width;
		}
		if(left<0){
			left = 0;
			width = sourceImg.getWidth();
		}
		if(top+height>sourceImg.getHeight()){
			top = sourceImg.getHeight() - height;
		}
		if(top<0){
			top = 0;
			height = sourceImg.getHeight();
		}
		ImageMagicTools.cutImage(img.getPath(),dest,left,top,left+width,top+height,newImageWidth);
		return true;
	} 

	/**
	 * 
	 * 根据坐标裁剪图片
	 * 
	 * @param srcPath   要裁剪图片的路径
	 * @param newPath   裁剪图片后的路径
	 * @param x         起始横坐标
	 * @param y         起始挫坐标
	 * @param x1                结束横坐标
	 * @param y1                结束挫坐标
	 * @param newWidth    压缩后的宽度
	 */
	public static void cutImage(String srcPath, String newPath, int x, int y, int x1,	int y1,Integer newWidth) throws Exception {
		int width = x1 - x;
		int height = y1 - y;
		IMOperation op = new IMOperation();
		op.addImage(srcPath);
		op.crop(width, height, x, y);
		op.quality(0.75);
		op.density(72);
		op.resize(newWidth);
		op.strip();
		op.addImage(newPath);
		ConvertCmd convert = new ConvertCmd();
		searchImageMagicPath(convert);
		convert.run(op);
	}

	/**
	 * 
	 * 根据尺寸缩放图片
	 * @param width             缩放后的图片宽度
	 * @param height            缩放后的图片高度
	 * @param srcPath           源图片路径
	 * @param newPath           缩放后图片的路径
	 */
	public static void cutImage(int width, int height, String srcPath,	String newPath) throws Exception {
		IMOperation op = new IMOperation();
		op.addImage(srcPath);
		op.resize(width, height);
		op.addImage(newPath);
		ConvertCmd convert = new ConvertCmd();
		searchImageMagicPath(convert);
		convert.run(op);

	}

	/**
	 * 根据宽度缩放图片
	 * 
	 * @param width            缩放后的图片宽度
	 * @param srcPath          源图片路径
	 * @param newPath          缩放后图片的路径
	 */
	public static void cutImage(int width, String srcPath, String newPath)	throws Exception {
		IMOperation op = new IMOperation();
		op.addImage(srcPath);
		op.resize(width,null,">");
		op.quality(0.75);
		op.density(72);
		op.strip();
		op.addImage(newPath);
		ConvertCmd convert = new ConvertCmd();
		searchImageMagicPath(convert);
		convert.run(op);
	}
	

	/**
	 * 给图片加水印
	 * @param srcPath            源图片路径
	 */
	public static void addImgText(String srcPath) throws Exception {
		IMOperation op = new IMOperation();
		op.font("宋体").gravity("southeast").pointsize(18).fill("#BCBFC8")
				.draw("text 5,5 www.ghplat.com");
		op.addImage();
		op.addImage();
		ConvertCmd convert = new ConvertCmd();
		searchImageMagicPath(convert);
		convert.run(op, srcPath, srcPath);
	}

	
}