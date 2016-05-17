package codegen.utils;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import codegen.bean.GenParam;
import codegen.utils.bean.DataBaseColumn;
import codegen.utils.bean.DataBaseTable;

/**数据库操作类，主要是读取字段类型等
 * @author Danny
 *
 */
public class DbHelper {

	private  String url;
	private  String username;
	private  String password;
	private  String driver = "com.mysql.jdbc.Driver";
	
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDriver() {
		return driver;
	}

	public void setDriver(String driver) {
		this.driver = driver;
	}

	{
		try {
			Class.forName(driver);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws SQLException{
		Connection con = null;
		con = DriverManager.getConnection(url,username, password);

		return con;
	}
	
	public void closeConnection(Connection con) {

		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取数据库中表的信息
	 * @throws SQLException 
	 */
	public List<DataBaseTable> getTables() throws SQLException{
		List<DataBaseTable> list = new ArrayList<>();
		
		Connection con = getConnection();
		DatabaseMetaData databaseMetaData = con.getMetaData();
		 
        //获取所有表
        ResultSet rs = databaseMetaData.getTables(con.getCatalog(), "%", "%", new String[]{"TABLE"});
        
        while(rs.next()){
        	DataBaseTable table = new DataBaseTable();
        	table.setTableComment(rs.getString("REMARKS"));
        	table.setTableName(rs.getString("TABLE_NAME"));
        	list.add(table);
        }
        
        closeConnection(con);
        return list;
	}
	/**
	 * 获取数据库中表的信息
	 * @throws Exception 
	 */
	public DataBaseTable getTable(String tableName) throws Exception{
		DataBaseTable table = new DataBaseTable();
		table.setTableName(tableName);
		
		Connection con = getConnection();
		DatabaseMetaData databaseMetaData = con.getMetaData();
		
		//获取所有表
		ResultSet rs = databaseMetaData.getTables(con.getCatalog(), "%", tableName, new String[]{"TABLE"});
		
		while(rs.next()){
			table.setTableComment(rs.getString("REMARKS"));
		}
		
		table.setColumnList(getColumns(tableName));
		
		closeConnection(con);
		return table;
	}
	
	/**获取列信息
	 * @param tableName
	 * @return
	 * @throws Exception
	 */
	public List<DataBaseColumn> getColumns(String tableName) throws Exception{
		List<DataBaseColumn> list = new ArrayList<>();
		Connection con = getConnection();
		DatabaseMetaData databaseMetaData = con.getMetaData();
		
		ResultSet rs = databaseMetaData.getColumns(null, "%", tableName, "%");
		
		while(rs.next()){
			DataBaseColumn column = new DataBaseColumn();
			column.setColumnComment(rs.getString("REMARKS"));
			column.setColumnName(rs.getString("COLUMN_NAME"));
			column.setSqlType(rs.getInt("DATA_TYPE"));
			column.setSqlTypeName(rs.getString("TYPE_NAME"));
			column.setJavaType(getJavaType(column.getSqlType()));
			list.add(column);
		}
		
		closeConnection(con);
		return list;
	}
	
	/**获取java类型
	 * @param dataType
	 * @return
	 */
	public String getJavaType(int dataType){
		String result = null;
		switch(dataType){
			case 4:case 5:case -6:result = "Integer";break;
			case 1:case -1:case 12:result = "String";break;
			case 8:result = "Double";break;
			case 3:case -5:result = "java.math.BigInteger";break;
			case 6:result = "Float";break;
			case 91:case 92:case 93:result="java.util.Date";break;
			case Types.LONGVARBINARY:result="java.io.InputStream";break;
			default: result = "String";
		}
		return result;
	}
	
	public void initParam(GenParam genParam){
		String url = "jdbc:mysql://"+genParam.getUrl_host()+":"+genParam.getUrl_port()+"/"+genParam.getUrl_db()+"?characterEncoding=utf8&useInformationSchema=true";
	
		this.url = url;
		this.username = genParam.getUsername();
		this.password = genParam.getPassword();
	}
}
