package com.byzx.authority.vo;

public class Place {
    private Integer placeId;

    private String placeName;

    private String placeNum;

    private String introduce;

    public Integer getPlaceId() {
        return placeId;
    }

    public void setPlaceId(Integer placeId) {
        this.placeId = placeId;
    }

    public String getPlaceName() {
        return placeName;
    }

    public void setPlaceName(String placeName) {
        this.placeName = placeName == null ? null : placeName.trim();
    }

    public String getPlaceNum() {
        return placeNum;
    }

    public void setPlaceNum(String placeNum) {
        this.placeNum = placeNum == null ? null : placeNum.trim();
    }

    public String getIntroduce() {
        return introduce;
    }

    public void setIntroduce(String introduce) {
        this.introduce = introduce == null ? null : introduce.trim();
    }
}