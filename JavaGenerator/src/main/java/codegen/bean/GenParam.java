package codegen.bean;

public class GenParam {

	/**
	 * 表名
	 */
	private String table;
	/**
	 * 数据库url
	 */
	private String url;
	/**
	 * 数据库用户名
	 */
	private String username;
	/**
	 * 数据库密码
	 */
	private String password;
	/**
	 * 桌面地址
	 */
	private String desktop;
	
	private String ignorePrefix;
	
	/**
	 * 导出地址
	 */
	private String exportPath;
	/**
	 * 基础包名
	 */
	private String package_;
	
	/**
	 * 路由路径
	 */
	private String routePath;
	
	/**
	 * 模块名
	 */
	private String moduleTitle;
	
	
	private String className;
	private String url_host;
	private String url_port;
	private String url_db;
	private String pk;
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
	}
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
	public String getDesktop() {
		return desktop;
	}
	public void setDesktop(String desktop) {
		this.desktop = desktop;
	}
	public String getIgnorePrefix() {
		return ignorePrefix;
	}
	public void setIgnorePrefix(String ignorePrefix) {
		this.ignorePrefix = ignorePrefix;
	}
	public String getExportPath() {
		return exportPath;
	}
	public void setExportPath(String exportPath) {
		this.exportPath = exportPath;
	}
	public String getPackage_() {
		return package_;
	}
	public void setPackage_(String package_) {
		this.package_ = package_;
	}
	public String getRoutePath() {
		return routePath;
	}
	public void setRoutePath(String routePath) {
		this.routePath = routePath;
	}
	public String getModuleTitle() {
		return moduleTitle;
	}
	public void setModuleTitle(String moduleTitle) {
		this.moduleTitle = moduleTitle;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getUrl_host() {
		return url_host;
	}
	public void setUrl_host(String url_host) {
		this.url_host = url_host;
	}
	public String getUrl_port() {
		return url_port;
	}
	public void setUrl_port(String url_port) {
		this.url_port = url_port;
	}
	public String getUrl_db() {
		return url_db;
	}
	public void setUrl_db(String url_db) {
		this.url_db = url_db;
	}
	public String getPk() {
		return pk;
	}
	public void setPk(String pk) {
		this.pk = pk;
	}
}
