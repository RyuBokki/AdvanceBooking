package com.ktds.concert.vo;

public class ConcertVO {
	
	private String id;
	
	private String artist;
	
	private String location;
	
	private String concertDay;
	
	private String advanceBookingDay;
	
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
