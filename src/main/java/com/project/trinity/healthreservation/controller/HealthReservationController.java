package com.project.trinity.healthreservation.controller;


import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.trinity.healthreservation.service.HealthReservationService;
import com.project.trinity.hospital.model.vo.HospitalInfo;
import com.project.trinity.member.model.vo.Guest;
import com.project.trinity.member.model.vo.Member;
import com.project.trinity.reservation.model.vo.HealthReservation;

@Controller
@RequestMapping("/healthReservation")
public class HealthReservationController {

	@Autowired
    private HealthReservationService healthReservationService;

    // 백신 예약 페이지 1로 이동
    @GetMapping("/vaccinepage1")
    public String vaccineReservation1() {
        return "health_reservation/vaccine_reservation1";
    }

    // 백신 예약 페이지 2로 이동
    @PostMapping("/vaccinepage2")
    public String vaccineReservation2() {
        return "health_reservation/vaccine_reservation2";
    }


	@GetMapping("/guide")
	public String healthReservationGuide() {
		return "health_reservation/health_reservation_guide";
	}
	
	
	@GetMapping("/guideEven")
	public String cautionGuideEvening() {
		return "health_reservation/caution_guide_evening";
	}
	
	@GetMapping("/guideDday")
	public String cautionGuideDday() {
		return "health_reservation/caution_guide_dday";
	}
	
	@GetMapping("/guideEndo")
	public String cautionGuideEndoscope() {
		return "health_reservation/caution_guide_endoscope";
	}
	
	@GetMapping("/guideCt")
	public String cautionGuideCtMri() {
		return "health_reservation/caution_guide_ct_mri";
	}
	
	// 건강검진 
	@GetMapping("/reservation1")
	public String healthReservation1() {
		return "health_reservation/health_reservation1";
	}
	
	//예약조회
	@RequestMapping("/search")
	public String healthReservationSearch() {
		return "health_reservation/health_reservation_search";
	}
	
	@RequestMapping("/searchResult")
	public String healthReservationSearchResult(String hResNo, Model m) {
		HealthReservation healthReservation = healthReservationService.selectHealthReservation(hResNo);
		m.addAttribute("healthReservation",healthReservation);
		System.out.println(healthReservation);
		return "health_reservation/health_reservation_search_result";
	}
	
	// 건강검진 받는 사용자 정보 받아주는 컨트롤러
	@RequestMapping("/reservation2")
	public String healthReservation2(
			@RequestParam("reservation_user_name") String reservation_user_name,
			@RequestParam("reservation_user_num1") String reservation_user_num1,
			@RequestParam("reservation_user_num2") String reservation_user_num2,
			@RequestParam("reservation_user_phone1") String reservation_user_phone1,
			@RequestParam("reservation_user_phone2") String reservation_user_phone2,
			@RequestParam("reservation_user_email1") String reservation_user_email1,
			@RequestParam("reservation_user_email2") String reservation_user_email2,
			@RequestParam("postcode") String postcode,
			@RequestParam("address") String address,
			@RequestParam("extraAddress") String extraAddress,
			@RequestParam("detailAddress") String detailAddress,
			@RequestParam("use_tos_ans1") String use_tos_ans1,
			@RequestParam("use_tos_ans2") String use_tos_ans2,
			HttpSession session) {
		//이용약관 두개 다 동의 한 경우만 다음 페이지 리턴
		if((use_tos_ans1.equals("yes"))&&(use_tos_ans1.equals("yes"))) {
			
			//병원 정보 불러오기
			ArrayList<HospitalInfo> hospitalList = (ArrayList<HospitalInfo>) healthReservationService.selectHospitalList();
			session.setAttribute("hospitalList", hospitalList);
			//로그인 유저 정보 없으면 게스트 저장하고 게스트 넘버 반환
			if(session.getAttribute("loginUser") == null) {
				String gstName = reservation_user_name;
				String gstBirth = reservation_user_num1;
				String gstGender = "";
				//주민번호 뒷자리 홀수면 M, 짝수면 F로 반환
				if(Integer.parseInt(reservation_user_num2) %2 ==0) {
					gstGender = "F";
				} else {
					gstGender = "M";
				}
				String gstPhone = reservation_user_phone1 + reservation_user_phone2;
				String gstEmail = reservation_user_email1 + "@" + reservation_user_email2;
				String gstAddress = address + extraAddress + detailAddress;
				Guest guest = new Guest(gstName, gstEmail, gstPhone, gstBirth, gstGender, gstAddress);
				
				//게스트 정보 게스트 테이블에 추가
				int result = healthReservationService.insertGuest(guest);
				//성공
				if(result > 0) {
					session.setAttribute("Guest", guest);
					return "health_reservation/health_reservation2";
				//실패
				} else {
					return "health_reservation/health_reservation1";
				}
			}//로그인 유저 정보 있으면 유저번호 반환
			else {
				return "health_reservation/health_reservation2";
			}
		//이용약관 동의 안하면 원래 페이지 리턴	
		} else {
			return "health_reservation/health_reservation1";
		}
	}
	
