package com.project.trinity.hospital.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.project.trinity.community.board.model.vo.Board;
import com.project.trinity.community.board.service.BoardService;
import com.project.trinity.hospital.model.vo.HospitalAccount;
import com.project.trinity.hospital.model.vo.HospitalInfo;
import com.project.trinity.hospital.service.HospitalService;
import com.project.trinity.member.model.vo.DoctorReview;
import com.project.trinity.member.model.vo.Member;
import com.project.trinity.member.service.MemberService;
import com.project.trinity.reservation.model.vo.CountReservation;
import com.project.trinity.reservation.model.vo.Reservation;
import com.project.trinity.reservation.service.ReservationService;

@Controller
@RequestMapping("hospital")
public class HospitalController {
	@Autowired
	private final HospitalService hospitalService;
	private final BCryptPasswordEncoder bcryptPasswordEncoder;
	private final MemberService memberService;
	private final ReservationService reservationService;
	private final BoardService boardService;
	
	
	
	@Autowired
	public HospitalController(HospitalService hospitalService, 
			MemberService memberService, 
			BCryptPasswordEncoder bcryptPasswordEncoder,
			ReservationService reservationService,
			BoardService boardService) {
	    this.hospitalService = hospitalService;
	    this.memberService = memberService;
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
		this.reservationService = reservationService;
		this.boardService = boardService;
	}

	
	
	@RequestMapping("/list")
	public String hospitalList(@RequestParam(value = "subject", defaultValue = "listAll") String subject,
	        				   @RequestParam(value = "order", defaultValue = "ASC") String order, 
	        				   Model m) {
		System.out.println(subject);
		System.out.println(order);
//		ArrayList<HospitalInfo> list = hospitalService.selectHospitalList(subject, order);
//		m.addAttribute("list", list);

//		System.out.println(list);
		return "hospital_detail/hospital_list";
	}
	
	@RequestMapping("/list/api")
    @ResponseBody
    public ArrayList<HospitalInfo> hospitalListPaginated(@RequestParam(value = "keyword", defaultValue = "") String keyword,
    													 @RequestParam(value = "subject", defaultValue = "listAll") String subject,
                                                         @RequestParam(value = "order", defaultValue = "ASC") String order,
                                                         @RequestParam(value = "page", defaultValue = "1") int page,
                                                         @RequestParam(value = "limit", defaultValue = "10") int limit,
                                                         Model m) {
		System.out.println("subject : " + subject);
		System.out.println("order : " + order);
		System.out.println("page : " + page);
		System.out.println("limit : " + limit);
		System.out.println("keyword : " + keyword);
        if(!keyword.equals("")) {
    		return hospitalService.searchHospital(keyword, subject, order, page, limit);
        } else {
            return hospitalService.selectHospitalListPaginated(subject, order, page, limit);

        }
    }
	
	@RequestMapping("/detail")
	public String hospitalDetail(String hosNo, Model m) {
		HospitalInfo hospitalInfo = hospitalService.selectHospitalInfo(hosNo);
		ArrayList<Member> doctorList = memberService.selectDoctorInfoList(hosNo);
		double rating[] = new double[doctorList.size()];
		for(int i = 0; i < doctorList.size(); i++) {
			String userNo = doctorList.get(i).getUserNo();
			System.out.println("userNO : " + userNo);
			ArrayList<DoctorReview> doctorReviews = memberService.selectDoctorReview(userNo);
			System.out.println(hospitalInfo);
//			System.out.println(doctorReviews);
			double avg = 0;
			if (doctorReviews.size() > 0) {
				for(int j = 0; j < doctorReviews.size(); j++) {
					avg += doctorReviews.get(j).getReviewRating();
				}
				avg /= doctorReviews.size();
				avg = Math.round(avg * 100) / 100.0;
			}
			rating[i] = avg;
			System.out.println(rating[i]); 
		}
		
		m.addAttribute("hospitalInfo", hospitalInfo);
		m.addAttribute("doctorList", doctorList);
		m.addAttribute("rating", rating);
		
	
		return "hospital_detail/hospital_detail";
	}
	
