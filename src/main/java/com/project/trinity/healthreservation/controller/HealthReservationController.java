package com.project.trinity.healthreservation.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import javax.xml.parsers.ParserConfigurationException;

import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.project.trinity.healthreservation.service.HealthReservationService;
import com.project.trinity.hospital.model.vo.HospitalInfo;
import com.project.trinity.hospital.service.HospitalService;
import com.project.trinity.member.model.vo.Guest;
import com.project.trinity.member.model.vo.Member;
import com.project.trinity.reservation.model.vo.HealthReservation;
import com.project.trinity.reservation.model.vo.Reservation;
import com.project.trinity.reservation.service.ReservationService;
import com.project.trinity.vaccine.model.vo.VaccineReservation;
import com.project.trinity.vaccine.service.VaccineReservationService;

@Controller
@RequestMapping("/healthReservation")
public class HealthReservationController {

	public static final String SERVICE_KEY = "VXOYqX%2F80IQ2amEj0mkyBE%2FkMJy9hoyp%2Fa04pKxBjmzaFpWcEpK%2BEXi8CelHfwnlWo%2BHlO7NZsLLgtVMwKvKQQ%3D%3D";

	@Autowired
	private HealthReservationService healthReservationService;
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private VaccineReservationService vaccineReservationService;
	@Autowired
	private HospitalService hospitalService;

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

	@RequestMapping("reservationSearch")
	public String ReservationSearch() {
		return "health_reservation/reservation_search_all";
	}

	@RequestMapping("reservationSearchAll")
	public String ReservationSearchAll(@RequestParam("reservationCategory") String reservationCategory,
			@RequestParam("resNo") String resNo, Model m) {
		
		switch (reservationCategory) {
		case "general":
			Reservation generealReservation = reservationService.selectReservation(resNo);
			if (generealReservation != null) {
				m.addAttribute("generealReservation", generealReservation);
				m.addAttribute("resNo", resNo);
			} else {
				m.addAttribute("rmessage", "예약 내역이 없습니다");
			}
			return "health_reservation/general_reservation_search_result";

		case "vaccine":
			VaccineReservation vaccineReservation = vaccineReservationService.selectReservation(resNo);
			if (vaccineReservation != null) {
				m.addAttribute("vaccineReservation", vaccineReservation);
				m.addAttribute("resNo", resNo);
			} else {
				m.addAttribute("rmessage", "예약 내역이 없습니다");
			}
			return "health_reservation/vaccine_reservation_search_result";

		case "health":
			HealthReservation healthReservation = healthReservationService.selectHealthReservation(resNo);
			// 예약날짜 뒤에 시간 짜르기
			if (healthReservation != null) {
				healthReservation.setResDate(healthReservation.getResDate().substring(0, 10));
				m.addAttribute("hResNo", resNo);
				m.addAttribute("healthReservation", healthReservation);
			} else {
				m.addAttribute("rmessage", "예약 내역이 없습니다");
			}
			return "health_reservation/health_reservation_search_result";

		default:
			break;
		}

		return "health_reservation/reservation_search_all";
	}

	// 예약조회
	@RequestMapping("/search")
	public String healthReservationSearch() {
		return "health_reservation/health_reservation_search";
	}

	// 예약번호 받아서 예약내용 조회
	@RequestMapping("/searchResult")
	public String healthReservationSearchResult(String hResNo, Model m) {
		HealthReservation healthReservation = healthReservationService.selectHealthReservation(hResNo);
		// 예약날짜 뒤에 시간 짜르기
		healthReservation.setResDate(healthReservation.getResDate().substring(0, 10));
		m.addAttribute("hResNo", hResNo);
		m.addAttribute("healthReservation", healthReservation);

		return "health_reservation/health_reservation_search_result";
	}

