package codegen.test;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import codegen.utils.DbHelper;
import codegen.utils.bean.DataBaseColumn;
import codegen.utils.bean.DataBaseTable;


public class WriteTableDocument {
	static DbHelper helper = new DbHelper();
	static String[] tables = new String[]{"t_classes","t_event","t_event_comment","t_homework","t_message","t_party","t_stu","t_stu_pics"};
	static HSSFWorkbook workbook = new HSSFWorkbook();

	public static void main(String[] args) throws Exception {
		helper.setUrl("jdbc:mysql://localhost:3306/classes?characterEncoding=utf8&useInformationSchema=true");
		helper.setUsername("root");
		helper.setPassword("804956748");
		
		for(String table:tables){
			run(table);
		}
	}

	
	public static void run(String tableName) throws Exception{
		DataBaseTable table = helper.getTable(tableName);
		List<DataBaseColumn> col = table.getColumnList();


		HSSFSheet sheet = workbook.createSheet(tableName);
		
		HSSFCellStyle cell_Style = workbook.createCellStyle();// 设置字体样式
		cell_Style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		
		HSSFRow row = sheet.createRow(0);
		HSSFCell cell = row.createCell(0);
		cell.setCellStyle(cell_Style);
		
		cell.setCellValue(table.getTableName()+":"+table.getTableComment());
		row = sheet.createRow(1);	
		
		String[] head = new String[]{"字段名称","字段类型","Java类型","字段注释","是否主键"};
		for(int i = 0;i<head.length;i++){
			HSSFCell _cell = row.createCell(i);
			_cell.setCellStyle(cell_Style);
			_cell.setCellValue(head[i]);
		}
		
		
		for(int i = 0;i<col.size();i++){
			DataBaseColumn _col = col.get(i);
			row = sheet.createRow(i+2);
			
			String[] values = new String[]{
				_col.getColumnName(),
				_col.getSqlTypeName()+"("+_col.getColumnSize()+")",
				_col.getJavaType(),
				_col.getColumnComment(),
				_col.getIsPK()?"是":"否"
			};
			
			for(int j = 0;j<values.length;j++){
				HSSFCell _cell = row.createCell(j);
				cell.setCellStyle(cell_Style);
				_cell.setCellValue(values[j]);
			}
			
		}
		
		File excelfile = new File("C:\\Users\\Danny\\Desktop\\1.xls");
		FileOutputStream fileout = new FileOutputStream(excelfile);
		
		fileout.flush();
		workbook.write(fileout);

		fileout.close();
		workbook.close();
	}
}