	@RequestMapping(value = "/detail/doctorBiography", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String doctorBiography(@RequestParam(value = "doctorNo") String doctorNo) {
		System.out.println("doctorNo : " + doctorNo);
		String doctorBiography = memberService.selectDoctorBiography(doctorNo);
		System.out.println("doctorBiography : " + doctorBiography);
		return doctorBiography;
    }
	
	@RequestMapping("/detail/doctorReview")
    @ResponseBody
    public ArrayList<DoctorReview> doctorReviewList(@RequestParam(value = "doctorNo") String doctorNo) {
		System.out.println("doctorNo : " + doctorNo);
		ArrayList<DoctorReview> doctorReviews = memberService.selectDoctorReview(doctorNo);
		System.out.println("doctorReviews : " + doctorReviews);
		return doctorReviews;
    }
	
	@RequestMapping("/detail/uploadReview")
    @ResponseBody
    public ArrayList<DoctorReview> uploadReview(@RequestParam(value = "writerNo") String writerNo,
    											@RequestParam(value = "doctorNo") String doctorNo,
    											@RequestParam(value = "reviewTitle") String reviewTitle,
    											@RequestParam(value = "reviewContent") String reviewContent,
    											@RequestParam(value = "reviewRating") String reviewRating) {
		System.out.println("writerNo : " + writerNo);
		System.out.println("doctorNo : " + doctorNo);
		System.out.println("reviewTitle : " + reviewTitle);
		System.out.println("reviewContent : " + reviewContent);
		System.out.println("reviewRating : " + reviewRating);
		int result = memberService.insertDoctorReview(writerNo, doctorNo, reviewTitle, reviewContent, reviewRating);
		ArrayList<DoctorReview> doctorReviews = null;
		if(result != 0) {
			System.out.println("리뷰 삽입 성공");
			doctorReviews = memberService.selectDoctorReview(doctorNo);
		} else {
			System.out.println("리뷰 삽입 실패");
		}
		
		//다시 리스트 불러오기
		return doctorReviews;
    }
	
	@RequestMapping("/detail/todayWaitingList")
    @ResponseBody
    public ArrayList<CountReservation> waitingList(@RequestParam(value = "hosNo") String hosNo) {
		System.out.println("hosNo : " + hosNo);
		//여기서부터
		ArrayList<CountReservation> watingList = reservationService.selectTodayWaitingList(hosNo);
		System.out.println("watingList : " + watingList);
		return watingList;
    }
	
	@RequestMapping("/list/openHos")
	public String OpenHospitalList(Model m) {
		ArrayList<HospitalInfo> searchList = hospitalService.selectOpenHospitalList();
		//여기부터 고치면됨. requestparam 추가하고 리스트 띄우기
		m.addAttribute("list", searchList);
		return "hospital_detail/openHospital_list";
	}
	
	@RequestMapping("/list/openHosApi")
    @ResponseBody
    public ArrayList<HospitalInfo> openHospitalListPaginated(@RequestParam(value = "subject", defaultValue = "listAll") String subject,
												             @RequestParam(value = "order", defaultValue = "ASC") String order,
												    		 @RequestParam(value = "page", defaultValue = "1") int page,
                                                         	 @RequestParam(value = "limit", defaultValue = "10") int limit) {
        return hospitalService.selectOpenHospitalListPaginated(subject, order, page, limit);
    }
	
	@RequestMapping("/account/insert")
	public String insertHospitalAccount(@ModelAttribute HospitalAccount hosAccount,
										 HttpServletRequest request,
										 RedirectAttributes redirectAttributes,
										 Model m
			) {
		HospitalInfo h = hospitalService.selectHospitalInfo(hosAccount.getHosNo());
		System.out.println(hosAccount);
		System.out.println(h);
		if(h.getHosId() == null) {
			
			String userPwdConfirm = request.getParameter("userPwdConfirm");

		    if (userPwdConfirm == null || !hosAccount.getHosPwd().equals(userPwdConfirm)) {
		        redirectAttributes.addFlashAttribute("message", "비밀번호가 일치하지 않습니다.");
		        return "redirect:/hospital/account/sign_up";
		    }
		    
		    hosAccount.setHosPwd(bcryptPasswordEncoder.encode(hosAccount.getHosPwd()));
		    
		    int result = hospitalService.insertHospital(hosAccount);
		    m.addAttribute("hosAcNo", hosAccount.getHosAcNo());
		    System.out.println(hosAccount.getHosAcNo());
		    if (result > 0) {
		        redirectAttributes.addFlashAttribute("message", "회원가입에 성공했습니다.");
		        return "redirect:/hospital/account/login";
		    } else {
		        redirectAttributes.addFlashAttribute("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
		        return "redirect:/hospital/account/sign_up";
		    }
		} else {
			redirectAttributes.addFlashAttribute("message", "이미 등록된 병원입니다.");
			return "redirect:/hospital/account/sign_up";
		}
	}
	
	@RequestMapping("/account/login")
	public String HospitalAccountLogin(@ModelAttribute HospitalAccount hosAccount,
									   Model m,
									   HttpSession session
			) {
		System.out.println(hosAccount);
		HospitalAccount loginHosAccount = hospitalService.loginHosAccount(hosAccount);
		System.out.println(loginHosAccount);
		if(loginHosAccount == null) {
			m.addAttribute("message", "로그인 실패 아이디를 확인하세요");
			return "hospital_detail/hospital_account_login";
		} else {
			if(bcryptPasswordEncoder.matches(hosAccount.getHosPwd(), loginHosAccount.getHosPwd())) {
				session.setAttribute("loginHosAccount", loginHosAccount);
				m.addAttribute("message", "로그인 성공");
				return "hospital_detail/hospital_account_main";
			} else {
				m.addAttribute("message", "로그인 실패 아이디와 비밀번호를 확인하세요");
				return "hospital_detail/hospital_account_login";
			}
		}
	}
	
	@RequestMapping("account/logout")
	public String logoutMember(HttpSession session, HttpServletResponse response) {
		session.invalidate();

		return "redirect:/";
	}
	
	// 아이디 중복 확인
	@ResponseBody
	@GetMapping("/idCheck")
	public int idCheck(@RequestParam("userId") String checkId) {
		return hospitalService.idCheck(checkId);
	}
	
	@RequestMapping("/account/doctor")
	public String HospitalAccountDoctor(HttpSession session) {
		HospitalAccount loginHosAccount = (HospitalAccount)session.getAttribute("loginHosAccount");
		String hosNo = loginHosAccount.getHosNo();
		System.out.println("hosNo : " + hosNo);
		
		ArrayList<Member> hosDrList = memberService.selectDoctorInfoList(hosNo);
		System.out.println(hosDrList);
		session.setAttribute("hosDrList", hosDrList);
		
		return "hospital_detail/hospital_account_doctor";
	}
	
	@RequestMapping("account/insert/doctor")
	public String HospitalAccountInsertDoctorMember(@RequestParam("userId") String userId,
													HttpSession session,
													RedirectAttributes re,
													Model m
			) {
		HospitalAccount loginHosAccount = (HospitalAccount)session.getAttribute("loginHosAccount");
		String hosNo = loginHosAccount.getHosNo();
		
		HashMap<String, String> hmap = new HashMap<String, String>();
		hmap.put("userId", userId);
		hmap.put("hosNo",hosNo);
		
		Member doctor = memberService.findByUserId(userId);
		
		if(doctor != null) {
			//회원이 의사일 경우
			if(doctor.getMedKey() != null) {
				int result = memberService.updateHospitalDoctor(hmap);
				
				if(result>0) {
					re.addFlashAttribute("message", "의사 등록 성공");
					return "redirect:/hospital/account/doctor";
				} else {
					m.addAttribute("message", "의사 등록 실패 아이디를 확인하세요");
					return "hospital_detail/hospital_account_insert_doctor";
				}
			} else {
				m.addAttribute("message", "의사 등록 실패 의사 등록이 안된 회원입니다");
				return "hospital_detail/hospital_account_insert_doctor";
			}	
		} else {
			m.addAttribute("message", "잘못된 ID 입니다");
			return "hospital_detail/hospital_account_insert_doctor";
		}
	}
	
	@RequestMapping("/account/myHospital")
	public String HospitalAccountMyHospital(HttpSession session, Model m) {
		HospitalAccount loginHosAccount = (HospitalAccount)session.getAttribute("loginHosAccount");
		if(loginHosAccount != null) {
			String hosNo = loginHosAccount.getHosNo(); 
			
			HospitalInfo hosInfo = hospitalService.selectHospitalInfo(hosNo);
			
			session.setAttribute("hosInfo", hosInfo);
			
			return "hospital_detail/hospital_account_my_hospital";
		} else {
			m.addAttribute("message", "로그인 오류 새로 시작 해주세요");
			return "hospital_detail/hospital_account_my_hospital";
		}
	}
	
	@RequestMapping("/account/myReservation")
	public String HospitalAccountMyReservation(HttpSession session, Model m) {
		HospitalAccount loginHosAccount = (HospitalAccount)session.getAttribute("loginHosAccount");
		String hosNo = loginHosAccount.getHosNo();
		
		ArrayList<Reservation> resList = reservationService.selectReservationHosNo(hosNo);
		System.out.println("resList : " + resList);
		
		session.setAttribute("resList", resList);
		
		return "hospital_detail/hospital_account_my_reservation";
	}
	
	@RequestMapping("/account/myReservation/detail")
	public String HospitalAccountMyReservationDetail(String resNo, HttpSession session, Model m) {
		
		Reservation myReservation = reservationService.selectReservationResNo(resNo);
		
		m.addAttribute("myReservation", myReservation);
		
		return "hospital_detail/hospital_account_reservation_detail";
	}
	
	@RequestMapping("account/doctor/detail")
	public String HospitalAccountDoctorDetail(String userId, Model m, HttpSession session) {
		Member doctor = memberService.findByUserId(userId);
		m.addAttribute("doctor", doctor);
		String hosNo = (String)session.getAttribute("hsoNo");
		ArrayList<DoctorReview> doctorReviews = memberService.selectDoctorReview(doctor.getUserNo());
//		System.out.println(doctorReviews);
		double avg = 0;
		if (doctorReviews.size() > 0) {
			for(int j = 0; j < doctorReviews.size(); j++) {
				avg += doctorReviews.get(j).getReviewRating();
			}
			avg /= doctorReviews.size();
			avg = Math.round(avg * 100) / 100.0;
		}
		double rating = avg;
		System.out.println(rating); 
	
		m.addAttribute("rating", rating);
		
		return "hospital_detail/hospital_account_doctor_detail";
	}
	
	@RequestMapping("account/doctor/delete")
	public String HospitalAccountDoctorDelete(String userNo, Model m, RedirectAttributes re) {
		
		int result = memberService.hospitalAccountDeleteDoctor(userNo);
		
		if(result > 0) {
			re.addAttribute("message", "의사 해제 성공");
			return "redirect:/hospital/account/doctor";
		} else {
			m.addAttribute("message", "의사 해제 실패");
			return "hospital_detail/hospital_account_doctor_detail";
		}
		
		
	}
	
	@RequestMapping("account/myHospital/update")
	public String HospitalAccountMyHospitalUpdate(@ModelAttribute HospitalInfo hosInfo, Model m) {
	    String hosLatitude = "";
	    String hosLongitude = "";
	    String result = "";
	    String url="https://dapi.kakao.com/v2/local/search/address.json?query=";
	    String restKey ="a0793b4d67a4236cf4900bc98535d171"; 
	    
	    try {
			url += URLEncoder.encode(hosInfo.getHosAddress(), "UTF-8");
			
			URL requestURL = new URL(url);
			
			HttpURLConnection urlConnection = (HttpURLConnection)requestURL.openConnection();
			
			urlConnection.setRequestMethod("GET");
			
			urlConnection.setRequestProperty("Authorization", "KakaoAK " + restKey);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
			
			
			String line;
			while((line = br.readLine()) != null) {
				result += line;
			}
			
			br.close();
			urlConnection.disconnect();
			
			// JSON 파싱
	        JsonObject jsonObject = JsonParser.parseString(result).getAsJsonObject();
	        JsonArray documents = jsonObject.getAsJsonArray("documents");
	        
	        // 첫 번째 documents 객체에서 x, y 값 추출
	        if (documents.size() > 0) {
	            JsonObject firstDocument = documents.get(0).getAsJsonObject();
	            hosLatitude = firstDocument.get("y").getAsString(); // 위도
	            hosLongitude = firstDocument.get("x").getAsString(); // 경도
	        }
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    System.out.println("Latitude (y): " + hosLatitude);
	    System.out.println("Longitude (x): " + hosLongitude);
	    System.out.println(result);
	    // 위도와 경도를 HospitalInfo 객체에 설정
	    hosInfo.setHosLatitude(hosLatitude);
	    hosInfo.setHosLongitude(hosLongitude);
	    
	    // DB 업데이트
	    int resultAC = hospitalService.updateMyHospitalAC(hosInfo);
	    int resultAI = hospitalService.updateMyHospitalAI(hosInfo);
	    
	    if(hosLatitude.equals("")) {
	    	m.addAttribute("message", "올바르지 않은 주소입니다.");
	        return "hospital_detail/hospital_account_my_hospital";
	    } else {
	    	// 결과 처리
		    if ((resultAC > 0) && (resultAI > 0)) {
		        m.addAttribute("message", "수정 성공");
		        return "hospital_detail/hospital_account_main";
		    } else {
		        m.addAttribute("message", "수정 실패");
		        return "hospital_detail/hospital_account_my_hospital";
		    }
	    }
	}
	
	@RequestMapping("/account/myPost")
	public String HospitalAccountMyPost(HttpSession session, Model m) {
		 // 로그인된 사용자 가져오기
	    HospitalAccount loginHosAccount = (HospitalAccount) session.getAttribute("loginHosAccount");
	    if (loginHosAccount == null) {
	        return "redirect:/hospital/login"; // 로그인 페이지로 리다이렉트
	    }

	    // 사용자 번호로 내가 쓴 게시글 조회
	    List<Board> myposts = boardService.getPostsByHosNo(loginHosAccount.getHosNo());
	    m.addAttribute("myposts", myposts);

	    return "hospital_detail/hospital_account_my_post";
	}

	//화면 이동 하는거
	@RequestMapping("/account/myPost/write")
	public String HospitalAccountMyPostWrite() {
		return "hospital_detail/hospital_account_post_write_form";
	}
	
	@RequestMapping("account/insertDr")
	public String HospitalAccountInsertDoctor() {
		return "hospital_detail/hospital_account_insert_doctor";	
	}
	
	@RequestMapping("/account/main")
	public String HospitalAccountMain() {
		return "hospital_detail/hospital_account_main";
	}
	
	@RequestMapping("/login")
	public String HospitalAccountLoginShow() {
		return "hospital_detail/hospital_account_login";
	}
	
	@RequestMapping("/account/sign_up")
	public String HospitalAccountSignUp() {
		return "hospital_detail/hospital_account_sign_up";
	}
}