	// 건강검진 받는 사용자 정보 받아주는 컨트롤러
	@RequestMapping("/reservation2")
	public String healthReservation2(@RequestParam("reservation_user_name") String reservation_user_name,
			@RequestParam("reservation_user_num1") String reservation_user_num1,
			@RequestParam("reservation_user_num2") String reservation_user_num2,
			@RequestParam("reservation_user_phone1") String reservation_user_phone1,
			@RequestParam("reservation_user_phone2") String reservation_user_phone2,
			@RequestParam("reservation_user_email1") String reservation_user_email1,
			@RequestParam("reservation_user_email2") String reservation_user_email2,
			@RequestParam("postcode") String postcode, @RequestParam("address") String address,
			@RequestParam("extraAddress") String extraAddress, @RequestParam("detailAddress") String detailAddress,
			@RequestParam("use_tos_ans1") String use_tos_ans1, @RequestParam("use_tos_ans2") String use_tos_ans2,
			HttpSession session) {
		// 이용약관 두개 다 동의 한 경우만 다음 페이지 리턴
		if ((use_tos_ans1.equals("yes")) && (use_tos_ans1.equals("yes"))) {

			// 병원 정보 불러오기
			ArrayList<HospitalInfo> hospitalList = (ArrayList<HospitalInfo>) healthReservationService
					.selectHospitalList();
			session.setAttribute("hospitalList", hospitalList);
			String gstName = reservation_user_name;
			String gstBirth = reservation_user_num1;
			String gstGender = "";
			// 주민번호 뒷자리 홀수면 M, 짝수면 F로 반환
			if (Integer.parseInt(reservation_user_num2) % 2 == 0) {
				gstGender = "F";
			} else {
				gstGender = "M";
			}
			String gstPhone = reservation_user_phone1 + reservation_user_phone2;
			String gstEmail = reservation_user_email1 + "@" + reservation_user_email2;
			String gstAddress = address + extraAddress + detailAddress;
			// 로그인 유저 정보 없으면 게스트 저장하고 게스트 넘버 반환
			if (session.getAttribute("loginUser") == null) {
				Guest guest = new Guest(gstName, gstEmail, gstPhone, gstBirth, gstGender, gstAddress);

				// 게스트 정보 게스트 테이블에 추가
				int result = healthReservationService.insertGuest(guest);
				// 성공
				if (result > 0) {
					session.setAttribute("Guest", guest);
					return "health_reservation/health_reservation2";
					// 실패
				} else {
					return "health_reservation/health_reservation1";
				}
			} // 로그인 유저 정보 있으면 유저번호 반환
			else {
				Member m = new Member();
				m.setUserName(gstName);
				m.setBirthday(gstBirth);
				m.setGender(gstGender);
				m.setPhone(gstPhone);
				m.setEmail(gstEmail);
				m.setAddress(gstAddress);
				session.setAttribute("m", m);
				return "health_reservation/health_reservation2";
			}
			// 이용약관 동의 안하면 원래 페이지 리턴
		} else {
			return "health_reservation/health_reservation1";
		}
	}

	//healthReservation table에 들어가는 정보
	@RequestMapping("/reservationSubmit")
	public String healthReservation3(@RequestParam String reservation_user_select,
			@RequestParam String reservation_user_text, @RequestParam String reservation_user_date,
			@RequestParam String reservation_user_time, @RequestParam String reservation_user_result,
			HttpSession session, RedirectAttributes redirectAttributes) {
		System.out.println("session hosNo : " + (String) session.getAttribute("hosNo"));
		HealthReservation healthReservation = new HealthReservation();
		// 날짜 받아온거 yyyy-mm-dd로 바꾸기
		String useDate = reservation_user_date.substring(6) + "-" + reservation_user_date.substring(0, 2) + "-"
				+ reservation_user_date.substring(3, 5);

		healthReservation.setHosNo((String) session.getAttribute("hosNo"));
		healthReservation.setResDate(useDate);
		healthReservation.setResTime(reservation_user_time);
		healthReservation.setResCategory(reservation_user_select);
		healthReservation.setPatientResult(reservation_user_result);
		healthReservation.setResComment(reservation_user_text);
		// 로그인 한 경우
		if (session.getAttribute("loginUser") != null) {
			Member m = (Member) session.getAttribute("m");
			Member loginUser = (Member) session.getAttribute("loginUser");
			healthReservation.setUserNo(loginUser.getUserNo());
			healthReservation.setPatientName(m.getUserName());
			healthReservation.setPatientEmail(m.getEmail());
			healthReservation.setPatientBirthday(m.getBirthday());
			healthReservation.setPatientGender(m.getGender());

		} // 로그인 안한 경우
		else {
			Guest g = (Guest) session.getAttribute("Guest");
			healthReservation.setGstNo(g.getGstNo());
			healthReservation.setPatientName(g.getGstName());
			healthReservation.setPatientEmail(g.getGstEmail());
			healthReservation.setPatientBirthday(g.getGstBirth());
			healthReservation.setPatientGender(g.getGstGender());
			// int result =
			// healthReservationService.insertHealthReservation((int)session.getAttribute(""));
		}
		int result = healthReservationService.insertHealthReservation(healthReservation);
		redirectAttributes.addFlashAttribute("message", "예약이 완료되었습니다");
		session.setAttribute("hResNo", healthReservation.getHealthResNo());

		HealthReservation healthReservationResult = healthReservationService
				.selectHealthReservation(healthReservation.getHealthResNo());
		// 예약날짜 뒤에 시간 짜르기
		healthReservationResult.setResDate(healthReservationResult.getResDate().substring(0, 10));
		session.setAttribute("healthReservation", healthReservationResult);
		return "health_reservation/health_reservation_search_result";
	}

