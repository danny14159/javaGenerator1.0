package codegen.utils.bean;

public class DataBaseColumn {
	/**
	 * 列名
	 */
	private String columnName;
	/**
	 * 列注释
	 */
	private String columnComment;
	/**
	 * SQL类型 int类型
	 */
	private Integer sqlType;
	
	private String sqlTypeName;
	
	private int columnSize;
	
	public int getColumnSize() {
		return columnSize;
	}

	public void setColumnSize(int columnSize) {
		this.columnSize = columnSize;
	}

	private String javaType;
	
	private Boolean isPK;

	public Boolean getIsPK() {
		return isPK;
	}

	public void setIsPK(Boolean isPK) {
		this.isPK = isPK;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getColumnComment() {
		return columnComment;
	}

	public void setColumnComment(String columnComment) {
		this.columnComment = columnComment;
	}

	public Integer getSqlType() {
		return sqlType;
	}

	public void setSqlType(Integer sqlType) {
		this.sqlType = sqlType;
	}

	public String getSqlTypeName() {
		return sqlTypeName;
	}

	public void setSqlTypeName(String sqlTypeName) {
		this.sqlTypeName = sqlTypeName;
	}

	public String getJavaType() {
		return javaType;
	}

	public void setJavaType(String javaType) {
		this.javaType = javaType;
	}
}
