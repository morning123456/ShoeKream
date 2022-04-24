package kr.or.ddit.basic.stream;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.EOFException;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;
import java.util.Set;


/*
 *  문제) 이름,주소,전화번호를 멤버로 갖는 phone클래스를 만들고,
 *       Map을 이용하여 전화번호 정보를 관리하는 프로그램을 작성하시오.
 *       
 *       전화번호 정보는 Map에 저장하여 관리한다.
 *       (key값은 입력받은 사람의 '이름'으로 하고, value값은 'Phone클래스의 인스턴스'로 한다.)
 *       
 *       아래 메뉴의 기능을 모두 작성하시오.
 *       (삭제,검색,기능은'이름'을 입력 받아 처리한다.)
 *       
 *       메뉴 예시)
 *        1. 전화번호 등록
 *        2. 전화번호 수정  
 *        3. 전화번호 삭제   
 *        4. 전화번호 검색
 *        5. 전화번호 전체 출력
 *        0. 프로그램 종료
 *       ---------------------------------------
 *       메뉴 예시)
 *        1. 전화번호 등록
 *        2. 전화번호 수정  
 *        3. 전화번호 삭제   
 *        4. 전화번호 검색
 *        5. 전화번호 전체 출력
 *        0. 프로그램 종료
 *        ------------------------------------
 *        번호 입력>> 1
 *        
 *        새롭게 등록할 전화번호 정보를 입력하세요.
 *        이름 >> 홍길동
 *        전화번호 >> 010-1111-1111
 *        주소 >> 대전 중구 오류동
 *        
 *        '홍길동'전화번호 정보 등록 완료!!
 *      
 *        메뉴 예시)
 *        1. 전화번호 등록
 *        2. 전화번호 수정  
 *        3. 전화번호 삭제   
 *        4. 전화번호 검색
 *        5. 전화번호 전체 출력
 *        0. 프로그램 종료
 *        ------------------------------------
 *        번호 입력>> 1
 *        
 *        새롭게 등록할 전화번호 정보를 입력하세요.
 *        이름 >> 홍길동
 *        
 *        '홍길동'은 이미 등록된 사람입니다.
 *        
 *        메뉴 예시)
 *        1. 전화번호 등록
 *        2. 전화번호 수정  
 *        3. 전화번호 삭제   
 *        4. 전화번호 검색
 *        5. 전화번호 전체 출력
 *        0. 프로그램 종료
 *        -----------------------------------------
 *        번호입력 >> 5
 *        -----------------------------------------
 *        번호    이름         전화번호           주소
 *        1     홍길동     010-1111-1111  대전 중구 오류동
 *        ~~~
 *        -------------------------------------------
 *        출력완료..
 *        
 *        추가조건)
 *        1) '6. 전화번호 저장' 메뉴를 추가하고 구현한다.
 *           (저장파일명은 'phoneData.dat' 로 한다.)
 *        2) 프로그램이 시작될 때 저장된 파일이 있으면 그 데이터를 읽어와 Map에 저장한다.
 *        3) 프로그램을 종료할 때 Map의 데이터가 수정되거나 추가 또는 삭제되면 저장한 후 종료되도록 한다.
 *        
 *        
 *         메뉴 예시)
 *        1. 전화번호 등록
 *        2. 전화번호 수정  
 *        3. 전화번호 삭제   
 *        4. 전화번호 검색
 *        5. 전화번호 전체 출력
 *        6. 전화번호 저장
 *        0. 프로그램 종료
 *        
 *        -----------------------------------------
 *        번호입력 >> 0
 *        
 *        프로그램을 종료합니다.
 */

public class PhoneBookTest23 {
	private HashMap<String, Phone> phoneBookMap;
	private Scanner scan;
	private Set<String> phoneKeySet;
	
	
	
	
	// 생성자
	public PhoneBookTest23() {
		phoneBookMap = new HashMap<String, Phone>();
		scan = new Scanner(System.in);
	}
	
	public static void main(String[] args) {
		new PhoneBookTest23().phoneStart();
	}
	
	// 프로그램을 시작하는 메서드
	public void phoneStart() {
		System.out.println();
		System.out.println("*************************");
		System.out.println("    전화번호 관리 프로그램");
		System.out.println("*************************");
		System.out.println();
		
		while(true) {
			int choice = displayMenu();
			switch(choice) {
				case 1 :		// 등록
					insert(); break;
				case 2 :		// 수정
					update(); break;
				case 3 :		// 삭제
					delete(); break;
				case 4 :		// 검색
					search(); break;
				case 5 :		// 전체 출력
					displayAll(); break;
				case 6 :		// 전체 출력
					save(); break;	
					
				case 0 :
					System.out.println("프로그램을 종료합니다.");
					return;
				default :
					System.out.println("작업 번호를 잘못 입력했습니다.");
					System.out.println("다시 선택하세요.");
			}
		}
		
	}
	
