package codegen.utils.bean;

import java.util.ArrayList;
import java.util.List;

/**
 * 数据表信息
 * 
 * @author Danny
 *
 */
public class DataBaseTable {
	private String tableName;
	private String tableComment;
	private List<DataBaseColumn> columnList = new ArrayList<DataBaseColumn>();

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getTableComment() {
		return tableComment;
	}

	public void setTableComment(String tableComment) {
		this.tableComment = tableComment;
	}

	public List<DataBaseColumn> getColumnList() {
		return columnList;
	}

	public void setColumnList(List<DataBaseColumn> columnList) {
		this.columnList = columnList;
	}
}
