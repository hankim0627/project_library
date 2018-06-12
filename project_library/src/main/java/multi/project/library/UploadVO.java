package multi.project.library;

import org.springframework.web.multipart.MultipartFile;

public class UploadVO {
	String name;
	MultipartFile file1 =null, file2=null, file3=null;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public MultipartFile getFile1() {
		return file1;
	}
	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}
	public MultipartFile getFile2() {
		return file2;
	}
	public void setFile2(MultipartFile file2) {
		this.file2 = file2;
	}
	public MultipartFile getFile3() {
		return file3;
	}
	public void setFile3(MultipartFile file3) {
		this.file3 = file3;
	}
	
	
}