	private void save() {

/*		System.out.print("저장할 이름을 입력하세요 > ");		
		String name = scan.next();
		
		Phone p = phoneBookMap.get(name);
		
		//Phone phone = new Phone(p.name,p.addr,p.tel);
		Phone phone1 = new Phone(p.getName(),p.getAddr(),p.getTel());
		
			try {
				// 객체를 파일로 저장하기
				FileOutputStream fout = new FileOutputStream("d:/d_Other/memObj.text");
				
				BufferedOutputStream bout = new  BufferedOutputStream(fout);  // 
				
				ObjectOutputStream oout = new ObjectOutputStream(bout);
				
				//쓰기 작업
				System.out.println(name+ "님  전화번호 저장하기 시작...");
				oout.writeObject(phone1);
				
				System.out.println("객체 저장 작업 끝...");
				
				oout.close(); //스트림 닫기	
			
			} catch (IOException e) {
				e.printStackTrace();
			}	
			
*/			
		
		
			
			// 모든 key값 가져오기
			 phoneKeySet = phoneBookMap.keySet();
			
			System.out.println("------------------------------");
			System.out.println(" 저장하시겠습니까?");
			String yn = scan.next();
			if(yn.equals("y")) {
							
				for(String name : phoneKeySet) {
					Phone p = phoneBookMap.get(name);	
					
					Phone phone1 = new Phone(p.getName(),p.getAddr(),p.getTel());
					
					
					
					try {
						// 객체를 파일로 저장하기
						FileOutputStream fout = new FileOutputStream("d:/d_Other/memObj.text");
						
						BufferedOutputStream bout = new  BufferedOutputStream(fout);  // 
						
						ObjectOutputStream oout = new ObjectOutputStream(bout);
						
						//쓰기 작업
						//System.out.println(name+ "님  전화번호 저장하기 시작...");
						oout.writeObject(phone1);
						
						System.out.println("객체 저장 작업 끝...");
						
						oout.close(); //스트림 닫기	
					
					} catch (IOException e) {
						e.printStackTrace();
					}	
					
				}
					//저장된 객체를 읽어와 그 내용을 화면에 출력하기 
					
					ObjectInputStream oin =null;
					try {
						// 입력용 스트림 객체 생성
						 oin = new ObjectInputStream
								                   (new BufferedInputStream
								                       (new FileInputStream("d:/d_Other/memObj.text")
								                    )
								                 );
						
						Object obj; //읽어온 객체를 저장할 변수
						
						System.out.println("객체 읽기 작업 시작");
						
						// readObject()메서드가 데이터를 끝까지 다 읽어오면 EOFException이 발생한다
						while((obj=oin.readObject())!=null) {
							//읽어노 데이터를 원래의 객체형으로 형변환 후에 사용한다.
							Phone phone1 = (Phone)obj;
									System.out.println("이름 :"+phone1.getName());
									System.out.println("번호 :"+phone1.getTel());
									System.out.println("주소 :"+phone1.getAddr());
									System.out.println("----------------------------------------");
						}
						
					} catch(EOFException e) {
						System.out.println("객체 읽기 작업 끝...");
					} catch (IOException e) {
						e.printStackTrace();
					}catch (ClassNotFoundException e) {
						e.printStackTrace();
					}catch(Exception e){
						e.printStackTrace();
					} finally {
						if(oin!=null) {
							try {oin.close();} catch (IOException e2) {}
						}
					
					}
				
					
				
			}
			
}

	// 전화번호 정보를 검색하는 메서드
	private void search() {
		System.out.println();
		System.out.println("검색할 전화번호 정보를 입력하세요...");
		System.out.print("이름 >> ");
		String name = scan.next();
		
		// 입력한 사람의 이름이 전화번호 정보에 없으면...
		if(!phoneBookMap.containsKey(name)) {
			System.out.println(name + "씨는 등록되지 않은 사람입니다.");
			System.out.println("검색 작업을 마칩니다.");
			return;
		}
		
		Phone p = phoneBookMap.get(name);
		System.out.println(name + "씨의 전화번호 정보");
		System.out.println("====================");
		System.out.println(" 이   름 : " + p.getName());
		System.out.println(" 전화번호 : " + p.getTel());
		System.out.println(" 주   소 : " + p.getAddr());
		System.out.println("====================");
		
	}
	
	
	// 전화번호 정보를 삭제하는 메서드
	private void delete() {
		System.out.println();
		System.out.println("삭제할 전화번호 정보를 입력하세요...");
		System.out.print("이름 >> ");
		String name = scan.next();
		
		// 입력한 사람의 이름이 전화번호 정보에 없으면...
		if(!phoneBookMap.containsKey(name)) {
			System.out.println(name + "씨는 등록되지 않은 사람입니다.");
			System.out.println("삭제 작업을 마칩니다.");
			return;
		}
		
		phoneBookMap.remove(name);
		
		System.out.println(name + "씨 전화번호 정보 삭제 완료!!!");
		
	}
	
