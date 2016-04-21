package codegen.utils;

import java.io.File;

import javax.swing.filechooser.FileSystemView;

public class SystemUtils {

	/**获取桌面路径
	 * @return
	 */
	public static String getDesktopPath(){
		File desktopDir = FileSystemView.getFileSystemView()
				.getHomeDirectory();
		String desktopPath = desktopDir.getAbsolutePath();
		return desktopPath;
	}
	
	/**将表名转换成类名如t_table=>TTable
	 * @param tableName
	 * @param ignorePrefix 忽略的前缀
	 * @return
	 */
	public static String getClassNameFromTableName(String tableName,String ignorePrefix){
		
		String[] parts = tableName.split("_");
		
		int cursor = 0;
		String result = "";
		if(ignorePrefix!=null && ignorePrefix.equals(parts[0])){
			cursor++;
		}
		
		for(int len = parts.length;cursor<len;cursor++){
			result += firstCharToUpperCase(parts[cursor]);
		}
		
		return result;
	}
	
	/**首字母大写
	 * @param src
	 * @return
	 */
	public static String firstCharToUpperCase(String src){
		return (src.charAt(0)+"").toUpperCase() + src.substring(1);
	}
	
}