	@RequestMapping("/cancel")
	public String cancelHealthReservation(@RequestParam("healthResNo") String healthResNo, HttpSession session) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "redirect:/member/login"; // 로그인 페이지로 리다이렉트
		}

		int result = healthReservationService.cancelHealthReservation(healthResNo);
		if (result > 0) {
			session.setAttribute("message", "건강검진 예약이 취소되었습니다.");
		} else {
			session.setAttribute("message", "예약 취소에 실패했습니다.");
		}

		return "redirect:/member/healthreservationconfirmation"; // 건강검진 예약 확인 페이지로 리다이렉트
	}

	@GetMapping("/result")
	public String healthReservationResult() {
		return "health_reservation/health_reservation_result";
	}

	@GetMapping("/infoNomal")
	public String healthReservationInfoNomal() {
		return "health_reservation/health_reservation_info_nomal";
	}
	
	@GetMapping("/infoCancer")
	public String healthReservationInfoCancer() {
		return "health_reservation/health_reservation_info_cancer";
	}

	@GetMapping("/itemsInfo")
	public String healthReservationItems() {
		return "health_reservation/health_reservation_items_info";
	}

	private static String getTagValue(String tag, Element eElement) {
		NodeList nlList = (eElement).getElementsByTagName(tag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		if (nValue == null)
			return null;
		return nValue.getNodeValue();
	}

	//ajax로 병원 선택하면 DB에 저장하는거
	@ResponseBody
	@GetMapping("healthHospital")
	public void healthReservationHospital(@RequestParam("hosName") String hosName,
			@RequestParam("hosAddress") String hosAddress, @RequestParam("hosTel") String hosTel,
			@RequestParam("hosLatitude") String hosLatitude, @RequestParam("hosLongitude") String hosLongitude,
			HttpSession session) {
		HospitalInfo selectHosName = hospitalService.selectHosName(hosName);
		System.out.println("selectHosName : " + selectHosName);
		int result = 0;

		if (selectHosName == null) {
			HospitalInfo hInfo = new HospitalInfo();

			hInfo.setHosName(hosName);
			hInfo.setHosAddress(hosAddress);
			hInfo.setHosTel(hosTel);
			hInfo.setHosLatitude(hosLatitude);
			hInfo.setHosLongitude(hosLongitude);

			System.out.println(hInfo);
			result = hospitalService.insertHealthHospital(hInfo);
			session.setAttribute("hosNo", hInfo.getHosNo());
		} else {
			System.out.println(selectHosName);
			session.setAttribute("hosNo", selectHosName.getHosNo());
		}
	}

	// 건강검진 기관 조회
	@ResponseBody
	@GetMapping(value = "category", produces = "application/json; charset=UTF-8")
	public String healthReservationSearch(String category)
			throws IOException, ParserConfigurationException, SAXException {
		String url = "http://openapi1.nhis.or.kr/openapi/service/rest/HmcSearchService/getHchkTypesHmcList";
		url += "?serviceKey=" + SERVICE_KEY;
		url += "&hchType=" + URLEncoder.encode(category, "UTF-8");

		URL requestURL = new URL(url);

		HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();

		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");

		BufferedReader rd;

		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		StringBuilder sb = new StringBuilder();
		String line = "";

		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}

		rd.close();
		conn.disconnect();

		String result = xmlToJson(sb.toString());

		return result;
	}

	public static String xmlToJson(String str) {

		try {
			String xml = str;
			JSONObject jObject = XML.toJSONObject(xml);
			ObjectMapper mapper = new ObjectMapper();
			mapper.enable(SerializationFeature.INDENT_OUTPUT);
			Object json = mapper.readValue(jObject.toString(), Object.class);
			String output = mapper.writeValueAsString(json);
			return output;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}
}

//}