	// 전화번호 정보를 수정하는 메서드
	private void update() {
		System.out.println();
		System.out.println("수정할 전화번호 정보를 입력하세요.");
		System.out.print("이름 >> ");
		String name = scan.next();
		
		// 입력한 사람의 이름이 전화번호 정보에 없으면...
		if(!phoneBookMap.containsKey(name)) {
			System.out.println(name + "씨는 등록되지 않은 사람입니다.");
			System.out.println("수정 작업을 마칩니다.");
			return;
		}
		
		System.out.print("새로운 전화번호 >> ");
		String newTel = scan.next();
		
		System.out.print("새로운 주소 >> ");
		String newAddr = scan.next();
		
		phoneBookMap.put(name, new Phone(name, newAddr, newTel));
		System.out.println(name + "씨의 전화번호 정보 수정완료!!");
	}
	
	
	// 전화번호 정보 전체 자료를 출력하는 메서드
	private void displayAll() {
		System.out.println();
		
		// 모든 key값 가져오기
		 phoneKeySet = phoneBookMap.keySet();
		
		System.out.println("------------------------------");
		System.out.println(" 번호    이름    전화번호     주소");
		System.out.println("------------------------------");
		if(phoneKeySet.size()==0) {
			System.out.println("등록된 전화번호 정보가 하나도 없습니다.");
		}else {
			int cnt = 0;  // 번호 출력용 변수
			for(String name : phoneKeySet) {
				cnt++;
				Phone p = phoneBookMap.get(name);
				System.out.println(cnt + "  " + name + "  " + 
					p.getTel() + "  " + p.getAddr());
			}
		}
		System.out.println("------------------------------");
		System.out.println("출력 끝...");
		
	}
	
	// 새로운 전화번호 정보를 등록하는 메서드
	private void insert() {
		System.out.println();
		System.out.println("새롭게 등록할 전화번호 정보를 입력하세요.");
		System.out.print("이름 >> ");
		String name = scan.next();
		
		// 이미 등록된 사람인지 여부를 검사한다.
		if(phoneBookMap.containsKey(name)) {
			System.out.println(name + "씨는 이미 등록된 사람입니다.");
			return;
		}
		
		System.out.print("전화번호 >> ");
		String tel = scan.next();
		
		scan.nextLine();  // 입력 버퍼 비우기
		System.out.print("주소 >> ");
//		String addr = scan.next();
		String addr = scan.nextLine();
		
		/*
		Scanner객체의 입력 메서드의 특징
		- next(), nextInt(), nextDouble(),.... 등
		 	==> 사이띄기, Tab키, Enter키를 구분 문자로 분리해서
		 		분리된 자료만 읽어간다.
		- nextLine() 
		 	==> 한 줄 단위로 입력한다. 즉, 자료를 입력하고 Enter키를
		 		누르면 Enter키까지 읽어간다.
		 		
		- Scanner는 입력한 값이 입력버퍼에 먼저 저장된 후에 차례로
		  꺼내와서 처리된다. 		
		
		
		*/
		
//		Phone p = new Phone(name, addr, tel);
//		phoneBookMap.put(name, p);
		
		phoneBookMap.put(name, new Phone(name, addr, tel));
		
		System.out.println(name + "씨 전화번호 등록 완료!!!");
		
	}
	
	
	
	// 메뉴를 출력하고 작업 번호를 입력받아 반환하는 메서드
	private int displayMenu() {
		System.out.println();
		System.out.println("----------------------");
		System.out.println(" 1. 전화번호 등록");
		System.out.println(" 2. 전화번호 수정");
		System.out.println(" 3. 전화번호 삭제");
		System.out.println(" 4. 전화번호 검색");
		System.out.println(" 5. 전화번호 전체 출력");
		System.out.println(" 6. 전화번호 저장");
		System.out.println(" 0. 프로그램 종료");
		System.out.println("----------------------");
		System.out.print("번호 입력 >> ");
		int num = scan.nextInt();
		return num;
	}
	
	

}

// 하나의 전화번호 정보가 저장될 class 작성
class Phone implements  Serializable{
	public String name;
	public String addr;
	public String tel;
	
	// 생성자
	public Phone(String name, String addr, String tel) {
		super();
		this.name = name;
		this.addr = addr;
		this.tel = tel;
	}

	

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	@Override
	public String toString() {
		return "Phone [name=" + name + ", addr=" + addr + ", tel=" + tel + "]";
	}
	
}