	//
	@RequestMapping("/reservationSubmit")
	public String healthReservation3(@RequestParam String reservation_user_select,
	        @RequestParam String reservation_user_hospital,
	        @RequestParam String reservation_user_text,
	        @RequestParam String reservation_user_date,
	        @RequestParam String reservation_user_time,
	        @RequestParam String reservation_user_result,
	        HttpSession session,
	        RedirectAttributes redirectAttributes) {
		
		HealthReservation healthReservation = new HealthReservation();
		//날짜 받아온거 yyyy-mm-dd로 바꾸기
		String useDate = reservation_user_date.substring(6)
				   + "-" +reservation_user_date.substring(0,2)
				   + "-" +reservation_user_date.substring(3,5);
		
		healthReservation.setHosNo(reservation_user_hospital);
		healthReservation.setResDate(useDate);
		healthReservation.setResTime(reservation_user_time);
		healthReservation.setResCategory(reservation_user_select);
		healthReservation.setPatientResult(reservation_user_result);
		
		//로그인 한 경우
		if(session.getAttribute("loginUser")!=null) {
			Member m = (Member)session.getAttribute("loginUser");
			
			
			String userBirthDay = m.getBirthday().substring(2,4)
					   			+ m.getBirthday().substring(5,7)
					   			+ m.getBirthday().substring(8,10);
			
			healthReservation.setUserNo(m.getUserNo());
			healthReservation.setPatientName(m.getUserName());
			healthReservation.setPatientEmail(m.getEmail());
			healthReservation.setPatientBirthday(userBirthDay);
			healthReservation.setPatientGender(m.getGender());
			
		} //로그인 안한 경우 
		else {
			Guest g = (Guest)session.getAttribute("Guest");
			healthReservation.setGstNo(g.getGstNo());
			healthReservation.setPatientName(g.getGstName());
			healthReservation.setPatientEmail(g.getGstEmail());
			healthReservation.setPatientBirthday(g.getGstBirth());
			healthReservation.setPatientGender(g.getGstGender());
			//int result = healthReservationService.insertHealthReservation((int)session.getAttribute(""));
		}
		int result = healthReservationService.insertHealthReservation(healthReservation);
		redirectAttributes.addFlashAttribute("message","예약이 완료되었습니다");
		session.setAttribute("hResNo", healthReservation.getHResNo());
		System.out.println(healthReservation.getHResNo());
		return "main";
	}
	
	@GetMapping("/result")
	public String healthReservationResult() {
		return "health_reservation/health_reservation_result";
	}
	
	@GetMapping("/infoNomal")
	public String healthReservationInfoNomal() {
		return "health_reservation/health_reservation_info_nomal";
	}
	
	@GetMapping("/itemsInfo")
	public String healthReservationItems() {
		return "health_reservation/health_reservation_items_info";
	}
}



//}
