package com.ktds.concert.vo;

import javax.validation.constraints.NotEmpty;

public class ConcertVO {
	
	private String id;
	
	@NotEmpty(message="아티스트 명은 필수 입력값입니다.")
	private String artist;
	
	@NotEmpty(message="공연장소는 필수 입력값입니다.")
	private String location;
	
	@NotEmpty(message="공연일자은 필수 입력값입니다.")
	private String concertDay;
	
	@NotEmpty(message="사전예매일은 필수 입력값입니다.")
	private String advanceBookingDay;
	
	@NotEmpty(message="사전예매 url은 필수 입력값입니다.")
	private String advanceBookingURL;
	
	private String token;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getArtist() {
		return artist;
	}

	public void setArtist(String artist) {
		this.artist = artist;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getConcertDay() {
		return concertDay;
	}

	public void setConcertDay(String concertDay) {
		this.concertDay = concertDay;
	}

	public String getAdvanceBookingDay() {
		return advanceBookingDay;
	}

	public void setAdvanceBookingDay(String advanceBookingDay) {
		this.advanceBookingDay = advanceBookingDay;
	}

	public String getAdvanceBookingURL() {
		return advanceBookingURL;
	}

	public void setAdvanceBookingURL(String advanceBookingURL) {
		this.advanceBookingURL = advanceBookingURL;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}
}
