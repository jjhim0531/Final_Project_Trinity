package com.project.trinity.healthreservation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HealthReservationController {

	@GetMapping("health.guide")
	public String healthReservationGuide() {
		return "health_reservation/health_reservation_guide";
	}
	
	@GetMapping("caution_guide_even")
	public String cautionGuideEvening() {
		return "health_reservation/caution_guide_evening";
	}
	
	@GetMapping("caution_guide_d")
	public String cautionGuideDday() {
		return "health_reservation/caution_guide_dday";
	}
	
	@GetMapping("caution_guide_endo")
	public String cautionGuideEndoscope() {
		return "health_reservation/caution_guide_endoscope";
	}
	
	@GetMapping("caution_guide_ct")
	public String cautionGuideCtMri() {
		return "health_reservation/caution_guide_ct_mri";
	}
}
