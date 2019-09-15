package com.byzx.authority.vo;

public class ProSku {
    private Integer skuId;

    private Integer proId;

    private Float inPrice;

    private Float sellPrice;

    private Float inventory;

    private String skuPic;

    private String state;

    private String dicids;

    public ProSku() {
    	
    }
    
    public ProSku(Integer skuId, Integer proId, Float inPrice, Float sellPrice, Float inventory, String skuPic,
			String state, String dicids) {
		super();
		this.skuId = skuId;
		this.proId = proId;
		this.inPrice = inPrice;
		this.sellPrice = sellPrice;
		this.inventory = inventory;
		this.skuPic = skuPic;
		this.state = state;
		this.dicids = dicids;
	}

	public Integer getSkuId() {
        return skuId;
    }

    public void setSkuId(Integer skuId) {
        this.skuId = skuId;
    }

    public Integer getProId() {
        return proId;
    }

    public void setProId(Integer proId) {
        this.proId = proId;
    }

    public Float getInPrice() {
        return inPrice;
    }

    public void setInPrice(Float inPrice) {
        this.inPrice = inPrice;
    }

    public Float getSellPrice() {
        return sellPrice;
    }

    public void setSellPrice(Float sellPrice) {
        this.sellPrice = sellPrice;
    }

    public Float getInventory() {
        return inventory;
    }

    public void setInventory(Float inventory) {
        this.inventory = inventory;
    }

    public String getSkuPic() {
        return skuPic;
    }

    public void setSkuPic(String skuPic) {
        this.skuPic = skuPic == null ? null : skuPic.trim();
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public String getDicids() {
        return dicids;
    }

    public void setDicids(String dicids) {
        this.dicids = dicids == null ? null : dicids.trim();
    }

	@Override
	public String toString() {
		return "ProSku [skuId=" + skuId + ", proId=" + proId + ", inPrice=" + inPrice + ", sellPrice=" + sellPrice
				+ ", inventory=" + inventory + ", skuPic=" + skuPic + ", state=" + state + ", dicids=" + dicids + "]";
	}









}